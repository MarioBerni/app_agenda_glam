import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';

/// Footer para la página de registro con enlace a inicio de sesión
/// Alineado visualmente con el enlace de la página de login para mantener coherencia
class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    // Aplicamos la misma animación y parámetros que el enlace en LoginPage
    return GlamAnimations.applyEntryEffect(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¿Ya tienes una cuenta?',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
          TextButton(
            onPressed: () => CircleNavigation.goToLogin(context),
            child: const Text(
              'Iniciar Sesión',
              style: TextStyle(
                color: kAccentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      slideDistance: 0.25, // Ajustado para coincidir con LoginPage
    );
  }
}
