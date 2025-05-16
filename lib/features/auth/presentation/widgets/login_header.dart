import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_icon_container.dart';
import 'package:flutter/material.dart';

/// Widget que encapsula el encabezado de la página de login
/// Incluye el logo, título y descripción
class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: size.height * 0.05),
        
        // Título de la página
        GlamAnimations.applyEntryEffect(
          Text(
            'Iniciar Sesión',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          slideDistance: 0.1,
        ),
        
        const SizedBox(height: 24),
        
        // Icono representativo de login
        const GlamIconContainer(
          icon: Icons.person_outline,
          size: 100,
          enableShimmer: true,
          animateEntry: true,
        ),
        
        const SizedBox(height: 24),
        
        // Descripción
        GlamAnimations.applyEntryEffect(
          Text(
            'Accede a tu cuenta para gestionar tus citas y servicios',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
          slideDistance: 0.15,

        ),
        
        SizedBox(height: size.height * 0.06),
      ],
    );
  }
}
