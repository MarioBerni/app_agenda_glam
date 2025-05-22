/// Clase utilitaria para manejar las validaciones del formulario de recuperación.
/// Separa la lógica de validación de la interfaz de usuario.
/// Soporta validación tanto de email como de teléfono.
class RecoveryValidator {
  /// Valida el email del usuario para recuperación de contraseña
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'El email es requerido';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un email válido';
    }

    return null;
  }

  /// Valida el número de teléfono del usuario para recuperación de contraseña
  static String? validatePhone(String value) {
    if (value.isEmpty) {
      return 'El número de teléfono es requerido';
    }

    // Validación básica de formato de teléfono (solo números y mínimo 8 dígitos)
    final phoneRegex = RegExp(r'^[0-9]{8,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Ingresa un número de teléfono válido (mínimo 8 dígitos)';
    }

    return null;
  }
  
  /// Valida si el email está registrado en el sistema (simulado)
  /// En una implementación real, esto se manejaría a nivel de repositorio
  static Future<bool> isEmailRegistered(String email) async {
    // Simulación de verificación con una lista de emails "registrados"
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulación de latencia

    final registeredEmails = [
      'usuario@example.com',
      'test@example.com',
      'admin@example.com',
    ];

    return registeredEmails.contains(email.toLowerCase());
  }
  
  /// Valida si el teléfono está registrado en el sistema (simulado)
  /// En una implementación real, esto se manejaría a nivel de repositorio
  static Future<bool> isPhoneRegistered(String phone) async {
    // Simulación de verificación con una lista de teléfonos "registrados"
    await Future.delayed(
      const Duration(milliseconds: 500),
    ); // Simulación de latencia

    final registeredPhones = [
      '12345678',
      '87654321',
      '98765432',
    ];

    return registeredPhones.contains(phone);
  }
}
