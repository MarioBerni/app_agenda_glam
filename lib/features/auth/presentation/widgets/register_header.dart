import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_icon_container.dart';
import 'package:flutter/material.dart';

/// Widget que encapsula el encabezado de la página de registro
/// Incluye el logo, título y descripción según el paso actual
/// Alineado visualmente con LoginHeader para mantener consistencia estética
class RegisterHeader extends StatelessWidget {
  /// Paso actual del registro
  final int currentStep;

  const RegisterHeader({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    String title;
    String description;
    IconData iconData;
    
    // Determinar título, descripción e icono según el paso actual
    if (currentStep == 0) {
      title = 'Crear Cuenta';
      description = 'Elige cómo quieres registrarte en Agenda Glam';
      iconData = Icons.app_registration_rounded;
    } else if (currentStep == 1) {
      title = 'Información Personal';
      description = 'Completa tus datos para registrarte y agendar tus citas';
      iconData = Icons.person_add_outlined;
    } else {
      title = 'Configurar Contraseña';
      description = 'Elige una contraseña segura para proteger tu cuenta';
      iconData = Icons.lock_outline;
    }

    return Column(
      children: [
        SizedBox(height: size.height * 0.05),
        
        // Título de la página
        GlamAnimations.applyEntryEffect(
          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          slideDistance: 0.1,
        ),
        
        const SizedBox(height: 24),
        
        // Icono representativo con el mismo tamaño y efectos que LoginHeader
        GlamIconContainer(
          icon: iconData,
          size: 100,
          enableShimmer: true,
          animateEntry: true,
        ),
        
        const SizedBox(height: 24),
        
        // Descripción con el mismo estilo que LoginHeader
        GlamAnimations.applyEntryEffect(
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
          slideDistance: 0.15,
        ),
        
        SizedBox(height: size.height * 0.06),
      ],
    );
  }
}
