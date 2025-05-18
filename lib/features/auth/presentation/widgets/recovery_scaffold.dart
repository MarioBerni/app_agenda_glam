import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_background.dart';
import 'package:flutter/material.dart';

/// Widget de scaffold para la página de recuperación de contraseña
/// Proporciona el layout base y elementos comunes como AppBar
class RecoveryScaffold extends StatelessWidget {
  /// Contenido principal del scaffold
  final Widget child;

  /// Función para manejar el botón de retroceso
  final VoidCallback onBackPressed;

  const RecoveryScaffold({
    super.key,
    required this.child,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Controla el redimensionamiento cuando aparece el teclado
      // false: el contenido no se redimensiona (el fondo permanece estable)
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GlamAnimations.applyEntryEffect(
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: onBackPressed,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Fondo degradado elegante
          const GlamBackground(
            primaryColor: kPrimaryColor,
            intensity: 0.9,
          ),
          
          // Contenido principal
          SafeArea(child: child),
        ],
      ),
    );
  }
}
