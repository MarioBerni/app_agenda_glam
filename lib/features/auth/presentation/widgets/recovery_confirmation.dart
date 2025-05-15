import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget que muestra la confirmaciÃ³n de que se ha enviado el email
/// de recuperaciÃ³n de contraseÃ±a con animaciones visuales.
class RecoveryConfirmation extends StatelessWidget {
  /// Email al que se enviÃ³ el correo de recuperaciÃ³n
  final String email;

  /// Constructor
  const RecoveryConfirmation({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icono animado de correo enviado
              _buildEmailSentAnimation(),

              const SizedBox(height: 32),

              // TÃ­tulo con animaciÃ³n
              Text(
                'Email Enviado',
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

              // Mensaje de confirmaciÃ³n
              Text(
                'Hemos enviado instrucciones para restablecer tu contraseÃ±a a:',
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

              // Email del usuario
              Text(
                    email,
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
                'Revisa tu bandeja de entrada y sigue las instrucciones para recuperar el acceso a tu cuenta.',
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

              // BotÃ³n para volver al login
              _buildReturnButton(context),

              const SizedBox(height: 16),

              // Texto para reenviar el correo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Â¿No recibiste el correo?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // AquÃ­ se podrÃ­a implementar la lÃ³gica para reenviar el correo
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

  /// Construye la animaciÃ³n de "correo enviado"
  Widget _buildEmailSentAnimation() {
    return const GlamIconContainer(
      icon: Icons.mark_email_read_outlined,
      size: 120,
      enableShimmer: true,
      animateEntry: true,
    );
  }

  /// Construye el botÃ³n para volver al login
  Widget _buildReturnButton(BuildContext context) {
    return GlamButton(
      text: 'Volver al inicio de sesiÃ³n',
      onPressed: () => context.go(AppRouter.login),
      icon: Icons.login_outlined,
      variant: GlamButtonVariant.primary,
      size: GlamButtonSize.medium,
      primaryColor: kPrimaryColor,
      animateEntry: true,
    );
  }
}
