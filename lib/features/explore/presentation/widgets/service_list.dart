import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/animations/glam_animations.dart';
import 'package:app_agenda_glam/features/explore/domain/models/service.dart';
import 'package:app_agenda_glam/features/explore/presentation/widgets/service_card.dart';

/// Widget que muestra una lista de servicios con opciones de filtrado
class ServiceList extends StatelessWidget {
  /// Lista de servicios a mostrar
  final List<Service> services;
  
  /// Indica si el usuario está autenticado
  final bool isUserLoggedIn;
  
  /// Callback cuando se selecciona un servicio
  final Function(Service) onServiceSelected;
  
  /// Constructor del widget ServiceList
  const ServiceList({
    super.key,
    required this.services,
    required this.isUserLoggedIn,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return _buildEmptyState();
    }
    
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 120), // Espacio para la barra de navegación
      itemCount: services.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final service = services[index];
        return GlamAnimations.applyEntryEffect(
          ServiceCard(
            service: service,
            isAvailable: service.availableWithoutRegistration || isUserLoggedIn,
            onTap: () => onServiceSelected(service),
          ),
          duration: Duration(milliseconds: 400 + (50 * index)),
        );
      },
    );
  }
  
  /// Construye un estado vacío cuando no hay servicios
  Widget _buildEmptyState() {
    return GlamAnimations.applyEntryEffect(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: Colors.white54,
            ),
            const SizedBox(height: 16),
            const Text(
              'No se encontraron servicios',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Intenta con otra categoría o verifica tus filtros',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
