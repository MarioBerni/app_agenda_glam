import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_google_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_terms_dialog.dart';
import 'package:flutter/gestures.dart';
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
        // Ya no mostramos el título ni el subtítulo aquí para mantener la consistencia con las demás páginas
        // La información relevante ya está incluida en el encabezado unificado
        
        // Espaciado estandarizado (32px) para mantener la coherencia con las demás páginas
        const SizedBox(height: 32),
        
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
                    color: Colors.white.withValues(alpha: 0.7),
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
        
        // Texto informativo sobre privacidad con enlaces interactivos
        GlamAnimations.applyEntryEffect(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
                children: [
                  const TextSpan(text: 'Al crear una cuenta, aceptas nuestros '),
                  TextSpan(
                    text: 'Términos de Servicio',
                    style: TextStyle(
                      color: kAccentColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Mostrar el diálogo de términos y condiciones
                        GlamTermsDialog.show(context);
                      },
                  ),
                  const TextSpan(text: ' y '),
                  TextSpan(
                    text: 'Política de Privacidad',
                    style: TextStyle(
                      color: kAccentColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Por ahora, ambos enlaces abren el mismo diálogo
                        // En el futuro se podría implementar un diálogo específico para políticas de privacidad
                        GlamTermsDialog.show(context);
                      },
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
