// Exporta todos los componentes UI unificados para facilitar su importación
//
// Esto permite importar todos los componentes con una sola línea:
// import 'package:app_agenda_glam/core/widgets/glam_ui.dart'

import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';

// Las declaraciones de library no son necesarias cuando solo se exportan componentes
export 'glam_divider.dart';
export 'glam_icon_container.dart';
export 'glam_scaffold.dart';
export 'glam_text_field.dart';

/// Clase utilitaria que proporciona componentes UI reutilizables para mantener
/// una experiencia visual consistente en toda la aplicación.
///
/// Esta clase contiene métodos estáticos para crear widgets comunes como:
/// - Botones de navegación
/// - Encabezados unificados
/// - Iconos estilizados
/// - Elementos de interfaz compartidos
class GlamUI {
  /// Construye un botón de retroceso estilizado que utiliza la navegación
  /// estándar para regresar a la pantalla anterior.
  ///
  /// @param context El contexto de construcción para la navegación
  /// @return Un widget IconButton estilizado
  static Widget buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: kAccentColor,
        size: 24,
      ),
      onPressed: () => Navigator.of(context).pop(),
      splashRadius: 24,
      tooltip: 'Volver',
      padding: EdgeInsets.zero,
    );
  }
  
  /// Construye un encabezado unificado con botón de retroceso dorado y título alineado.
  /// 
  /// Este componente sigue el diseño del encabezado de la página "Completar Registro",
  /// con el botón de retroceso dorado y el título alineado junto al botón.
  /// Incluye un espaciado superior configurable para mantener la consistencia visual.
  /// 
  /// @param context El contexto de construcción
  /// @param title El título principal del encabezado
  /// @param subtitle Subtítulo opcional debajo del título principal
  /// @param onBackPressed Acción personalizada para el botón de retroceso (opcional)
  /// @param topSpacingFactor Factor de espaciado superior como porcentaje de la altura de pantalla (predeterminado: 0.04)
  /// @param includeTopSpacing Si se debe incluir el espaciado superior (predeterminado: true)
  /// @return Un widget Column con espaciado superior y encabezado completo
  static Widget buildHeader(BuildContext context, {
    required String title,
    String? subtitle,
    VoidCallback? onBackPressed,
    double topSpacingFactor = 0.04, // 4% de la altura de la pantalla por defecto
    bool includeTopSpacing = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Espaciado superior configurable
        if (includeTopSpacing)
          SizedBox(height: MediaQuery.of(context).size.height * topSpacingFactor),
          
        // Fila con botón de retroceso, título y subtítulo
        Row(
      children: [
        // Botón de retroceso dorado
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kAccentColor,
            size: 24,
          ),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
          splashRadius: 24,
          tooltip: 'Volver',
          padding: EdgeInsets.zero,
        ),
        const SizedBox(width: 16),
        // Título y subtítulo
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
      ],
    );
  }
}
