import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/partners/data/models/partner_data.dart';
import 'package:app_agenda_glam/features/partners/presentation/widgets/partners_carousel.dart';

/// Componente modular que muestra la sección de socios destacados
/// con efectos visuales mejorados y animaciones fluidas.
class FeaturedPartnersSection extends StatelessWidget {
  const FeaturedPartnersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de sección con animación
        GlamAnimations.applyEntryEffect(
          const Padding(
            padding: EdgeInsets.only(left: 12.0, bottom: 16.0),
            child: Text(
              'SOCIOS DESTACADOS',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kAccentColor,
                letterSpacing: 2.0,
              ),
            ),
          ),
          slideDistance: 0.2,
          duration: const Duration(milliseconds: 800),
        ),
        
        // Carrusel con efecto de profundidad
        Container(
          height: 240,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: GlamAnimations.applyEntryEffect(
            // Aplicamos un padding horizontal para evitar cortes en los bordes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: PartnersCarousel(
                partners: PartnerData.getSamplePartners(),
                autoScrollDuration: const Duration(seconds: 4),
                height: 240, // Hacemos que coincida con el contenedor
              ),
            ),
            slideDistance: 0.3,
            duration: const Duration(milliseconds: 1000),
          ),
        ),
      ],
    );
  }
}
