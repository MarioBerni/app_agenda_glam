import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';

/// Botón para explorar la aplicación sin iniciar sesión
/// Muestra un icono de exploración y un texto indicativo
class ExploreButton extends StatelessWidget {
  /// Acción a ejecutar cuando se presiona el botón
  final VoidCallback onExplorePressed;
  
  /// Indica si el botón está en estado de carga
  final bool isLoading;

  /// Constructor del componente
  const ExploreButton({
    super.key,
    required this.onExplorePressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      TextButton(
        onPressed: onExplorePressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.white.withOpacity(0.9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Mostrar indicador de carga o icono según el estado
            isLoading 
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: kAccentColor,
                    ),
                  )
                : const Icon(
                    Icons.explore,
                    size: 16,
                    color: kAccentColor,
                  ),
            const SizedBox(width: 8),
            const Text(
              'Explorar sin cuenta',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      slideDistance: 0.15,
    );
  }
}
