import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:flutter/material.dart';

/// Widget para el encabezado de la página de registro con Google
class GoogleRegisterHeaderWidget extends StatelessWidget {
  /// Nombre del usuario obtenido de Google
  final String userName;

  const GoogleRegisterHeaderWidget({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Row(
        children: [
          GlamUI.buildBackButton(context),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Completar Registro',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Hola $userName, solo necesitamos unos datos más',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
