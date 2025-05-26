import 'package:app_agenda_glam/features/partners/domain/entities/partner.dart';

/// Clase que proporciona datos de muestra de socios para la aplicación
class PartnerData {
  /// Lista de socios de muestra para mostrar en el carrusel
  static List<Partner> getSamplePartners() {
    return [
      const Partner(
        id: '1',
        businessName: 'Barbería Classic',
        imageUrl: 'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?q=80&w=300',
        description: 'Barbería tradicional con estilo moderno',
        category: 'Barbería',
        rating: 4.8,
      ),
      const Partner(
        id: '2',
        businessName: 'Hair Studio',
        imageUrl: 'https://images.unsplash.com/photo-1599351431202-1e0f0137899a?q=80&w=300',
        description: 'Especialistas en cortes modernos',
        category: 'Peluquería',
        rating: 4.6,
      ),
      const Partner(
        id: '3',
        businessName: 'Gentleman\'s Club',
        imageUrl: 'https://images.unsplash.com/photo-1503951914875-452162b0f3f1?q=80&w=300',
        description: 'Estilismo y cuidado masculino premium',
        category: 'Barbería & Spa',
        rating: 4.9,
      ),
      const Partner(
        id: '4',
        businessName: 'Urban Cuts',
        imageUrl: 'https://images.unsplash.com/photo-1585747860715-2ba37e788b70?q=80&w=300',
        description: 'Cortes urbanos y tendencias actuales',
        category: 'Barbería',
        rating: 4.7,
      ),
      const Partner(
        id: '5',
        businessName: 'Barber & Beard',
        imageUrl: 'https://images.unsplash.com/photo-1622296089863-eb7fc530daa8?q=80&w=300',
        description: 'Especialistas en barba y cuidado facial',
        category: 'Barbería',
        rating: 4.5,
      ),
    ];
  }
}
