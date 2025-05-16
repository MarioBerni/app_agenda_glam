import 'package:flutter/material.dart';

/// Controlador para manejar la lógica del flujo de registro por pasos.
/// Separa la lógica de negocio de la interfaz de usuario.
class RegisterController {
  /// Controlador de animación para las transiciones entre pasos
  final AnimationController animationController;

  /// Función de callback cuando se produce un error en un campo
  final Function(String field) onFieldError;

  /// Constructor
  RegisterController({
    required this.animationController,
    required this.onFieldError,
  });

  /// Navega al siguiente paso, validando antes los campos del paso actual
  Future<void> nextStep(
    int currentStep,
    VoidCallback onValidStep,
    List<String?> Function() validateCurrentStep,
  ) async {
    // Obtener errores de validación
    final List<String?> errors = validateCurrentStep();
    final bool hasErrors = errors.any((error) => error != null);

    if (!hasErrors) {
      // Animar transición al siguiente paso
      await animationController.forward();
      onValidStep();
      await animationController.reverse();
    } else {
      // Mostrar efecto de error en el primer campo inválido
      final int errorIndex = errors.indexWhere((error) => error != null);
      if (errorIndex >= 0) {
        // Determinar qué campo tiene el error
        final List<String> fieldNames =
            currentStep == 1
                ? ['name', 'email']
                : ['password', 'confirmPassword'];

        if (errorIndex < fieldNames.length) {
          onFieldError(fieldNames[errorIndex]);
        }
      }
    }
  }

  /// Navega al paso anterior con animación
  Future<void> previousStep(
    int currentStep,
    VoidCallback onDecreaseStep,
    VoidCallback onBackToWelcome,
  ) async {
    if (currentStep > 1) {
      // Animar transición al paso anterior
      await animationController.forward();
      onDecreaseStep();
      await animationController.reverse();
    } else {
      // Volver a la pantalla de bienvenida/login
      onBackToWelcome();
    }
  }

  /// Limpia los recursos del controlador
  void dispose() {
    // No necesitamos hacer dispose del animation controller
    // ya que lo maneja el estado que creó este controlador
  }
}
