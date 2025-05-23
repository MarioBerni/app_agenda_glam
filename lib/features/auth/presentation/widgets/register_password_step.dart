import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_terms_dialog.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/password_strength_indicator.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/terms_checkbox.dart';
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

  /// Mensaje de error para el checkbox de términos (si existe)
  final String? termsError;

  /// Mapa de criterios de fortaleza de contraseña
  final Map<String, bool> passwordCriteria;

  /// Indica si las contraseñas coinciden
  final bool doPasswordsMatch;

  /// Indica si los términos han sido aceptados
  final bool termsAccepted;

  /// Callback para cuando cambia el estado de aceptación de términos
  final ValueChanged<bool>? onTermsAcceptedChanged;

  /// Acción a ejecutar al completar la edición
  final VoidCallback? onEditingComplete;

  const RegisterPasswordStep({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.passwordCriteria,
    this.passwordError,
    this.confirmPasswordError,
    this.termsError,
    this.doPasswordsMatch = false,
    this.termsAccepted = false,
    this.onTermsAcceptedChanged,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch, // Cambio a stretch como en LoginForm
      key: const ValueKey('password_step'),
      children: [
        // Campo de contraseña (mismo estilo que LoginForm)
        GlamTextField(
          controller: passwordController,
          label: 'Contraseña',
          prefixIcon: Icons.lock,
          isPassword: true,
          validator: (value) => null, // La validación ya se maneja en otro lugar
          textInputAction: TextInputAction.next,
          errorText: passwordError,
        ),

        const SizedBox(height: 20),

        // Indicador de fortaleza de contraseña
        PasswordStrengthIndicator(criteria: passwordCriteria),

        const SizedBox(height: 20),

        // Campo de confirmar contraseña
        GlamTextField(
          controller: confirmPasswordController,
          label: 'Confirmar contraseña',
          prefixIcon: Icons.lock,
          isPassword: true,
          validator: (value) => null, // La validación ya se maneja en otro lugar
          textInputAction: TextInputAction.done,
          errorText: confirmPasswordError,
          onFieldSubmitted: (_) => onEditingComplete?.call(),
        ),

        // Texto informativo sobre seguridad
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              Icon(
                Icons.security,
                size: 14,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Crea una contraseña segura usando caracteres especiales y combinando mayúsculas y números',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Espaciado antes del checkbox de términos
        const SizedBox(height: 24),
        
        // Checkbox de términos y condiciones
        TermsCheckbox(
          isAccepted: termsAccepted,
          errorText: termsError,
          onChanged: (value) {
            if (onTermsAcceptedChanged != null) {
              onTermsAcceptedChanged!(value);
            }
          },
          onTermsLinkTap: () async {
            // Mostrar diálogo de términos y condiciones
            final accepted = await GlamTermsDialog.show(context);
            if (accepted == true && onTermsAcceptedChanged != null) {
              onTermsAcceptedChanged!(true);
            }
          },
        ),
      ],
    );
  }
}
