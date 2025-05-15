import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_background.dart';
import 'package:flutter/material.dart';

/// Widget de scaffold para la página de registro
/// Proporciona el layout base y elementos comunes como AppBar
class RegisterScaffold extends StatelessWidget {
  /// Contenido principal del scaffold
  final Widget child;

  /// Función para manejar el botón de retroceso
  final VoidCallback onBackPressed;

  const RegisterScaffold({
    super.key,
    required this.child,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: onBackPressed,
          child: GlamAnimations.applyEntryEffect(
            const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Fondo con degradado y patrón sutil
          const GlamBackground(intensity: 0.7),

          // Contenido principal
          SafeArea(child: child),
        ],
      ),
    );
  }
}
