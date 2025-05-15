import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_text_field.dart';
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
        // Campo de nombre con animación
        GlamAnimations.applyEntryEffect(
          Stack(
            children: [
              GlamTextField(
                label: 'Nombre completo',
                hintText: 'Juan Pérez',
                controller: nameController,
                errorText: nameError,
                keyboardType: TextInputType.name,
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              if (isNameValid && nameError == null)
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
          slideDistance: 0.12,
        ),
        const SizedBox(height: 24),
        
        // Campo de email con animación
        GlamAnimations.applyEntryEffect(
          Stack(
            children: [
              GlamTextField(
                label: 'Email',
                hintText: 'example@mail.com',
                controller: emailController,
                errorText: emailError,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              if (isEmailValid && emailError == null)
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
          slideDistance: 0.15,
        ),
        
        // Texto informativo sobre el siguiente paso
        const SizedBox(height: 16),
        GlamAnimations.applyEntryEffect(
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 14,
                  color: Colors.white.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'En el siguiente paso configurarás tu contraseña de acceso',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          slideDistance: 0.18,
        ),
      ],
    );
  }
}
