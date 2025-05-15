/// Clase utilitaria para manejar las validaciones del formulario de recuperación.
/// Separa la lógica de validación de la interfaz de usuario.
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
  
  /// Valida si el email está registrado en el sistema (simulado)
  /// En una implementación real, esto se manejaría a nivel de repositorio
  static Future<bool> isEmailRegistered(String email) async {
    // Simulación de verificación con una lista de emails "registrados"
    await Future.delayed(const Duration(milliseconds: 500)); // Simulación de latencia
    
    final registeredEmails = [
      'usuario@example.com',
      'test@example.com',
      'admin@example.com',
    ];
    
    return registeredEmails.contains(email.toLowerCase());
  }
}
