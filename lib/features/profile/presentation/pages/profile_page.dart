import 'package:app_agenda_glam/core/routes/routes/app_routes.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

/// Página de perfil que muestra opciones de inicio de sesión y registro
/// para usuarios no autenticados, y que actuará como puerta de entrada
/// a la funcionalidad completa de la aplicación.
class ProfilePage extends StatelessWidget {
  /// Constructor de la página de perfil
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // AppBar personalizado con título centrado
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              floating: true,
              title: Text(
                'Tu Perfil',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            
            // Contenido principal
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar de usuario y mensaje de bienvenida
                    _buildProfileHeader(context),
                    
                    const SizedBox(height: 40),
                    
                    // Opciones de inicio de sesión y registro
                    _buildAuthOptions(context),
                    
                    const SizedBox(height: 40),
                    
                    // Características desbloqueadas con el registro
                    _buildFeaturesSection(context),
                    
                    const SizedBox(height: 40),
                    
                    // Preguntas frecuentes
                    _buildFAQSection(context),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Construye el encabezado del perfil con avatar y mensaje de bienvenida
  Widget _buildProfileHeader(BuildContext context) {
    return Column(
      children: [
        // Avatar circular con borde dorado
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: kAccentColor,
              width: 2,
            ),
            color: ColorUtils.withOpacityValue(kSurfaceColor, 0.7),
          ),
          child: const Center(
            child: Icon(
              Icons.person_rounded,
              size: 60,
              color: kAccentColor,
            ),
          ),
        )
        .animate()
        .fade(duration: const Duration(milliseconds: 800))
        .scale(
          begin: const Offset(0.8, 0.8), 
          end: const Offset(1, 1),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutBack,
        ),
        
        const SizedBox(height: 20),
        
        // Mensaje de bienvenida
        Text(
          '¡Bienvenido a Agenda Glam!',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 200),
        ),
        
        const SizedBox(height: 10),
        
        Text(
          'Accede a tu cuenta para desbloquear todas las funcionalidades de la aplicación',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ColorUtils.withOpacityValue(Colors.white, 0.8),
          ),
          textAlign: TextAlign.center,
        )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 400),
        ),
      ],
    );
  }
  
  /// Construye las opciones de inicio de sesión y registro
  Widget _buildAuthOptions(BuildContext context) {
    return Column(
      children: [
        // Botón de inicio de sesión
        GlamButton(
          text: 'Iniciar Sesión',
          onPressed: () {
            context.go(AppRoutes.login);
          },
          icon: Icons.login_rounded,
          withShimmer: true,
        )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 600),
        )
        .slideY(
          begin: 0.2,
          end: 0,
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 600),
        ),
        
        const SizedBox(height: 16),
        
        // Botón de registro
        GlamButton(
          text: 'Crear Cuenta',
          onPressed: () {
            context.go(AppRoutes.register);
          },
          isSecondary: true,
          icon: Icons.person_add_rounded,
        )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 800),
        )
        .slideY(
          begin: 0.2,
          end: 0,
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 800),
        ),
        
        const SizedBox(height: 20),
        
        // Mensaje informativo
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: ColorUtils.withOpacityValue(kSurfaceColor, 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: ColorUtils.withOpacityValue(kAccentColor, 0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: kAccentColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Puedes seguir explorando la aplicación sin necesidad de crear una cuenta',
                  style: TextStyle(
                    color: ColorUtils.withOpacityValue(Colors.white, 0.9),
                  ),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 1000),
        ),
      ],
    );
  }
  
  /// Construye la sección de características desbloqueadas con el registro
  Widget _buildFeaturesSection(BuildContext context) {
    // Lista de características disponibles con registro
    final features = [
      {
        'title': 'Reserva de Citas',
        'description': 'Agenda tus servicios favoritos con los mejores profesionales',
        'icon': Icons.calendar_month_rounded,
      },
      {
        'title': 'Historial Personalizado',
        'description': 'Accede a tu historial de servicios y preferencias',
        'icon': Icons.history_rounded,
      },
      {
        'title': 'Notificaciones',
        'description': 'Recibe recordatorios y ofertas exclusivas',
        'icon': Icons.notifications_rounded,
      },
      {
        'title': 'Valoraciones',
        'description': 'Comparte tu opinión sobre los servicios recibidos',
        'icon': Icons.star_rounded,
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Características que desbloquearás',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 1200),
        ),
        
        const SizedBox(height: 16),
        
        // Lista de características
        ...features.asMap().entries.map((entry) {
          final index = entry.key;
          final feature = entry.value;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorUtils.withOpacityValue(kSurfaceColor, 0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorUtils.withOpacityValue(kAccentColor, 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: ColorUtils.withOpacityValue(kAccentColor, 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      feature['icon'] as IconData,
                      color: kAccentColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        feature['description'] as String,
                        style: TextStyle(
                          color: ColorUtils.withOpacityValue(Colors.white, 0.8),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Icono de candado para indicar que está bloqueado
                const Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white70,
                  size: 20,
                ),
              ],
            ),
          )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 800),
            delay: Duration(milliseconds: 1200 + ((index + 1) * 200)),
          )
          .slideX(
            begin: 0.1,
            end: 0,
            duration: const Duration(milliseconds: 800),
            delay: Duration(milliseconds: 1200 + ((index + 1) * 200)),
          );
        }).toList(),
      ],
    );
  }
  
  /// Construye la sección de preguntas frecuentes
  Widget _buildFAQSection(BuildContext context) {
    final faqs = [
      {
        'question': '¿Es gratis crear una cuenta?',
        'answer': 'Sí, crear una cuenta en Agenda Glam es completamente gratuito.',
      },
      {
        'question': '¿Qué información necesito para registrarme?',
        'answer': 'Solo necesitas un correo electrónico válido y crear una contraseña segura.',
      },
      {
        'question': '¿Puedo eliminar mi cuenta después?',
        'answer': 'Sí, puedes eliminar tu cuenta y tus datos en cualquier momento desde la configuración de tu perfil.',
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preguntas frecuentes',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 800),
          delay: const Duration(milliseconds: 2200),
        ),
        
        const SizedBox(height: 16),
        
        // Lista de preguntas frecuentes
        ...faqs.asMap().entries.map((entry) {
          final index = entry.key;
          final faq = entry.value;
          
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorUtils.withOpacityValue(kSurfaceColor, 0.4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pregunta
                Text(
                  faq['question'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                // Respuesta
                Text(
                  faq['answer'] as String,
                  style: TextStyle(
                    color: ColorUtils.withOpacityValue(Colors.white, 0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 800),
            delay: Duration(milliseconds: 2200 + ((index + 1) * 200)),
          );
        }).toList(),
      ],
    );
  }
}
