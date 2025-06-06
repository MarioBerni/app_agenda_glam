import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Página que muestra los beneficios de usar la aplicación Agenda Glam.
/// 
/// Esta página está diseñada para usuarios no registrados, presentando
/// las ventajas de la aplicación de manera atractiva para incentivar
/// la conversión y el registro.
class BenefitsPage extends StatelessWidget {
  /// Constructor de la página de beneficios
  const BenefitsPage({super.key});

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
                'Beneficios',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              actions: [
                // Botón de registro en la esquina superior derecha
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
            
            // Contenido principal
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Texto introductorio
                    Text(
                      '¿Por qué elegir Agenda Glam?',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                    .animate()
                    .fade(duration: const Duration(milliseconds: 800))
                    .slideY(begin: 0.2, end: 0, duration: const Duration(milliseconds: 800)),
                    
                    const SizedBox(height: 16),
                    
                    Text(
                      'Descubre cómo nuestra plataforma está transformando la experiencia de cuidado personal para hombres en Uruguay.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: ColorUtils.withOpacityValue(Colors.white, 0.8),
                      ),
                    )
                    .animate()
                    .fade(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 300),
                    )
                    .slideY(
                      begin: 0.2, 
                      end: 0, 
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 300),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Sección de beneficios para clientes
                    _buildBenefitSection(
                      context: context,
                      title: 'Para Clientes',
                      icon: Icons.person,
                      benefits: const [
                        'Reserva citas de forma rápida y sencilla',
                        'Accede a los mejores profesionales en un solo lugar',
                        'Recibe recordatorios automáticos de tus citas',
                        'Gestiona tu historial de servicios y preferencias',
                        'Califica y revisa los servicios recibidos',
                      ],
                      delay: 0,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Sección de beneficios para negocios
                    _buildBenefitSection(
                      context: context,
                      title: 'Para Negocios',
                      icon: Icons.store,
                      benefits: const [
                        'Aumenta la visibilidad de tu negocio',
                        'Gestiona tu agenda de forma eficiente',
                        'Reduce las cancelaciones y faltas',
                        'Accede a estadísticas detalladas',
                        'Fideliza a tus clientes con un mejor servicio',
                      ],
                      delay: 200,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Sección de beneficios para profesionales
                    _buildBenefitSection(
                      context: context,
                      title: 'Para Profesionales',
                      icon: Icons.badge,
                      benefits: const [
                        'Organiza tu día de trabajo eficientemente',
                        'Construye tu portafolio de servicios',
                        'Recibe valoraciones de tus clientes',
                        'Aumenta tu visibilidad profesional',
                        'Gestiona tus ingresos de forma transparente',
                      ],
                      delay: 400,
                    ),
                    
                    const SizedBox(height: 48),
                    
                    // Sección de testimonios
                    _buildTestimonialSection(context),
                    
                    const SizedBox(height: 48),
                    
                    // Llamada a la acción final
                    _buildCallToAction(context),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Construye una sección de beneficios con un título, icono y lista de ventajas
  Widget _buildBenefitSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<String> benefits,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          // Encabezado con icono y título
          Row(
            children: [
              Icon(
                icon,
                color: kAccentColor,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Lista de beneficios
          ...benefits.asMap().entries.map((entry) {
            final index = entry.key;
            final benefit = entry.value;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: kAccentColor,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      benefit,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorUtils.withOpacityValue(Colors.white, 0.9),
                      ),
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .fade(
              duration: const Duration(milliseconds: 600),
              delay: Duration(milliseconds: delay + (index * 100)),
            )
            .slideX(
              begin: 0.1,
              end: 0,
              duration: const Duration(milliseconds: 600),
              delay: Duration(milliseconds: delay + (index * 100)),
            );
          }),
        ],
      ),
    )
    .animate()
    .fade(
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: delay),
    )
    .scale(
      begin: const Offset(0.95, 0.95),
      end: const Offset(1, 1),
      duration: const Duration(milliseconds: 800),
      delay: Duration(milliseconds: delay),
    );
  }
  
  /// Construye una sección de testimonios con citas de usuarios satisfechos
  Widget _buildTestimonialSection(BuildContext context) {
    final testimonials = [
      {
        'name': 'Martín S.',
        'role': 'Cliente',
        'text': 'Agenda Glam ha simplificado completamente la forma en que reservo mis citas de barbería. ¡Ahora puedo concentrarme en lucir bien sin preocuparme por la logística!',
      },
      {
        'name': 'Fernando R.',
        'role': 'Propietario de Barbería',
        'text': 'Desde que implementamos Agenda Glam, hemos reducido las cancelaciones en un 60% y aumentado nuestra clientela regular. Una herramienta indispensable para nuestro negocio.',
      },
      {
        'name': 'Diego M.',
        'role': 'Estilista',
        'text': 'Como profesional independiente, Agenda Glam me ha permitido organizar mejor mi tiempo y construir una base de clientes fieles. ¡Excelente plataforma!',
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Lo que dicen nuestros usuarios',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
        .animate()
        .fade(duration: const Duration(milliseconds: 800))
        .slideY(begin: 0.2, end: 0, duration: const Duration(milliseconds: 800)),
        
        const SizedBox(height: 20),
        
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: testimonials.length,
            itemBuilder: (context, index) {
              final testimonial = testimonials[index];
              
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(20),
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
                    Row(
                      children: [
                        // Avatar o placeholder si no hay imagen disponible
                        CircleAvatar(
                          backgroundColor: kAccentColor,
                          radius: 20,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Información del usuario
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              testimonial['name'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              testimonial['role'] as String,
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorUtils.withOpacityValue(Colors.white, 0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Texto del testimonio
                    Expanded(
                      child: Text(
                        testimonial['text'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
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
                delay: Duration(milliseconds: 600 + (index * 200)),
              )
              .slideX(
                begin: 0.2,
                end: 0,
                duration: const Duration(milliseconds: 800),
                delay: Duration(milliseconds: 600 + (index * 200)),
              );
            },
          ),
        ),
      ],
    );
  }
  
  /// Construye una sección de llamada a la acción para incentivar el registro
  Widget _buildCallToAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorUtils.withOpacityValue(kPrimaryColor, 0.8),
            ColorUtils.withOpacityValue(kAccentColor, 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.star_rounded,
            color: Colors.white,
            size: 48,
          )
          .animate()
          .fade(duration: const Duration(milliseconds: 1000))
          .scale(
            begin: const Offset(0.5, 0.5),
            end: const Offset(1, 1),
            duration: const Duration(milliseconds: 1000),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            '¡Únete a Agenda Glam hoy!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 300),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Crea tu cuenta gratis y comienza a disfrutar de todos los beneficios de la plataforma de estética masculina más completa de Uruguay.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 500),
          ),
          
          const SizedBox(height: 24),
          
          GlamButton(
            text: 'Crear cuenta gratis',
            onPressed: () {
              CircleNavigation.goToRegister(context);
            },
            icon: Icons.person_add_rounded,
            withShimmer: true,
            isSecondary: true,
          )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 700),
          )
          .scale(
            begin: const Offset(0.9, 0.9),
            end: const Offset(1, 1),
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 700),
          ),
          
          const SizedBox(height: 12),
          
          TextButton(
            onPressed: () {
              CircleNavigation.goToLogin(context);
            },
            child: const Text(
              'Ya tengo cuenta - Iniciar sesión',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          )
          .animate()
          .fade(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 900),
          ),
        ],
      ),
    )
    .animate()
    .fade(
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 800),
    )
    .slideY(
      begin: 0.2,
      end: 0,
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 800),
    );
  }
}
