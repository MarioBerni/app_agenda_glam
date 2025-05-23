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
    IconData iconData;
    
    // Determinar título, descripción e icono según el paso actual
    if (currentStep == 0) {
      // En el paso 0, ya no mostramos título ni descripción duplicados
      // Solo mostramos el icono
      title = ''; // Título vacío para el paso 0
      iconData = Icons.app_registration_rounded;
    } else if (currentStep == 1) {
      title = 'Información Personal';
      iconData = Icons.person_add_outlined;
    } else {
      title = 'Configurar Contraseña';
      iconData = Icons.lock_outline;
    }

    return Column(
      children: [
        SizedBox(height: size.height * 0.05),
        
        // Título de la página (solo para pasos posteriores al inicial)
        if (currentStep > 0) ...[  
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
        ],
        
        // Icono representativo con el mismo tamaño y efectos que LoginHeader
        GlamIconContainer(
          icon: iconData,
          size: 100,
          enableShimmer: true,
          animateEntry: true,
        ),
        
        const SizedBox(height: 24),
        
        // Ya no mostramos la descripción después del icono para mantener consistencia con las demás páginas
        
        // Ajustamos el espaciado final según el paso actual para mantener la coherencia visual
        // En el paso 0, eliminamos este espaciado ya que genera una inconsistencia visual
        if (currentStep > 0)
          SizedBox(height: size.height * 0.06),
      ],
    );
  }
}
