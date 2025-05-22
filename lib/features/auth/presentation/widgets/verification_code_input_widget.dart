import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Widget para la entrada y gestión del código de verificación
class VerificationCodeInputWidget extends StatelessWidget {
  /// Controlador para el campo de código
  final TextEditingController codeController;
  
  /// Mensaje de error para mostrar si hay validación fallida
  final String? errorText;
  
  /// Si el código ingresado es válido
  final bool isCodeValid;
  
  /// Si se puede reenviar el código
  final bool canResend;
  
  /// Tiempo restante formateado para mostrar (ejemplo: "1:45")
  final String formattedTime;
  
  /// Callback para reenviar el código
  final VoidCallback onResend;
  
  /// Si se ha alcanzado el límite de reenvíos
  final bool reachedResendLimit;

  const VerificationCodeInputWidget({
    super.key,
    required this.codeController,
    this.errorText,
    required this.isCodeValid,
    required this.canResend,
    required this.formattedTime,
    required this.onResend,
    required this.reachedResendLimit,
  });

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Código de Verificación',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          GlamTextField(
            controller: codeController,
            label: 'Código de 6 dígitos',
            prefixIcon: Icons.lock_outline,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            errorText: errorText,
            hintText: '123456',
            suffixIcon: isCodeValid 
                ? const Icon(Icons.check_circle, color: Colors.green) 
                : null,
            inputFormatters: [
              LengthLimitingTextInputFormatter(6),
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Opción de reenvío
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '¿No recibiste el código? ',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),
              if (canResend && !reachedResendLimit)
                TextButton(
                  onPressed: onResend,
                  child: const Text(
                    'Reenviar',
                    style: TextStyle(
                      color: kAccentColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Text(
                  reachedResendLimit 
                      ? 'Límite de reenvíos alcanzado' 
                      : 'Reenviar en $formattedTime',
                  style: TextStyle(
                    color: reachedResendLimit ? Colors.red.shade300 : kAccentColor,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
