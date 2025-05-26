import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/features/partners/data/models/partner_data.dart';
import 'package:app_agenda_glam/features/partners/presentation/widgets/partners_carousel.dart';
import 'package:flutter/material.dart';

/// Widget que muestra la sección de socios destacados
/// con un carrusel automático de tarjetas de socios
class FeaturedPartnersSection extends StatelessWidget {
  const FeaturedPartnersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        // Carrusel de socios con diseño mejorado
        SizedBox(
          height: 180,
          child: GlamAnimations.applyEntryEffect(
            PartnersCarousel(
              partners: PartnerData.getSamplePartners(),
              autoScrollDuration: const Duration(seconds: 3),
              height: 180,
            ),
            slideDistance: 0.2,
            duration: const Duration(milliseconds: 800),
          ),
        ),
      ],
    );
  }
}
