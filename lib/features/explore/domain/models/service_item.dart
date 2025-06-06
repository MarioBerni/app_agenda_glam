/// Modelo para servicios específicos ofrecidos por los socios
class ServiceItem {
  /// Identificador único del servicio
  final String id;
  
  /// Nombre del servicio
  final String name;
  
  /// Descripción detallada del servicio
  final String description;
  
  /// Precio base del servicio (en la moneda local)
  final double price;
  
  /// Duración aproximada en minutos
  final int durationMinutes;
  
  /// URL de la imagen representativa del servicio
  final String imageUrl;
  
  /// Categoría a la que pertenece el servicio
  final String categoryId;
  
  /// Nivel de popularidad (1-5)
  final int popularityLevel;
  
  /// Indicador de si el servicio es nuevo
  final bool isNew;
  
  /// Indicador de si el servicio está en oferta
  final bool isOnSale;
  
  /// Porcentaje de descuento si está en oferta
  final double? discountPercentage;
  
  /// Indicador de si el servicio requiere registro para reservar
  final bool requiresRegistration;

  /// Constructor del modelo de servicio
  const ServiceItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.imageUrl,
    required this.categoryId,
    this.popularityLevel = 3,
    this.isNew = false,
    this.isOnSale = false,
    this.discountPercentage,
    this.requiresRegistration = true,
  });

  /// Calcula el precio con descuento si aplica
  double get finalPrice {
    if (isOnSale && discountPercentage != null) {
      return price * (1 - (discountPercentage! / 100));
    }
    return price;
  }
  
  /// Lista de servicios de muestra para desarrollo y demostración
  static List<ServiceItem> getSampleServices() {
    return [
      // Servicios de corte de pelo
      ServiceItem(
        id: 'haircut_classic',
        name: 'Corte Clásico',
        description: 'Corte tradicional con tijeras y acabado con navaja para un look elegante y refinado.',
        price: 600,
        durationMinutes: 30,
        imageUrl: 'assets/images/services/haircut_classic.jpg',
        categoryId: 'haircut',
        popularityLevel: 5,
        requiresRegistration: true,
      ),
      ServiceItem(
        id: 'haircut_fade',
        name: 'Degradado (Fade)',
        description: 'Corte moderno con degradado lateral y trasero, perfecto para un look contemporáneo.',
        price: 700,
        durationMinutes: 40,
        imageUrl: 'assets/images/services/haircut_fade.jpg',
        categoryId: 'haircut',
        popularityLevel: 5,
        isNew: true,
        requiresRegistration: true,
      ),
      
      // Servicios de barba
      ServiceItem(
        id: 'beard_trim',
        name: 'Recorte de Barba',
        description: 'Perfilado y recorte de barba con tijeras y máquina para un look bien cuidado.',
        price: 350,
        durationMinutes: 20,
        imageUrl: 'assets/images/services/beard_trim.jpg',
        categoryId: 'beard',
        popularityLevel: 4,
        requiresRegistration: false,
      ),
      ServiceItem(
        id: 'beard_shave',
        name: 'Afeitado Tradicional',
        description: 'Afeitado con navaja y toalla caliente para una experiencia premium y un resultado impecable.',
        price: 450,
        durationMinutes: 30,
        imageUrl: 'assets/images/services/beard_shave.jpg',
        categoryId: 'beard',
        popularityLevel: 3,
        requiresRegistration: true,
      ),
      
      // Servicios faciales
      ServiceItem(
        id: 'facial_cleansing',
        name: 'Limpieza Facial',
        description: 'Tratamiento completo para limpiar poros, eliminar impurezas y hidratar la piel del rostro.',
        price: 850,
        durationMinutes: 45,
        imageUrl: 'assets/images/services/facial_cleansing.jpg',
        categoryId: 'facial',
        popularityLevel: 4,
        isOnSale: true,
        discountPercentage: 15,
        requiresRegistration: true,
      ),
      
      // Servicios de coloración
      ServiceItem(
        id: 'coloring_full',
        name: 'Coloración Completa',
        description: 'Aplicación de tinte en todo el cabello con productos premium para un color duradero.',
        price: 1200,
        durationMinutes: 90,
        imageUrl: 'assets/images/services/coloring_full.jpg',
        categoryId: 'coloring',
        popularityLevel: 3,
        requiresRegistration: true,
      ),
      
      // Servicios de peinado
      ServiceItem(
        id: 'styling_event',
        name: 'Peinado para Eventos',
        description: 'Peinado profesional para ocasiones especiales con productos de fijación de alta calidad.',
        price: 500,
        durationMinutes: 30,
        imageUrl: 'assets/images/services/styling_event.jpg',
        categoryId: 'styling',
        popularityLevel: 3,
        requiresRegistration: false,
      ),
      
      // Servicios de manicure
      ServiceItem(
        id: 'manicure_express',
        name: 'Manicura Express',
        description: 'Limado, pulido y tratamiento hidratante rápido para manos bien cuidadas.',
        price: 400,
        durationMinutes: 25,
        imageUrl: 'assets/images/services/manicure_express.jpg',
        categoryId: 'manicure',
        popularityLevel: 2,
        isNew: true,
        requiresRegistration: false,
      ),
    ];
  }
  
  /// Obtiene servicios filtrados por categoría
  static List<ServiceItem> getServicesByCategory(String categoryId) {
    return getSampleServices()
        .where((service) => service.categoryId == categoryId)
        .toList();
  }
  
  /// Obtiene los servicios más populares (nivel 4-5)
  static List<ServiceItem> getPopularServices() {
    return getSampleServices()
        .where((service) => service.popularityLevel >= 4)
        .toList();
  }
  
  /// Obtiene servicios que no requieren registro
  static List<ServiceItem> getNoRegistrationServices() {
    return getSampleServices()
        .where((service) => !service.requiresRegistration)
        .toList();
  }
}
