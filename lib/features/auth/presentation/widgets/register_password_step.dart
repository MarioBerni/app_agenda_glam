import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_password_field.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/password_strength_indicator.dart';
import 'package:flutter/material.dart';

/// Widget que representa el segundo paso del registro donde se configura
/// la contraseÃ±a y se visualiza su fortaleza.
class RegisterPasswordStep extends StatelessWidget {
  /// Controlador para el campo de contraseÃ±a
  final TextEditingController passwordController;

  /// Controlador para el campo de confirmar contraseÃ±a
  final TextEditingController confirmPasswordController;

  /// Mensaje de error para el campo de contraseÃ±a (si existe)
  final String? passwordError;

  /// Mensaje de error para el campo de confirmar contraseÃ±a (si existe)
  final String? confirmPasswordError;

  /// Mapa de criterios de fortaleza de contraseÃ±a
  final Map<String, bool> passwordCriteria;

  /// Indica si las contraseÃ±as coinciden
  final bool doPasswordsMatch;

  /// AcciÃ³n a ejecutar al completar la ediciÃ³n
  final VoidCallback? onEditingComplete;

  const RegisterPasswordStep({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.passwordCriteria,
    this.passwordError,
    this.confirmPasswordError,
    this.doPasswordsMatch = false,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: const ValueKey('password_step'),
      children: [
        // Campo de contraseÃ±a con animaciÃ³n
        GlamAnimations.applyEntryEffect(
          GlamPasswordField(
            label: 'ContraseÃ±a',
            hintText: 'â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢',
            controller: passwordController,
            errorText: passwordError,
          ),
          slideDistance: 0.12,
        ),

        const SizedBox(height: 24),

        // Indicador de fortaleza de contraseÃ±a
        GlamAnimations.applyEntryEffect(
          PasswordStrengthIndicator(criteria: passwordCriteria),
          slideDistance: 0.15,
        ),

        const SizedBox(height: 24),

        // Campo de confirmar contraseÃ±a con animaciÃ³n
        GlamAnimations.applyEntryEffect(
          Stack(
            children: [
              GlamPasswordField(
                label: 'Confirmar contraseÃ±a',
                hintText: 'â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢',
                controller: confirmPasswordController,
                errorText: confirmPasswordError,
                onEditingComplete: onEditingComplete,
              ),
              // Icono de verificaciÃ³n si las contraseÃ±as coinciden
              if (doPasswordsMatch &&
                  passwordController.text.isNotEmpty &&
                  confirmPasswordError == null)
                Positioned(
                  right: 12,
                  top: 38,
                  child: GlamAnimations.applySuccessEffect(
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF4CAF50),
                      size: 22,
                    ),
                  ),
                ),
            ],
          ),
          slideDistance: 0.18,
        ),

        // Texto informativo sobre seguridad
        const SizedBox(height: 16),
        GlamAnimations.applyEntryEffect(
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Crea una contraseÃ±a segura usando caracteres especiales y combinando mayÃºsculas y nÃºmeros',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          slideDistance: 0.21,
        ),
      ],
    );
  }
}
