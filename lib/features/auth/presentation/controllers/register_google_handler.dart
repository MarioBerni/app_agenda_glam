import 'package:app_agenda_glam/core/routes/circle_page_route.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/google_register_additional_info_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Controlador para gestionar el flujo de registro con Google
///
/// Este controlador encapsula la lógica relacionada con el registro mediante
/// Google OAuth. Se encarga de simular la autenticación con Google y
/// redirigir al usuario a la pantalla de información adicional.
///
/// En una implementación real con Firebase Auth, este controlador integraría
/// con el SDK de Firebase para realizar la autenticación real.
class RegisterGoogleHandler {
  /// Función de callback para actualizar el estado de carga
  final Function(bool) onLoadingChanged;

  /// Constructor que recibe la función para actualizar el estado de carga
  RegisterGoogleHandler({
    required this.onLoadingChanged,
  });

  /// Maneja el proceso de registro con Google
  ///
  /// Este método:
  /// 1. Actualiza el estado de carga a true
  /// 2. Simula un proceso de autenticación con Google (en implementación real usaría Firebase Auth)
  /// 3. Redirige a la pantalla de información adicional
  ///
  /// En una implementación real con Firebase, este método:
  /// - Iniciaría el flujo de autenticación con Google
  /// - Obtendría las credenciales de Google
  /// - Autenticaría al usuario con Firebase usando esas credenciales
  /// - Verificaría si es un usuario nuevo o existente
  /// - Redireccionaría según corresponda
  void handleGoogleRegister(BuildContext context) {
    // Indicar que está cargando
    onLoadingChanged(true);
    
    // Simula un proceso de autenticación con Google
    Future.delayed(const Duration(seconds: 2), () {
      // En un escenario real, obtendríamos la información del usuario desde Google OAuth
      
      // Para la simulación, usamos datos ficticios que normalmente vendrían de Google
      const String googleUserName = "Mario Berni";
      const String googleUserEmail = "mario.berni@gmail.com";
      
      debugPrint('Autenticando con Google - Email: $googleUserEmail');
      
      // Verificar si el contexto todavía está montado (previene errores si el usuario navegó a otra pantalla)
      if (context.mounted) {
        // Finalizar estado de carga
        onLoadingChanged(false);
        
        // Redirigimos a la página de información adicional con los datos de Google
        // Usamos pushCircle para mantener la coherencia visual en transiciones
        context.pushCircle(
          GoogleRegisterAdditionalInfoPage(
            userName: googleUserName,
            userEmail: googleUserEmail,
          ),
        );
      }
    });
  }
}
