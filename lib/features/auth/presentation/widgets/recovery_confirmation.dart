import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget que muestra la confirmación de que se ha enviado el email o SMS
/// de recuperación de contraseña con animaciones visuales.
class RecoveryConfirmation extends StatelessWidget {
  /// Identificador (email o teléfono) al que se envió la recuperación
  final String identifier;
  
  /// Indica si el identificador es un email (true) o teléfono (false)
  final bool isEmail;

  /// Constructor
  const RecoveryConfirmation({
    super.key, 
    required this.identifier, 
    required this.isEmail
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono animado de correo o SMS enviado
              _buildSentAnimation(),

              const SizedBox(height: 32),

              // Título con animación
              Text(
                isEmail ? 'Email Enviado' : 'SMS Enviado',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).glamEntry(
                duration: const Duration(milliseconds: 700),
                offset: const Offset(0, 0.1),
              ),

              const SizedBox(height: 16),

              // Mensaje de confirmación
              Text(
                isEmail 
                  ? 'Hemos enviado instrucciones para restablecer tu contraseña a:'
                  : 'Hemos enviado un código de verificación al número:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ).glamEntry(
                duration: const Duration(milliseconds: 800),
                offset: const Offset(0, 0.12),
              ),

              const SizedBox(height: 12),

              // Identificador del usuario
              Text(
                identifier,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kAccentColor,
                ),
              )
              .glamEntry(
                duration: const Duration(milliseconds: 900),
                offset: const Offset(0, 0.15),
              )
              .glamShimmer(),

              const SizedBox(height: 24),

              // Mensaje adicional
              Text(
                isEmail
                  ? 'Revisa tu bandeja de entrada y sigue las instrucciones para recuperar el acceso a tu cuenta.'
                  : 'Revisa tus mensajes SMS y utiliza el código recibido para restablecer tu contraseña.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ).glamEntry(
                duration: const Duration(milliseconds: 1000),
                offset: const Offset(0, 0.18),
              ),

              const SizedBox(height: 40),

              // Botón para volver al login
              _buildReturnButton(context),

              const SizedBox(height: 16),

              // Texto para reenviar el correo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isEmail ? 'No recibí el email' : 'No recibí el SMS',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Aquí se podría implementar la lógica para reenviar el correo
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Correo reenviado'),
                          backgroundColor: kSurfaceColor,
                        ),
                      );
                    },
                    child: const Text(
                      'Reenviar',
                      style: TextStyle(
                        color: kAccentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ).glamEntry(
                duration: const Duration(milliseconds: 1200),
                offset: const Offset(0, 0.2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Construye la animación de sobre de correo o teléfono
  Widget _buildSentAnimation() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: kAccentColor.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          isEmail ? Icons.mark_email_read : Icons.sms_outlined,
          size: 64,
          color: kAccentColor,
        ),
      ),
    ).glamEntry(
      duration: const Duration(milliseconds: 800),
      offset: const Offset(0, 0.1),
    );
  }

  /// Construye el botón para volver al login
  Widget _buildReturnButton(BuildContext context) {
    return GlamButton(
      text: 'Volver al inicio de sesión',
      onPressed: () => context.go(AppRouter.login),
      icon: Icons.login_outlined,
      isSecondary: false,
      withShimmer: true,
    );
  }
}
