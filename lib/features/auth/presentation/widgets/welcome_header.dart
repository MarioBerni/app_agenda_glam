import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/widgets/glam_icon_container.dart';
import 'package:flutter/material.dart';

/// Widget que muestra el encabezado de la página de bienvenida
/// con el ícono, título y tagline
class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // Ícono de tijera simplificado
          const GlamIconContainer(
            icon: Icons.content_cut_rounded,
            size: 80,
            enableShimmer: true,
            animateEntry: true,
          ),
          
          // Título principal con animación de entrada
          GlamAnimations.applyEntryEffect(
            const Text(
              'Agenda Glam',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      
          // Tagline con espacio reducido
          const SizedBox(height: 8),
          GlamAnimations.applyEntryEffect(
            const Text(
              'Tu agenda de belleza masculina',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            slideDistance: 0.15,
          ),
        ],
      ),
    );
  }
}
