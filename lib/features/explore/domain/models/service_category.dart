import 'package:flutter/material.dart';

/// Modelo para categorías de servicios ofrecidos en la aplicación
class ServiceCategory {
  /// Identificador único de la categoría
  final String id;
  
  /// Nombre de la categoría
  final String name;
  
  /// Icono representativo de la categoría
  final IconData icon;
  
  /// Descripción corta de la categoría
  final String description;
  
  /// Color asociado a la categoría (opcional)
  final Color? color;

  /// Constructor para crear una categoría de servicio
  const ServiceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    this.color,
  });

  /// Lista de categorías de servicios predefinidas para demostración
  static List<ServiceCategory> getSampleCategories() {
    return [
      const ServiceCategory(
        id: 'haircut',
        name: 'Corte de pelo',
        icon: Icons.content_cut,
        description: 'Cortes modernos y clásicos para todo tipo de cabello',
      ),
      const ServiceCategory(
        id: 'beard',
        name: 'Barba',
        icon: Icons.face,
        description: 'Recorte, afeitado y tratamientos para barba',
      ),
      const ServiceCategory(
        id: 'facial',
        name: 'Facial',
        icon: Icons.spa,
        description: 'Tratamientos faciales para una piel saludable',
      ),
      const ServiceCategory(
        id: 'coloring',
        name: 'Coloración',
        icon: Icons.color_lens,
        description: 'Tintes y mechas con los mejores productos',
      ),
      const ServiceCategory(
        id: 'styling',
        name: 'Peinado',
        icon: Icons.brush,
        description: 'Estilos para ocasiones especiales',
      ),
      const ServiceCategory(
        id: 'manicure',
        name: 'Manicure',
        icon: Icons.back_hand,
        description: 'Cuidado y estética para tus manos',
      ),
    ];
  }
}
