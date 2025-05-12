import 'package:flutter/material.dart';

/// Widget que muestra el logo de Agenda Glam
/// Se puede configurar el tamaño y colores
class GlamLogo extends StatelessWidget {
  final double size;
  final bool showTagline;

  const GlamLogo({
    super.key,
    this.size = 80,
    this.showTagline = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Aquí podría ir una imagen SVG cuando se tengan los assets
        Icon(
          Icons.schedule,
          size: size,
          color: theme.colorScheme.secondary,
        ),
        const SizedBox(height: 16),
        Text(
          'Agenda Glam',
          style: theme.textTheme.headlineLarge?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (showTagline) ...[
          const SizedBox(height: 8),
          Text(
            'Tu agenda de belleza masculina',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onBackground.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
