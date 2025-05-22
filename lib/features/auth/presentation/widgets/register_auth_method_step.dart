import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_google_button.dart';
import 'package:flutter/material.dart';

/// Widget que representa el paso de selección del método de autenticación
/// en el proceso de registro de nuevos usuarios.
///
/// Muestra las opciones de registro con Google o con número de teléfono.
class RegisterAuthMethodStep extends StatelessWidget {
  /// Indica si el registro con Google está en estado de carga
  final bool isGoogleLoading;
  
  /// Indica si el registro con teléfono está en estado de carga
  final bool isPhoneLoading;
  
  /// Función para manejar el registro con Google
  final VoidCallback onGoogleRegister;
  
  /// Función para manejar el registro con teléfono
  final VoidCallback onPhoneRegister;

  const RegisterAuthMethodStep({
    super.key,
    this.isGoogleLoading = false,
    this.isPhoneLoading = false,
    required this.onGoogleRegister,
    required this.onPhoneRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      key: const ValueKey('auth_method_step'),
      children: [
        // Título de bienvenida
        GlamAnimations.applyEntryEffect(
          Text(
            '¡Bienvenido a Agenda Glam!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Subtítulo descriptivo
        GlamAnimations.applyEntryEffect(
          Text(
            'Elige cómo quieres crear tu cuenta',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Opción de registro con Google
        GlamAnimations.applyEntryEffect(
          GlamGoogleButton(
            text: 'Continuar con Google',
            onPressed: onGoogleRegister,
            isLoading: isGoogleLoading,
            disabled: isPhoneLoading,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Separador "o"
        GlamAnimations.applyEntryEffect(
          Row(
            children: [
              const Expanded(child: Divider(color: Colors.white30)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'o',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Expanded(child: Divider(color: Colors.white30)),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Opción de registro con teléfono
        GlamAnimations.applyEntryEffect(
          GlamButton(
            text: 'Usar número de teléfono',
            onPressed: isGoogleLoading ? null : onPhoneRegister,
            isLoading: isPhoneLoading,
            icon: Icons.phone_android,
            withShimmer: true,
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Texto informativo sobre privacidad
        GlamAnimations.applyEntryEffect(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Al crear una cuenta, aceptas nuestros Términos de Servicio y Política de Privacidad.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
