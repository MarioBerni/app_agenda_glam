/// Entidad que representa un socio (barbería, peluquería, etc.) en la aplicación
class Partner {
  /// Identificador único del socio
  final String id;

  /// Nombre del negocio o establecimiento
  final String businessName;
  
  /// URL de la imagen del logo o establecimiento
  final String imageUrl;
  
  /// Breve descripción del negocio
  final String description;
  
  /// Categoría principal del negocio (ej: "Barbería", "Peluquería", etc.)
  final String category;
  
  /// Puntuación promedio del socio (de 0 a 5)
  final double rating;

  /// Constructor de la entidad Partner
  const Partner({
    required this.id,
    required this.businessName,
    required this.imageUrl,
    required this.description,
    required this.category,
    required this.rating,
  });
}
