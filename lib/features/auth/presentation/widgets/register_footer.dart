import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Footer para la página de registro con enlace a inicio de sesión
class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GlamAnimations.applyEntryEffect(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¿Ya tienes una cuenta?',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          TextButton(
            onPressed: () => context.go(AppRouter.login),
            child: Text(
              'Inicia sesión',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: kAccentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      slideDistance: 0.2,
    );
  }
}
