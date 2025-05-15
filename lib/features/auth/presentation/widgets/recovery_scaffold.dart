import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Scaffold base para la pantalla de recuperación de contraseña
/// Define la estructura común y elementos visuales compartidos
class RecoveryScaffold extends StatelessWidget {
  /// Título del scaffold
  final String title;
  
  /// Descripción o mensaje secundario
  final String? subtitle;
  
  /// Contenido principal del scaffold
  final Widget content;
  
  /// Si debe mostrar el botón de retroceso
  final bool showBackButton;
  
  /// Constructor
  const RecoveryScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () => context.pop(),
                color: Colors.white,
              ).glamEntry(
                    duration: GlamAnimations.shortDuration,
                  )
            : null,
      ),
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  /// Construye el contenido principal del scaffold
  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabecera animada
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
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ).glamEntry(
                    duration: const Duration(milliseconds: 700),
                    offset: const Offset(0, 0.08),
                  ),
                ),
            ],
          ),
        ),
        
        // Separador superior con gradiente sutil
        Container(
          height: 1,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                kAccentColor.withOpacity(0.6),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ).glamEntry(
          duration: const Duration(milliseconds: 900),
        ),
        
        // Contenido principal
        Expanded(
          child: content,
        ),
      ],
    );
  }
}
