import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/animations/animation_presets.dart';

/// Componente que muestra el encabezado de la página de bienvenida
/// con el título y subtítulo, sin botón de retroceso
class WelcomeHeaderSection extends StatelessWidget {
  const WelcomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Accede a tus citas y servicios premium',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
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
