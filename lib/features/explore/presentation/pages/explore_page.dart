import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/partners/data/models/partner_data.dart';
import 'package:app_agenda_glam/features/partners/presentation/widgets/partners_carousel.dart';
import 'package:flutter/material.dart';

/// Página que permite a usuarios sin registro explorar la aplicación
/// y ver algunos de los socios y servicios disponibles
class ExplorePage extends StatelessWidget {
  /// Constructor de la página de exploración
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo transparente porque usamos nuestro propio fondo
      backgroundColor: Colors.transparent,
      // Utilizando un Stack para mantener el fondo consistente
      body: Stack(
        children: [
          // Fondo con gradiente azul
          const GlamGradientBackground(
            showBouncingCircle: true,
          ),
          
          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                // AppBar personalizado
                AppBar(
                  title: const Text('Explorar'),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    // Botón de registro en la esquina superior derecha
                    TextButton.icon(
                      onPressed: () {
                        // Navegar a la página de registro
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
                
                // Contenido desplazable
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sección de bienvenida
                        _buildSectionTitle(context, 'Explora nuestra app'),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            'Descubre los mejores servicios de estética masculina sin necesidad de registrarte.',
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
                        
                        // Sección de servicios populares
                        _buildSectionTitle(context, 'Servicios populares'),
                        const SizedBox(height: 16),
                        _buildPopularServices(context),
                        
                        const SizedBox(height: 32),
                        
                        // Sección de llamada a la acción
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
  
  /// Construye la sección de servicios populares
  Widget _buildPopularServices(BuildContext context) {
    // Lista de servicios populares
    final popularServices = [
      {'name': 'Corte de pelo', 'icon': Icons.content_cut},
      {'name': 'Barba', 'icon': Icons.face},
      {'name': 'Facial', 'icon': Icons.spa},
      {'name': 'Coloración', 'icon': Icons.color_lens},
    ];
    
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: popularServices.length,
        itemBuilder: (context, index) {
          final service = popularServices[index];
          
          return GlamAnimations.applyEntryEffect(
            Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: ColorUtils.withOpacityValue(kSurfaceColor, 0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    service['icon'] as IconData,
                    color: kAccentColor,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service['name'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Usamos duración manual para escalonar los elementos
            duration: Duration(milliseconds: 600 + (100 * index)),
          );
        },
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
            color: ColorUtils.withOpacityValue(kAccentColor, 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '¿Listo para reservar tu cita?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Regístrate para acceder a todas las funcionalidades de la aplicación y reservar tu próxima cita.',
              style: TextStyle(
                fontSize: 16,
                color: ColorUtils.withOpacityValue(Colors.white, 0.9),
              ),
            ),
            const SizedBox(height: 16),
            GlamButton(
              text: 'Crear cuenta',
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
}