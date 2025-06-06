import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:app_agenda_glam/core/theme/colors.dart';
import 'package:app_agenda_glam/core/animations/glam_animations.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/routes/routes/app_routes.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/widgets/main_scaffold.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/partners/data/models/partner_data.dart';
import 'package:app_agenda_glam/features/partners/presentation/widgets/partners_carousel.dart';
import 'package:app_agenda_glam/features/explore/domain/models/service_category.dart';
import 'package:app_agenda_glam/features/explore/domain/models/service.dart';
import 'package:app_agenda_glam/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:app_agenda_glam/features/explore/presentation/cubit/explore_state.dart';
import 'package:app_agenda_glam/features/explore/presentation/widgets/category_filter.dart';
import 'package:app_agenda_glam/features/explore/presentation/widgets/service_list.dart';

/// Página para explorar servicios y socios sin necesidad de registro
class ExplorePage extends StatelessWidget {
  /// Constructor de la página de exploración
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Proporcionamos el Cubit para la gestión de estado
    return BlocProvider(
      create: (_) => ExploreCubit(isUserLoggedIn: false),
      child: const _ExplorePageContent(),
    );
  }
}

/// Contenido principal de la página de exploración con estado
class _ExplorePageContent extends StatelessWidget {
  const _ExplorePageContent({super.key});
  
  /// Muestra los detalles de un servicio
  void _showServiceDetails(BuildContext context, Service service, bool isAvailable) {
    // Implementación mejorada para mostrar detalles del servicio
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isAvailable
              ? '${service.name}: Ver detalles y reservar'
              : '${service.name}: Requiere registro para reservar',
        ),
        duration: const Duration(seconds: 2),
        action: isAvailable ? null : SnackBarAction(
          label: 'Registrarse',
          onPressed: () {
            CircleNavigation.goToRegister(context);
          },
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 1, // Explorar es la segunda pestaña (índice 1)
      onTabChanged: (index) {
        // Navegar a la pestaña seleccionada usando GoRouter
        switch (index) {
          case 0:
            CircleNavigation.goToWelcome(context);
            break;
          case 1:
            // Ya estamos en la página de exploración
            break;
          case 2:
            // Ir a la página de Beneficios
            context.go(AppRoutes.benefits);
            break;
          case 3:
            // Ir a la página de Perfil
            context.go(AppRoutes.profile);
            break;
        }
      },
      body: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) {
          return state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message', style: const TextStyle(color: Colors.white))),
            loaded: (allServices, categories, filteredServices, selectedCategory, isUserLoggedIn) {
              return _ExploreContent(
                allServices: allServices,
                categories: categories,
                filteredServices: filteredServices,
                selectedCategory: selectedCategory,
                isUserLoggedIn: isUserLoggedIn,
                onCategorySelected: (category) {
                  context.read<ExploreCubit>().filterByCategory(category);
                },
                onServiceTap: (service) {
                  final isAvailable = service.availableWithoutRegistration || isUserLoggedIn;
                  _showServiceDetails(context, service, isAvailable);
                },
              );
            }
          );
        },
      ),
    );
  }
}

/// Contenido principal de la página de exploración
class _ExploreContent extends StatelessWidget {
  /// Lista completa de servicios
  final List<Service> allServices;
  
  /// Lista de categorías
  final List<ServiceCategory> categories;
  
  /// Lista de servicios filtrados
  final List<Service> filteredServices;
  
  /// Categoría seleccionada actualmente (puede ser nula)
  final ServiceCategory? selectedCategory;
  
  /// Indica si el usuario está autenticado
  final bool isUserLoggedIn;
  
  /// Callback cuando se selecciona una categoría
  final Function(ServiceCategory?) onCategorySelected;
  
  /// Callback cuando se selecciona un servicio
  final Function(Service) onServiceTap;

  const _ExploreContent({
    super.key,
    required this.allServices,
    required this.categories,
    required this.filteredServices,
    required this.onCategorySelected,
    required this.onServiceTap,
    this.selectedCategory,
    this.isUserLoggedIn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo con gradiente
        const GlamGradientBackground(
          showBouncingCircle: true,
        ),
        
        // Contenido principal
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra superior con título y botón de registro
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Título de la sección
                    Text(
                      'Explorar',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Botón de registro - solo visible si el usuario no está autenticado
                    if (!isUserLoggedIn)
                      TextButton.icon(
                        onPressed: () {
                          CircleNavigation.goToRegister(context);
                        },
                        icon: const Icon(
                          Icons.person_add_rounded,
                          color: kAccentColor,
                          size: 20,
                        ),
                        label: const Text(
                          'Registrarse',
                          style: TextStyle(
                            color: kAccentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              
              // Contenido desplazable
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sección de bienvenida con mensaje adaptado según estado de autenticación
                      _buildSectionTitle(context, isUserLoggedIn ? 'Servicios para ti' : 'Explora nuestra app'),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          isUserLoggedIn
                              ? 'Encuentra y reserva los mejores servicios de estética masculina.'
                              : 'Descubre los mejores servicios de estética masculina sin necesidad de registrarte.',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorUtils.withOpacityValue(Colors.white, 0.8),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Sección de socios destacados
                      _buildSectionTitle(context, 'Socios destacados'),
                      const SizedBox(height: 16),
                      // Usar el mismo carrusel de socios que en la página de bienvenida
                      PartnersCarousel(
                        partners: PartnerData.getSamplePartners(),
                        height: 200,
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Filtro de categorías
                      CategoryFilter(
                        categories: categories,
                        selectedCategory: selectedCategory,
                        onCategorySelected: onCategorySelected,
                      ),
                      const SizedBox(height: 24),
                      
                      // Sección de servicios (filtrados o populares)
                      _buildSectionTitle(
                        context, 
                        selectedCategory != null 
                            ? 'Servicios de ${selectedCategory!.name}'
                            : 'Todos los servicios'
                      ),
                      const SizedBox(height: 16),
                      
                      // Lista de servicios filtrados con indicadores visuales
                      if (filteredServices.isNotEmpty)
                        ServiceList(
                          services: filteredServices,
                          isUserLoggedIn: isUserLoggedIn,
                          onServiceSelected: onServiceTap,
                        ),
                      
                      // Si no hay servicios filtrados, mostrar mensaje
                      if (filteredServices.isEmpty)
                        _buildEmptyServicesMessage(context),
                      
                      const SizedBox(height: 32),
                      
                      // Sección de llamada a la acción - solo visible si el usuario no está autenticado
                      if (!isUserLoggedIn)
                        _buildCallToAction(context),
                      
                      // Espacio adicional al final
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

  /// Construye un mensaje cuando no hay servicios disponibles
  Widget _buildEmptyServicesMessage(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: Colors.white54,
            ),
            const SizedBox(height: 16),
            const Text(
              'No se encontraron servicios',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Intenta con otra categoría o verifica tus filtros',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Construye un título de sección con animación
  Widget _buildSectionTitle(BuildContext context, String title) {
    return GlamAnimations.applyEntryEffect(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  

  
  /// Construye la sección de llamada a la acción
  Widget _buildCallToAction(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: ColorUtils.withOpacityValue(kSurfaceColor, 0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: kAccentColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Listo para reservar tu cita?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Regístrate para acceder a todas las funcionalidades y reservar tus citas en los mejores lugares.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 16),
            GlamButton(
              text: 'Crear cuenta gratis',
              onPressed: () {
                // Navegar a la página de registro
                CircleNavigation.goToRegister(context);
              },
              icon: Icons.person_add_rounded,
              withShimmer: true,
            ),
          ],
        ),
      ),
    );
  }