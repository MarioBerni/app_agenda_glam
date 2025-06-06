import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/theme/colors.dart';
import 'package:app_agenda_glam/core/animations/glam_animations.dart';
import 'package:app_agenda_glam/features/explore/domain/models/service.dart';

/// Tarjeta para mostrar un servicio en el catálogo
class ServiceCard extends StatelessWidget {
  /// Servicio a mostrar
  final Service service;
  
  /// Callback cuando se selecciona la tarjeta
  final VoidCallback onTap;
  
  /// Si es true, la tarjeta tendrá una animación de entrada
  final bool withAnimation;
  
  /// Duración de la animación (si está habilitada)
  final Duration animationDuration;
  
  /// Indica si el servicio está disponible para el usuario actual
  final bool isAvailable;

  const ServiceCard({
    super.key,
    required this.service,
    required this.onTap,
    this.withAnimation = true,
    this.animationDuration = const Duration(milliseconds: 800),
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen del servicio con indicadores superpuestos
          Stack(
            children: [
              // Imagen con bordes redondeados en la parte superior
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: _buildServiceImage(),
                ),
              ),
              // Badges de precio, registro y duración
              Positioned(
                top: 8,
                right: 8,
                child: _buildPriceBadge(),
              ),
              if (!isAvailable)
                Positioned(
                  top: 8,
                  left: 8,
                  child: _buildRegistrationBadge(),
                ),
              Positioned(
                bottom: 8,
                left: 8,
                child: _buildDurationBadge(),
              ),
            ],
          ),
          
          // Información del servicio (nombre, descripción, precio)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre del servicio
                Text(
                  service.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 8),
                
                // Descripción corta
                Text(
                  service.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 8),
                
                // Información de proveedor
                Row(
                  children: [
                    const Icon(
                      Icons.store,
                      size: 14,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        service.providerName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    
    // Envolvemos en un GestureDetector para manejar el tap
    final tapDetector = GestureDetector(
      onTap: onTap,
      child: card,
    );
    
    // Aplicamos animación si está habilitada
    if (withAnimation) {
      return GlamAnimations.applyEntryEffect(
        tapDetector,
        duration: animationDuration,
      );
    }
    
    return tapDetector;
  }

  /// Construye la imagen del servicio con degradado
  Widget _buildServiceImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Imagen de fondo
        service.imageUrl.startsWith('assets/')
            ? Image.asset(
                service.imageUrl,
                fit: BoxFit.cover,
              )
            : Image.network(
                service.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kAccentColor,
                      strokeWidth: 2,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.black12,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_rounded,
                        color: Colors.white54,
                        size: 32,
                      ),
                    ),
                  );
                },
              ),
              
        // Overlay más oscuro para servicios no disponibles
        if (!isAvailable)
          Container(
            color: Colors.black.withValues(alpha: 0.4),
          ),
      ],
    );
  }

  /// Construye el badge de precio
  Widget _buildPriceBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.attach_money,
            color: Colors.white,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            '\$${service.price.toStringAsFixed(0)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  /// Construye el indicador de registro requerido
  Widget _buildRegistrationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.lock,
            color: Colors.white,
            size: 12,
          ),
          const SizedBox(width: 4),
          const Text(
            'Requiere registro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Construye el badge de duración
  Widget _buildDurationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.schedule,
            color: Colors.white70,
            size: 12,
          ),
          const SizedBox(width: 4),
          Text(
            '${service.durationMinutes} min',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
