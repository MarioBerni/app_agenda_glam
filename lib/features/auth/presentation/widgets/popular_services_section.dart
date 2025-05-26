import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

/// Widget que muestra la sección de servicios populares
/// con un listado horizontal de servicios con íconos
class PopularServicesSection extends StatelessWidget {
  const PopularServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de sección con animación
        GlamAnimations.applyEntryEffect(
          const Text(
            'Servicios populares',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          slideDistance: 0.15,
        ),
        
        const SizedBox(height: 16),
        
        // Listado horizontal de servicios
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              ServiceItem(icon: Icons.content_cut, name: 'Corte de pelo'),
              ServiceItem(icon: Icons.face, name: 'Barba'),
              ServiceItem(icon: Icons.spa, name: 'Facial'),
              ServiceItem(icon: Icons.color_lens, name: 'Coloración'),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget que representa un ítem de servicio individual
class ServiceItem extends StatelessWidget {
  final IconData icon;
  final String name;
  
  const ServiceItem({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Container(
        width: 90,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: ColorUtils.withOpacityValue(kSurfaceColor, 0.7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: kAccentColor,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      // Usamos duración manual para escalonar los elementos
      duration: const Duration(milliseconds: 800),
    );
  }
}
