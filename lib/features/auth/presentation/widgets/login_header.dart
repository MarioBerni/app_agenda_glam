import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_icon_container.dart';
import 'package:flutter/material.dart';

/// Widget que encapsula el encabezado de la página de login
/// Incluye el logo, título (opcional) y descripción
class LoginHeader extends StatelessWidget {
  /// Si debe mostrar el título "Iniciar Sesión"
  final bool showTitle;
  
  /// Constructor que permite controlar la visibilidad del título
  /// 
  /// Si [showTitle] es false, solo se mostrará el icono y la descripción,
  /// lo que permite usar este componente con encabezados personalizados.
  const LoginHeader({
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
              'Iniciar Sesión',
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
        
        // Icono representativo de login
        const GlamIconContainer(
          icon: Icons.person_outline,
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
