import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/routes/app_routes.dart';
import 'package:app_agenda_glam/core/widgets/main_scaffold.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_video_background.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/welcome_components/featured_partners_section.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/welcome_components/parallax_background.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/welcome_components/welcome_actions.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/welcome_components/welcome_header.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Página de bienvenida refactorizada que muestra opciones para login o registro
/// con diseño visual mejorado y animaciones fluidas, siguiendo los principios
/// de Clean Architecture y modularización.
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Controlador para animación del fondo parallax
  final _parallaxController = ParallaxController();
  
  // Variables para detectar movimiento y activar efecto parallax
  final ValueNotifier<Offset> _pointerPosition = ValueNotifier<Offset>(Offset.zero);
  
  @override
  void initState() {
    super.initState();
    // Iniciar escucha de posición del puntero para efecto parallax
    _pointerPosition.addListener(_updateParallaxEffect);
  }
  
  @override
  void dispose() {
    // Limpiar recursos al salir
    _pointerPosition.removeListener(_updateParallaxEffect);
    _pointerPosition.dispose();
    _parallaxController.dispose();
    super.dispose();
  }
  
  // Actualizar efecto parallax basado en la posición del puntero
  void _updateParallaxEffect() {
    // Normalizar valores entre -1 y 1 para efecto sutil
    _parallaxController.updateOffset(
      (_pointerPosition.value.dx / MediaQuery.of(context).size.width - 0.5) * 2,
      (_pointerPosition.value.dy / MediaQuery.of(context).size.height - 0.5) * 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el tamaño de la pantalla para cálculos responsivos
    final Size screenSize = MediaQuery.of(context).size;
    final double topPadding = screenSize.height * 0.08; // 8% del alto de la pantalla
    
    // Verificamos en qué ruta estamos para determinar el índice de la navegación
    String currentLocation = GoRouterState.of(context).uri.path;
    int currentIndex = 0; // Por defecto, estamos en Home/Welcome
    
    if (currentLocation.startsWith('/explore')) {
      currentIndex = 1;
    } else if (currentLocation.startsWith('/benefits')) {
      currentIndex = 2;
    } else if (currentLocation.startsWith('/profile')) {
      currentIndex = 3;
    }
    
    return MainScaffold(
      currentIndex: currentIndex,
      onTabChanged: _handleTabChanged,
      body: MouseRegion(
        onHover: (event) {
          // Actualizar posición del puntero para efecto parallax
          _pointerPosition.value = event.position;
        },
        child: Stack(
          children: [
            // Fondo con efecto parallax mejorado
            ParallaxBackground(
              controller: _parallaxController,
              child: const GlamVideoBackground(
                videoAsset: 'assets/videos/welcome_background.mp4',
                gradientOpacity: 0.85, // Ligero ajuste para mayor contraste
              ),
            ),
            
            // Overlay con degradado radial para efecto spotlight
            Positioned.fill(
              child: GlamAnimations.applyEntryEffect(
                Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0.0, -0.3), // Centrado hacia arriba
                      radius: 1.5,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                      stops: const [0.1, 1.0],
                    ),
                  ),
                ),
                slideDistance: 0.2,
                duration: const Duration(seconds: 1),
              ),
            ),
            
            // Contenido principal con scroll
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  top: topPadding,
                  bottom: MediaQuery.of(context).padding.bottom + 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Encabezado con logo y título
                    const WelcomeHeader(),
                    
                    const SizedBox(height: 40),
                    
                    // Acciones y llamadas a la acción
                    WelcomeActions(
                      onExplorePressed: () {
                        context.go(AppRoutes.explore);
                      },
                      onProfileOrAuthPressed: () {
                        final String currentPath = GoRouterState.of(context).uri.path;
                        // Si ya estamos autenticados, ir al perfil, sino iniciar proceso de auth
                        if (currentPath.startsWith('/profile')) {
                          // Ya estamos en profile, no necesitamos hacer nada
                          return;
                        }
                        
                        // Utilizar el AuthCubit para manejar el flujo de autenticación
                        // Este ya tiene la lógica para redireccionar según estado actual
                        final authCubit = context.read<AuthCubit>();
                        authCubit.handleAuthRequiredFeature(context);
                      },
                      onBenefitsPressed: () {
                        context.go(AppRoutes.benefits);
                      },
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Sección de socios destacados
                    const FeaturedPartnersSection(),
                    
                    // Espacio para evitar que el contenido quede debajo de la barra de navegación
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Manejar cambios de tab en la navegación inferior
  void _handleTabChanged(int index) {
    final List<String> routes = [
      AppRoutes.home,
      AppRoutes.explore,
      AppRoutes.benefits,
      AppRoutes.profile,
    ];
    
    if (index >= 0 && index < routes.length) {
      context.go(routes[index]);
    }
  }
}
