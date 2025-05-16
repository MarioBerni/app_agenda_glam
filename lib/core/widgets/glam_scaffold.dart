import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Scaffold base unificado para todas las pantallas de autenticación
/// Proporciona una experiencia visual consistente con fondo degradado,
/// estructura común y componentes visuales compartidos.
class GlamScaffold extends StatelessWidget {
  /// Título principal de la pantalla
  final String title;

  /// Subtítulo o descripción (opcional)
  final String? subtitle;

  /// Contenido principal del scaffold
  final Widget content;

  /// Si debe mostrar el botón de retroceso
  final bool showBackButton;

  /// Color primario para el fondo degradado (opcional)
  final Color? primaryColor;

  /// Intensidad del fondo degradado (0.0 - 1.0)
  final double backgroundIntensity;

  /// Acción personalizada para el botón de retroceso (opcional)
  final VoidCallback? onBackPressed;

  /// Constructor
  const GlamScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    this.showBackButton = true,
    this.primaryColor,
    this.backgroundIntensity = 0.7,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo transparente porque GlamBackground proporciona el fondo
      backgroundColor: Colors.transparent,
      // Extender el cuerpo detrás del AppBar para evitar el borde negro
      extendBodyBehindAppBar: true,
      // Extender el cuerpo hasta los bordes de la pantalla
      extendBody: true,
      // AppBar con botón de retroceso animado
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading:
            showBackButton
                ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios, size: 20),
                  onPressed: onBackPressed ?? () => context.pop(),
                  color: Colors.white,
                ).glamEntry(duration: GlamAnimations.shortDuration)
                : null,
      ),
      // Stack para fondo y contenido
      body: Stack(
        children: [
          // Fondo degradado usando GlamBackground
          GlamBackground(
            primaryColor: primaryColor ?? kPrimaryColorDark,
            intensity: backgroundIntensity,
          ),

          // Contenido principal
          SafeArea(child: _buildContent()),
        ],
      ),
    );
  }

  /// Construye el contenido principal del scaffold con encabezado y separador
  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabecera animada con título y subtítulo
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título principal
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).glamEntry(
                duration: const Duration(milliseconds: 600),
                offset: const Offset(0, 0.05),
              ),

              // Subtítulo opcional
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ).glamEntry(
                    duration: const Duration(milliseconds: 700),
                    offset: const Offset(0, 0.08),
                  ),
                ),
            ],
          ),
        ),

        // Separador dorado con gradiente
        _buildGoldenDivider(),

        // Contenido principal
        Expanded(child: content),
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
