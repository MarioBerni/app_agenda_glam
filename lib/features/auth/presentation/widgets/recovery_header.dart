import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_icon_container.dart';
import 'package:flutter/material.dart';

/// Widget que encapsula el encabezado de la página de recuperación de contraseña
/// Incluye el logo, título (opcional) y descripción
class RecoveryHeader extends StatelessWidget {
  /// Si debe mostrar el título "Recuperar contraseña"
  final bool showTitle;
  
  /// Constructor que permite controlar la visibilidad del título
  /// 
  /// Si [showTitle] es false, solo se mostrará el icono y la descripción,
  /// lo que permite usar este componente con encabezados personalizados.
  const RecoveryHeader({
    super.key,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: size.height * 0.02),
        
        // Título de la página (opcional)
        if (showTitle) ...[  
          GlamAnimations.applyEntryEffect(
            Text(
              'Recuperar contraseña',
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
        
        // Icono representativo de recuperación
        const GlamIconContainer(
          icon: Icons.autorenew_rounded,
          size: 100,
          enableShimmer: true,
          animateEntry: true,
        ),
        
        const SizedBox(height: 24),
        
        // Ya no mostramos la descripción aquí, ahora está en el encabezado unificado
        
        SizedBox(height: size.height * 0.06),
      ],
    );
  }
}