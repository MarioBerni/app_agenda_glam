import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Widget que representa un checkbox estilizado para aceptar los términos y condiciones
/// con un texto clickeable que abre el diálogo modal con los términos completos.
class TermsCheckbox extends StatelessWidget {
  /// Indica si los términos han sido aceptados
  final bool isAccepted;

  /// Callback que se ejecuta cuando cambia el estado del checkbox
  final ValueChanged<bool> onChanged;

  /// Callback que se ejecuta cuando se hace clic en el enlace de términos
  final VoidCallback onTermsLinkTap;

  /// Mensaje de error a mostrar si no se aceptan los términos
  final String? errorText;

  /// Constructor del widget TermsCheckbox
  const TermsCheckbox({
    super.key,
    required this.isAccepted,
    required this.onChanged,
    required this.onTermsLinkTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Checkbox con texto
        InkWell(
          onTap: () => onChanged(!isAccepted),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Checkbox personalizado con animación
                GlamAnimations.applyButtonPressEffect(
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isAccepted ? kAccentColor : Colors.white70,
                        width: 2,
                      ),
                      color: isAccepted ? kAccentColor.withValues(alpha: 0.2) : Colors.transparent,
                    ),
                    child: isAccepted
                        ? Animate(
                            effects: const [FadeEffect(duration: Duration(milliseconds: 200))],
                            child: Icon(
                              Icons.check,
                              size: 14,
                              color: kAccentColor,
                            ),
                          )
                        : null,
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Texto con enlace
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      children: [
                        const TextSpan(text: 'He leído y acepto los '),
                        TextSpan(
                          text: 'Términos y Condiciones',
                          style: TextStyle(
                            color: kAccentColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = onTermsLinkTap,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Mensaje de error
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0, top: 4.0),
            child: Text(
              errorText!,
              style: TextStyle(
                color: kErrorColor,
                fontSize: 12,
              ),
            ).glamEntry(duration: const Duration(milliseconds: 300)),
          ),
      ],
    );
  }
}
