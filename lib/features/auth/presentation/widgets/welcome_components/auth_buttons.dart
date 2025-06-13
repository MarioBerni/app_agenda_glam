import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';

/// Componente que contiene los botones de autenticación para la página de bienvenida
/// (Iniciar Sesión y Registrarse)
class AuthButtons extends StatelessWidget {
  /// Función callback para el botón de iniciar sesión
  final VoidCallback onLoginPressed;
  
  /// Estado de carga del botón de iniciar sesión
  final bool isLoginLoading;
  
  /// Función callback para el botón de registro
  final VoidCallback onRegisterPressed;
  
  /// Estado de carga del botón de registro
  final bool isRegisterLoading;

  /// Constructor del componente
  const AuthButtons({
    super.key,
    required this.onLoginPressed,
    required this.isLoginLoading,
    required this.onRegisterPressed,
    required this.isRegisterLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Column(
        children: [
          // Botón de iniciar sesión
          GlamButton(
            text: 'Iniciar Sesión',
            onPressed: onLoginPressed,
            isLoading: isLoginLoading,
            isFullWidth: true,
            withShimmer: false,
          ),
          
          const SizedBox(height: 16),
          
          // Botón de registro
          GlamButton(
            text: 'Registrarse',
            onPressed: onRegisterPressed,
            isLoading: isRegisterLoading,
            isSecondary: true,
            isFullWidth: true,
            withShimmer: false,
          ),
        ],
      ),
      slideDistance: 0.25,
    );
  }
}
