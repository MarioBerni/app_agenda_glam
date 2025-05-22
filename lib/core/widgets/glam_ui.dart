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
}
