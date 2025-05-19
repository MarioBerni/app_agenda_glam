import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Widget que proporciona un fondo de video con degradado
/// para las pantallas principales de la aplicación.
///
/// Permite reproducir un video como fondo con diferentes efectos
/// de degradado para mantener la estética masculina y elegante.
class GlamVideoBackground extends StatefulWidget {
  /// Ruta al archivo de video (desde assets)
  final String videoAsset;

  /// Opacidad del degradado superior (0.0 - 1.0)
  final double gradientOpacity;

  /// Color principal del degradado
  final Color? gradientColor;

  /// Si el video debe reproducirse en loop
  final bool loop;

  /// Si el video debe reproducirse automáticamente
  final bool autoPlay;

  /// Widget hijo que se mostrará sobre el video
  final Widget? child;

  const GlamVideoBackground({
    super.key,
    required this.videoAsset,
    this.gradientOpacity = 0.7,
    this.gradientColor,
    this.loop = true,
    this.autoPlay = true,
    this.child,
  });

  @override
  State<GlamVideoBackground> createState() => _GlamVideoBackgroundState();
}

class _GlamVideoBackgroundState extends State<GlamVideoBackground> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  Future<void> _initializeVideoPlayer() async {
    _controller = VideoPlayerController.asset(widget.videoAsset);

    await _controller.initialize();

    if (widget.loop) {
      _controller.setLooping(true);
    }

    if (widget.autoPlay) {
      _controller.play();
    }

    // Para asegurar que se reproduzca a pantalla completa sin importar la relación de aspecto
    _controller.setVolume(0.0); // Sin sonido

    if (mounted) {
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradientColor = widget.gradientColor ?? theme.colorScheme.primary;

    if (!_isInitialized) {
      // Usar el mismo fondo degradado consistente con el resto de la aplicación
      return Stack(
        children: [
          // Fondo degradado centralizado
          GlamGradientBackground(
            primaryColor: gradientColor,
            opacity: widget.gradientOpacity,
          ),
          // Indicador de carga centrado
          const Center(child: CircularProgressIndicator()),
        ],
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Video de fondo
        FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),

        // Degradado superior (más oscuro arriba)
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                gradientColor.withValues(alpha: widget.gradientOpacity),
                gradientColor.withValues(alpha: 0.3),
              ],
            ),
          ),
        ),

        // Degradado complementario (efecto viñeta)
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [
                Colors.transparent,
                gradientColor.withValues(alpha: widget.gradientOpacity * 0.7),
              ],
              stops: const [0.6, 1.0],
            ),
          ),
        ),

        // Contenido hijo
        if (widget.child != null) widget.child!,
      ],
    );
  }
}
