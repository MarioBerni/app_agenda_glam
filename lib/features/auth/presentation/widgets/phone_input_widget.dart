import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:flutter/material.dart';

/// Widget para la entrada y validación del número de teléfono
class PhoneInputWidget extends StatelessWidget {
  /// Controlador para el campo de teléfono
  final TextEditingController phoneController;
  
  /// Mensaje de error para mostrar
  final String? errorText;
  
  /// Si el teléfono ingresado es válido
  final bool isPhoneValid;
  
  /// Si se muestra el texto informativo sobre envío de código
  final bool showInfoText;
  
  /// Si se muestra el label dentro del campo
  final bool showFieldLabel;
  
  /// Título que aparece sobre el campo (opcional)
  final String? title;

  const PhoneInputWidget({
    super.key,
    required this.phoneController,
    this.errorText,
    required this.isPhoneValid,
    this.showInfoText = true,
    this.showFieldLabel = true,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título opcional sobre el campo
        if (title != null) ...[  
          Text(
            title!,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
        ],
      
        GlamAnimations.applyEntryEffect(
          GlamTextField(
            controller: phoneController,
            label: showFieldLabel ? 'Número de Teléfono' : '',
            prefixIcon: Icons.phone_android,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            errorText: errorText,
            hintText: '09XXXXXXXX',
            suffixIcon: isPhoneValid 
                ? const Icon(Icons.check_circle, color: Colors.green) 
                : null,
          ),
        ),
        
        if (showInfoText) ...[
          const SizedBox(height: 16),
          // Texto informativo
          GlamAnimations.applyEntryEffect(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                'Te enviaremos un código de verificación a este número.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}