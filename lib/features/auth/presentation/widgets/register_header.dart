import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:flutter/material.dart';

/// Widget de encabezado para la pÃ¡gina de registro
/// Muestra el tÃ­tulo y subtÃ­tulo segÃºn el paso actual
class RegisterHeader extends StatelessWidget {
  /// Paso actual del registro
  final int currentStep;

  const RegisterHeader({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String title =
        currentStep == 1 ? 'Crea tu cuenta' : 'Configura tu contraseÃ±a';

    final String subtitle =
        currentStep == 1
            ? 'Ingresa tus datos para comenzar'
            : 'Elige una contraseÃ±a segura';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TÃ­tulo con animaciÃ³n
        GlamAnimations.applyEntryEffect(
          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          slideDistance: 0.08,
        ),
        const SizedBox(height: 8),

        // SubtÃ­tulo con animaciÃ³n
        GlamAnimations.applyEntryEffect(
          Text(
            subtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          slideDistance: 0.1,
        ),
      ],
    );
  }
}
