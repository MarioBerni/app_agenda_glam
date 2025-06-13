// Model para servicios

/// Modelo para representar un servicio ofrecido por un proveedor
class Service {
  /// Identificador único del servicio
  final String id;
  
  /// Nombre del servicio
  final String name;
  
  /// Descripción detallada del servicio
  final String description;
  
  /// Precio base del servicio
  final double price;
  
  /// Duración aproximada en minutos
  final int durationMinutes;
  
  /// ID de la categoría a la que pertenece este servicio
  final String categoryId;
  
  /// URL de la imagen representativa (puede ser local o remota)
  final String imageUrl;
  
  /// ID del proveedor que ofrece este servicio
  final String providerId;
  
  /// Nombre del proveedor que ofrece este servicio
  final String providerName;
  
  /// Indica si este servicio está disponible sin registro (demo)
  final bool availableWithoutRegistration;
  
  /// Puntuación promedio (1-5)
  final double rating;

  /// Constructor para crear un servicio
  const Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.categoryId,
    required this.imageUrl,
    required this.providerId,
    required this.providerName,
    this.availableWithoutRegistration = false,
    this.rating = 0.0,
  });
  
  /// Retorna una lista de servicios de muestra para demostración
  static List<Service> getSampleServices() {
    return [
      Service(
        id: 'service_001',
        name: 'Corte Clásico',
        description: 'Corte tradicional con tijera y degradado clásico. Incluye lavado y styling final.',
        price: 550,
        durationMinutes: 30,
        categoryId: 'haircut',
        imageUrl: 'assets/images/services/classic_haircut.jpg',
        providerId: 'provider_001',
        providerName: 'Barbería El Patrón',
        availableWithoutRegistration: true,
        rating: 4.8,
      ),
      Service(
        id: 'service_002',
        name: 'Fade Moderno',
        description: 'Degradado pronunciado con diseño personalizado. Incluye lavado y producto para styling.',
        price: 650,
        durationMinutes: 45,
        categoryId: 'haircut',
        imageUrl: 'assets/images/services/modern_fade.jpg',
        providerId: 'provider_001',
        providerName: 'Barbería El Patrón',
        availableWithoutRegistration: true,
        rating: 4.9,
      ),
      Service(
        id: 'service_003',
        name: 'Afeitado Tradicional',
        description: 'Afeitado completo con navaja, toalla caliente y masaje facial. Experiencia premium.',
        price: 450,
        durationMinutes: 30,
        categoryId: 'beard',
        imageUrl: 'assets/images/services/traditional_shave.jpg',
        providerId: 'provider_002',
        providerName: 'Gentleman\'s Club',
        availableWithoutRegistration: false,
        rating: 4.7,
      ),
      Service(
        id: 'service_004',
        name: 'Perfilado de Barba',
        description: 'Recorte y definición de líneas para mantener tu barba impecable.',
        price: 350,
        durationMinutes: 20,
        categoryId: 'beard',
        imageUrl: 'assets/images/services/beard_trim.jpg',
        providerId: 'provider_002',
        providerName: 'Gentleman\'s Club',
        availableWithoutRegistration: true,
        rating: 4.5,
      ),
      Service(
        id: 'service_005',
        name: 'Tratamiento Facial Ejecutivo',
        description: 'Limpieza profunda, exfoliación y mascarilla hidratante para piel radiante.',
        price: 850,
        durationMinutes: 60,
        categoryId: 'facial',
        imageUrl: 'assets/images/services/executive_facial.jpg',
        providerId: 'provider_003',
        providerName: 'Urban Grooming',
        availableWithoutRegistration: false,
        rating: 4.9,
      ),
      Service(
        id: 'service_006',
        name: 'Coloración y Mechas',
        description: 'Aplicación de color personalizado con técnicas modernas para un look actual.',
        price: 1200,
        durationMinutes: 120,
        categoryId: 'coloring',
        imageUrl: 'assets/images/services/hair_coloring.jpg',
        providerId: 'provider_003',
        providerName: 'Urban Grooming',
        availableWithoutRegistration: false,
        rating: 4.6,
      ),
      Service(
        id: 'service_007',
        name: 'Peinado para Eventos',
        description: 'Styling profesional para lucir impecable en tu evento especial.',
        price: 500,
        durationMinutes: 40,
        categoryId: 'styling',
        imageUrl: 'https://images.unsplash.com/photo-1621607512214-68297480165e?q=80&w=300', // Imagen de respaldo en lugar del asset local
        providerId: 'provider_004',
        providerName: 'Style Masters',
        availableWithoutRegistration: true,
        rating: 4.8,
      ),
      Service(
        id: 'service_008',
        name: 'Manicure Ejecutivo',
        description: 'Cuidado completo de manos con exfoliación, hidratación y arreglo de uñas.',
        price: 400,
        durationMinutes: 30,
        categoryId: 'manicure',
        imageUrl: 'https://images.unsplash.com/photo-1519340241574-2cec6aef0c01?q=80&w=300', // Imagen de respaldo en lugar del asset local
        providerId: 'provider_004',
        providerName: 'Style Masters',
        availableWithoutRegistration: false,
        rating: 4.4,
      ),
    ];
  }
  
  /// Filtra servicios por categoría
  static List<Service> filterByCategory(List<Service> services, String? categoryId) {
    if (categoryId == null) {
      return services;
    }
    return services.where((service) => service.categoryId == categoryId).toList();
  }
  
  /// Filtra servicios disponibles sin registro
  static List<Service> filterAvailableWithoutRegistration(List<Service> services) {
    return services.where((service) => service.availableWithoutRegistration).toList();
  }
}
