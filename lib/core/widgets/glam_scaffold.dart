import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Scaffold base unificado para todas las pantallas de la aplicación Agenda Glam.
/// 
/// Este componente proporciona:
/// * Fondo degradado estándar utilizando [GlamGradientBackground]
/// * Estructura visual consistente con título, subtítulo y divisor dorado
/// * Soporte para contenido flexible (con o sin encabezado)
/// * Comportamiento configurable para teclado
/// * Navegación hacia atrás con animaciones fluidas
/// 
/// Puede usarse de dos formas principales:
/// 1. Con `title`, `subtitle` y `content` para el diseño estándar con encabezado
/// 2. Con `directContent` para diseños personalizados sin encabezado estándar
/// 
/// Es el componente scaffold centralizado que debe usarse en toda la aplicación
/// para mantener una experiencia visual coherente.
class GlamScaffold extends StatelessWidget {
  /// Título principal de la pantalla que se muestra en la parte superior.
  /// 
  /// Opcional si se usa `directContent`. Cuando se proporciona, se muestra con
  /// un estilo prominente al inicio del scaffold, seguido del subtítulo y el divisor.
  final String? title;

  /// Subtítulo o descripción debajo del título principal.
  /// 
  /// Opcional. Proporciona contexto adicional sobre el propósito de la pantalla.
  /// Solo se muestra si también se proporciona `title`.
  final String? subtitle;

  /// Contenido principal del scaffold que se integra con el encabezado estándar y divisor.
  /// 
  /// Debe usarse cuando se desea mantener el encabezado estándar de la aplicación.
  /// No puede usarse simultáneamente con `directContent`.
  final Widget? content;

  /// Contenido directo sin el encabezado ni divisor estándar.
  /// 
  /// Debe usarse cuando se necesita un control total sobre la estructuración del contenido,
  /// como en las páginas de inicio de sesión o registro que tienen sus propios encabezados personalizados.
  /// No puede usarse simultáneamente con `content`.
  final Widget? directContent;

  /// Si debe mostrar el botón de retroceso
  final bool showBackButton;

  /// Color primario para el fondo degradado (opcional)
  final Color? primaryColor;

  /// Intensidad del fondo degradado (0.0 - 1.0)
  final double backgroundIntensity;

  /// Acción personalizada para el botón de retroceso (opcional)
  final VoidCallback? onBackPressed;
  
  /// Controla si el scaffold se redimensiona cuando aparece el teclado
  final bool resizeToAvoidBottomInset;

  /// Constructor para GlamScaffold.
  /// 
  /// Requiere especificar uno de estos parámetros:
  /// * `content` - Para usar con el encabezado estándar
  /// * `directContent` - Para control total sobre el contenido
  /// 
  /// Ejemplos de uso:
  /// ```dart
  /// // Con encabezado estándar
  /// GlamScaffold(
  ///   title: 'Mi Pantalla',
  ///   subtitle: 'Descripción de la pantalla',
  ///   content: MiContenido(),
  /// )
  /// 
  /// // Con contenido personalizado
  /// GlamScaffold(
  ///   directContent: MiContenidoPersonalizado(),
  /// )
  /// ```
  const GlamScaffold({
    super.key,
    this.title,
    this.subtitle,
    this.content,
    this.directContent,
    this.showBackButton = true,
    this.primaryColor,
    this.backgroundIntensity = 0.7,
    this.onBackPressed,
    this.resizeToAvoidBottomInset = false,
  }) : assert(
          (content != null && directContent == null) ||
              (content == null && directContent != null),
          'Debe proporcionarse content o directContent, pero no ambos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo transparente porque el fondo se proporciona dentro del stack
      backgroundColor: Colors.transparent,
      // Configuración del teclado (false para evitar redimensionamiento)
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      // Extender el cuerpo detrás del AppBar para evitar el borde negro
      extendBodyBehindAppBar: true,
      // Extender el cuerpo hasta los bordes de la pantalla
      extendBody: true,
      // AppBar con botón de retroceso animado
      appBar: showBackButton
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 20),
                    onPressed: onBackPressed ?? () {
                      // Si estamos en una ruta que conocemos
                      if (context.canPop()) {
                        // Usamos Navigator.of(context).pop() que mantendrá la transición establecida
                        Navigator.of(context).pop();
                      } else {
                        // Fallback a la página de bienvenida si no podemos determinar a dónde volver
                        CircleNavigation.goToWelcome(context);
                      }
                    },
                    color: kAccentColor, // Icono dorado para consistencia con el diseño preferido
                  ).glamEntry(duration: GlamAnimations.shortDuration),
                  if (title != null && directContent == null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          if (subtitle != null)
                            Text(
                              subtitle!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            )
          : null,
      // Stack para fondo y contenido
      body: Stack(
        children: [
          // Fondo degradado usando el componente centralizado
          GlamGradientBackground(
            primaryColor: primaryColor ?? kPrimaryColorDark,
            opacity: backgroundIntensity,
          ),

          // Contenido principal
          SafeArea(
            child: directContent != null ? directContent! : _buildContent(),
          ),
        ],
      ),
    );
  }

  /// Construye el contenido principal del scaffold con encabezado y separador
  Widget _buildContent() {
    // El content no puede ser nulo en este punto porque:
    // 1. Si directContent no es nulo, nunca llegamos aquí (se muestra directContent)
    // 2. Si directContent es nulo, content debe ser no nulo (por el assert del constructor)
    if (title == null) {
      return content!; // Content no puede ser nulo aquí por la lógica mencionada
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Espacio para evitar que el contenido quede debajo del AppBar personalizado
        const SizedBox(height: 16.0),

        // Separador dorado con gradiente
        _buildGoldenDivider(),

        // Contenido principal
        Expanded(child: content!), // Es seguro usar ! aquí porque ya validamos en el constructor
      ],
    );
  }

  /// Construye el separador dorado con gradiente
  Widget _buildGoldenDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            kAccentColor.withValues(alpha: 0.6),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    ).glamEntry(duration: const Duration(milliseconds: 900));
  }
}
