import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:flutter/material.dart';

/// Widget que representa el primer paso del registro donde se ingresan
/// los datos personales del usuario (nombre y email).
class RegisterPersonalInfoStep extends StatelessWidget {
  /// Controlador para el campo de nombre
  final TextEditingController nameController;

  /// Controlador para el campo de email
  final TextEditingController emailController;

  /// Mensaje de error para el campo de nombre (si existe)
  final String? nameError;

  /// Mensaje de error para el campo de email (si existe)
  final String? emailError;

  /// Indica si el nombre es válido para efectos visuales
  final bool isNameValid;

  /// Indica si el email es válido para efectos visuales
  final bool isEmailValid;

  const RegisterPersonalInfoStep({
    super.key,
    required this.nameController,
    required this.emailController,
    this.nameError,
    this.emailError,
    this.isNameValid = false,
    this.isEmailValid = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: const ValueKey('personal_info_step'),
      children: [
        // Campo de nombre con animación (mismo estilo que LoginForm)
        GlamAnimations.applyEntryEffect(
          // Eliminamos el Stack y los iconos de verificación para mantener coherencia con LoginForm
          GlamTextField(
            controller: nameController,
            label: 'Nombre completo',
            prefixIcon: Icons.person_outline,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            errorText: nameError,
            // Aseguramos que la etiqueta se muestre correctamente
            hintText: 'Ingresa tu nombre completo',
          ),
          slideDistance: 0.2, // Ajustado para coincidir con LoginForm
        ),
        const SizedBox(height: 20), // Ajustado para mantener coherencia con LoginForm

        // Campo de email con animación (mismo estilo que LoginForm)
        GlamAnimations.applyEntryEffect(
          // Eliminamos el Stack y los iconos de verificación para mantener coherencia con LoginForm
          GlamTextField(
            controller: emailController,
            label: 'Email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            errorText: emailError,
            hintText: 'nombre@ejemplo.com', // Mantenemos el hint text como LoginForm
          ),
          slideDistance: 0.2, // Ajustado para coincidir con LoginForm
        ),

        // Texto informativo sobre el siguiente paso (con animación coherente)
        const SizedBox(height: 16),
        GlamAnimations.applyEntryEffect(
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'En el siguiente paso configurarás tu contraseña de acceso',
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
          slideDistance: 0.2, // Ajustado para mantener coherencia
        ),
      ],
    );
  }
}
