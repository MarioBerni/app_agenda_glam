import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';

/// Widget para los botones de acción en las páginas de registro
class ActionButtonsWidget extends StatelessWidget {
  /// Texto para el botón principal
  final String primaryButtonText;
  
  /// Callback para el botón principal
  final VoidCallback? onPrimaryPressed;
  
  /// Callback para el botón secundario (cancelar)
  final VoidCallback onCancelPressed;
  
  /// Si el botón principal está en estado de carga
  final bool isLoading;

  const ActionButtonsWidget({
    super.key,
    required this.primaryButtonText,
    this.onPrimaryPressed,
    required this.onCancelPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Row(
        children: [
          Expanded(
            child: GlamButton(
              text: 'Cancelar',
              onPressed: onCancelPressed,
              isSecondary: true,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GlamButton(
              text: primaryButtonText,
              onPressed: onPrimaryPressed,
              isLoading: isLoading,
              withShimmer: true,
            ),
          ),
        ],
      ),
    );
  }
}
