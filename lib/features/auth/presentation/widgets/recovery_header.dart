import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_icon_container.dart';
import 'package:flutter/material.dart';

/// Widget que encapsula el encabezado de la página de recuperación de contraseña
/// Incluye el logo, título y descripción
class RecoveryHeader extends StatelessWidget {
  const RecoveryHeader({super.key});

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
            'Recuperar contraseña',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          slideDistance: 0.1,
        ),
        
        const SizedBox(height: 24),
        
        // Icono representativo de recuperación
        const GlamIconContainer(
          icon: Icons.autorenew_rounded,
          size: 100,
          enableShimmer: true,
          animateEntry: true,
        ),
        
        const SizedBox(height: 24),
        
        // Descripción
        GlamAnimations.applyEntryEffect(
          Text(
            'Ingresa tu correo electrónico para recibir instrucciones de recuperación',
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