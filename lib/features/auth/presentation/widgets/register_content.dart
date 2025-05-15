import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_logo.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_footer.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_header.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_personal_info_step.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_password_step.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_step_indicator.dart';
import 'package:flutter/material.dart';

/// Widget principal de contenido para la pantalla de registro
/// Organiza todos los componentes visuales en la estructura de la página
class RegisterContent extends StatelessWidget {
  /// Paso actual del registro
  final int currentStep;

  /// Total de pasos del registro
  final int totalSteps;

  /// Controlador para el campo de nombre
  final TextEditingController nameController;

  /// Controlador para el campo de email
  final TextEditingController emailController;

  /// Controlador para el campo de contraseña
  final TextEditingController passwordController;

  /// Controlador para el campo de confirmación de contraseña
  final TextEditingController confirmPasswordController;

  /// Error del campo de nombre
  final String? nameError;

  /// Error del campo de email
  final String? emailError;

  /// Error del campo de contraseña
  final String? passwordError;

  /// Error del campo de confirmación de contraseña
  final String? confirmPasswordError;

  /// Indica si el nombre es válido
  final bool isNameValid;

  /// Indica si el email es válido
  final bool isEmailValid;

  /// Criterios para la validación de contraseña
  final Map<String, bool> passwordCriteria;

  /// Indica si las contraseñas coinciden
  final bool doPasswordsMatch;

  /// Indica si está en estado de carga
  final bool isLoading;

  /// Función para ir al siguiente paso
  final VoidCallback onNextStep;

  /// Función para enviar el formulario
  final VoidCallback onRegister;

  const RegisterContent({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameError,
    required this.emailError,
    required this.passwordError,
    required this.confirmPasswordError,
    required this.isNameValid,
    required this.isEmailValid,
    required this.passwordCriteria,
    required this.doPasswordsMatch,
    required this.isLoading,
    required this.onNextStep,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo con animación
            Center(
              child: GlamAnimations.applyLogoEffect(
                const GlamLogo(size: 60, showTagline: false),
              ),
            ),
            const SizedBox(height: 24),

            // Indicador de progreso
            GlamAnimations.applyEntryEffect(
              RegisterStepIndicator(
                currentStep: currentStep,
                totalSteps: totalSteps,
              ),
              slideDistance: 0.05,
            ),
            const SizedBox(height: 24),

            // Encabezado con título y subtítulo
            RegisterHeader(currentStep: currentStep),
            const SizedBox(height: 32),

            // Formulario por pasos (con animación)
            _buildCurrentStep(),

            const SizedBox(height: 24),

            // Botón de acción principal
            GlamAnimations.applyEntryEffect(
              GlamButton(
                text: currentStep == 1 ? 'Continuar' : 'Registrarse',
                onPressed:
                    isLoading
                        ? null
                        : (currentStep == 1 ? onNextStep : onRegister),
                isLoading: isLoading,
              ),
              slideDistance: 0.15,
            ),

            const SizedBox(height: 24),

            // Pie de página con enlace a login
            const RegisterFooter(),
          ],
        ),
      ),
    );
  }

  /// Construye el paso actual del formulario con animación
  Widget _buildCurrentStep() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child:
          currentStep == 1
              ? RegisterPersonalInfoStep(
                nameController: nameController,
                emailController: emailController,
                nameError: nameError,
                emailError: emailError,
                isNameValid: isNameValid,
                isEmailValid: isEmailValid,
              )
              : RegisterPasswordStep(
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                passwordError: passwordError,
                confirmPasswordError: confirmPasswordError,
                passwordCriteria: passwordCriteria,
                doPasswordsMatch: doPasswordsMatch,
                onEditingComplete: onRegister,
              ),
    );
  }
}
