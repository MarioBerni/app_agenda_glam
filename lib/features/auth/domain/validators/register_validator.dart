/// Clase utilitaria para manejar las validaciones del formulario de registro.
/// Separa la lógica de validación de la interfaz de usuario.
class RegisterValidator {
  /// Valida el nombre de usuario
  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'El nombre es requerido';
    }

    return null;
  }

  /// Valida el email del usuario
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

  /// Valida la contraseña y actualiza los criterios de fortaleza
  static String? validatePassword(
    String value,
    Map<String, bool> passwordCriteria,
  ) {
    if (value.isEmpty) {
      return 'La contraseña es requerida';
    }

    // Validar múltiples criterios
    bool isLengthValid = value.length >= 6;
    bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
    bool hasNumber = value.contains(RegExp(r'[0-9]'));

    // Actualizar el mapa de criterios
    passwordCriteria['length'] = isLengthValid;
    passwordCriteria['uppercase'] = hasUppercase;
    passwordCriteria['number'] = hasNumber;

    // Solo retornar error si no cumple con la longitud mínima
    if (!isLengthValid) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }

    // Los otros criterios son recomendaciones, no obligatorios
    return null;
  }

  /// Valida que las contraseñas coincidan
  static String? validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (confirmPassword.isEmpty) {
      return 'Confirma tu contraseña';
    }

    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }

    return null;
  }
}
