import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/action_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';

/// Componente modular que muestra las llamadas a la acción en la página de bienvenida,
/// adaptadas según el estado de autenticación del usuario.
class WelcomeActions extends StatelessWidget {
  /// Callback para navegar a la pantalla de exploración
  final VoidCallback onExplorePressed;
  
  /// Callback para navegar a la pantalla de perfil o iniciar proceso de autenticación
  final VoidCallback onProfileOrAuthPressed;
  
  /// Callback para navegar a la pantalla de beneficios
  final VoidCallback onBenefitsPressed;

  /// Constructor del widget con callbacks de navegación requeridos
  const WelcomeActions({
    super.key,
    required this.onExplorePressed,
    required this.onProfileOrAuthPressed,
    required this.onBenefitsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final bool isAuthenticated = authState.status == AuthStatus.authenticated;
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Título de sección
              GlamAnimations.applyEntryEffect(
                const Text(
                  'DESCUBRE AGENDA GLAM',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                slideDistance: 0.2,
                duration: const Duration(milliseconds: 800),
              ),
              
              const SizedBox(height: 8),
              
              // Subtítulo adaptativo según el estado de autenticación
              GlamAnimations.applyEntryEffect(
                Text(
                  isAuthenticated 
                      ? 'Continúa tu experiencia personalizada' 
                      : 'Explora sin registro o crea tu cuenta para acceder a todos los beneficios',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                slideDistance: 0.2,
                duration: const Duration(milliseconds: 850),
              ),
              
              const SizedBox(height: 24),
              
              // Tarjetas de acción adaptativas
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tarjeta principal: Explorar catálogo
                  Expanded(
                    child: GlamAnimations.applyEntryEffect(
                      ActionCard.fromColor(
                        icon: Icons.explore,
                        title: 'EXPLORA',
                        subtitle: 'Descubre servicios',
                        onTap: onExplorePressed,
                        gradientColors: const [Color(0xFF8E24AA), Color(0xFFAB47BC)],
                        gradientBegin: Alignment.topLeft,
                        gradientEnd: Alignment.bottomRight,
                      ),
                      slideDistance: 0.3,
                      duration: const Duration(milliseconds: 900),
                    ),
                  ),
                  
                  const SizedBox(width: 16),
                  
                  // Tarjeta secundaria: Perfil o Registro según estado
                  Expanded(
                    child: GlamAnimations.applyEntryEffect(
                      ActionCard.fromColor(
                        icon: isAuthenticated ? Icons.person : Icons.login,
                        title: isAuthenticated ? 'PERFIL' : 'ÚNETE',
                        subtitle: isAuthenticated ? 'Tu espacio' : 'Personaliza',
                        onTap: onProfileOrAuthPressed,
                        gradientColors: isAuthenticated
                            ? const [Color(0xFF00897B), Color(0xFF26A69A)]
                            : const [Color(0xFF1976D2), Color(0xFF42A5F5)],
                        gradientBegin: Alignment.topLeft,
                        gradientEnd: Alignment.bottomRight,
                      ),
                      slideDistance: 0.3,
                      duration: const Duration(milliseconds: 950),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Botón de beneficios
              GlamAnimations.applyEntryEffect(
                GestureDetector(
                  onTap: onBenefitsPressed,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: kAccentColor.withValues(alpha: 0.5), width: 1.5),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.3),
                          Colors.black.withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: kAccentColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'DESCUBRE NUESTROS BENEFICIOS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                slideDistance: 0.2,
                duration: const Duration(milliseconds: 1000),
              ),
            ],
          ),
        );
      },
    );
  }
}
