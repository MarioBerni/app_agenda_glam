import 'package:flutter/material.dart';
import 'package:app_agenda_glam/features/auth/domain/validators/recovery_validator.dart';

/// Controlador para manejar la lógica del flujo de recuperación de contraseña.
/// Separa la lógica de negocio de la interfaz de usuario.
/// Soporta recuperación tanto por email como por teléfono.
class RecoveryController {
  /// Controlador de animación para transiciones y efectos visuales
  final AnimationController animationController;

  /// Función de callback cuando se produce un error en un campo
  final Function(String message) onError;

  /// Función de callback cuando se inicia el procesamiento
  final Function() onStartProcessing;

  /// Función de callback cuando se completa el procesamiento
  final Function() onEndProcessing;

  /// Función de callback cuando se envía correctamente el email o SMS
  final Function() onEmailSent;

  /// Constructor
  RecoveryController({
    required this.animationController,
    required this.onError,
    required this.onStartProcessing,
    required this.onEndProcessing,
    required this.onEmailSent,
  });

  /// Inicia el proceso de recuperación de contraseña
  Future<void> recoverPassword(String identifier, bool isEmail) async {
    // Validar el formato del identificador primero
    String? validationError;
    
    if (isEmail) {
      validationError = RecoveryValidator.validateEmail(identifier);
    } else {
      validationError = RecoveryValidator.validatePhone(identifier);
    }
    
    if (validationError != null) {
      onError(validationError);
      return;
    }

    // Iniciar animación de procesamiento
    onStartProcessing();

    try {
      // Simular la verificación con el backend
      await animationController.forward();

      // Verificar si el identificador está registrado
      bool isRegistered;
      
      if (isEmail) {
        isRegistered = await RecoveryValidator.isEmailRegistered(identifier);
      } else {
        isRegistered = await RecoveryValidator.isPhoneRegistered(identifier);
      }

      if (isRegistered) {
        // Si está registrado, simular el envío de correo o SMS
        await Future.delayed(const Duration(milliseconds: 800));
        onEmailSent();
      } else {
        // Si no está registrado, mostrar error
        if (isEmail) {
          onError('No hay cuenta asociada con este correo electrónico');
        } else {
          onError('No hay cuenta asociada con este número de teléfono');
        }
      }
    } catch (e) {
      // En caso de error inesperado
      onError('Error en el proceso de recuperación: ${e.toString()}');
    } finally {
      // Finalizar animación de procesamiento
      await animationController.reverse();
      onEndProcessing();
    }
  }

  /// Reinicia el proceso de recuperación de contraseña
  void resetRecovery() {
    animationController.reset();
  }

  /// Limpia los recursos del controlador
  void dispose() {
    // No necesitamos hacer dispose del animation controller
    // ya que lo maneja el estado que creó este controlador
  }
}
