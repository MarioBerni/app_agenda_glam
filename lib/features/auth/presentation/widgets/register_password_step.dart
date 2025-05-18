import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/password_strength_indicator.dart';
import 'package:flutter/material.dart';

/// Widget que representa el segundo paso del registro donde se configura
/// la contraseña y se visualiza su fortaleza.
class RegisterPasswordStep extends StatelessWidget {
  /// Controlador para el campo de contraseña
  final TextEditingController passwordController;

  /// Controlador para el campo de confirmar contraseña
  final TextEditingController confirmPasswordController;

  /// Mensaje de error para el campo de contraseña (si existe)
  final String? passwordError;

  /// Mensaje de error para el campo de confirmar contraseña (si existe)
  final String? confirmPasswordError;

  /// Mapa de criterios de fortaleza de contraseña
  final Map<String, bool> passwordCriteria;

  /// Indica si las contraseñas coinciden
  final bool doPasswordsMatch;

  /// Acción a ejecutar al completar la edición
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
        // Campo de contraseña con animación (mismo estilo que LoginForm)
        GlamAnimations.applyEntryEffect(
          GlamTextField(
            controller: passwordController,
            label: 'Contraseña',
            prefixIcon: Icons.lock,
            isPassword: true, // Parámetro que activa la funcionalidad de contraseña
            validator: (value) => null, // La validación ya se maneja en otro lugar
            textInputAction: TextInputAction.next,
            errorText: passwordError,
          ),
          slideDistance: 0.2, // Ajustado para coincidir con LoginForm
        ),

        const SizedBox(height: 20), // Ajustado para mantener coherencia con LoginForm

        // Indicador de fortaleza de contraseña (con la misma animación que otros elementos)
        GlamAnimations.applyEntryEffect(
          PasswordStrengthIndicator(criteria: passwordCriteria),
          slideDistance: 0.2, // Ajustado para mantener coherencia
        ),

        const SizedBox(height: 20), // Ajustado para mantener coherencia con LoginForm

        // Campo de confirmar contraseña con animación (mismo estilo que LoginForm)
        GlamAnimations.applyEntryEffect(
          GlamTextField(
            controller: confirmPasswordController,
            label: 'Confirmar contraseña',
            prefixIcon: Icons.lock,
            isPassword: true, // Parámetro que activa la funcionalidad de contraseña
            validator: (value) => null, // La validación ya se maneja en otro lugar
            textInputAction: TextInputAction.done,
            errorText: confirmPasswordError,
            onFieldSubmitted: (_) => onEditingComplete?.call(),
          ),
          slideDistance: 0.2, // Ajustado para coincidir con LoginForm
        ),

        // Texto informativo sobre seguridad (con animación coherente con LoginPage)
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
                    'Crea una contraseña segura usando caracteres especiales y combinando mayúsculas y números',
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
          slideDistance: 0.25, // Ajustado para coincidir con LoginPage
        ),
      ],
    );
  }
}
