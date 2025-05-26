import 'dart:async';
import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';
import 'package:app_agenda_glam/features/partners/domain/entities/partner.dart';

/// Un widget que muestra un carrusel automático de tarjetas de socios
/// con animación y transición suave entre ellas.
class PartnersCarousel extends StatefulWidget {
  /// Lista de socios a mostrar en el carrusel
  final List<Partner> partners;
  
  /// Duración entre cambios de tarjeta (por defecto 4 segundos)
  final Duration autoScrollDuration;
  
  /// Altura del carrusel
  final double height;
  
  /// Constructor del carrusel de socios
  const PartnersCarousel({
    super.key,
    required this.partners,
    this.autoScrollDuration = const Duration(seconds: 4),
    this.height = 180,
  });

  @override
  State<PartnersCarousel> createState() => _PartnersCarouselState();
}

class _PartnersCarouselState extends State<PartnersCarousel> {
  late PageController _pageController;
  late Timer _autoScrollTimer;
  int _currentPage = 0;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.75, // Reducido para mostrar tarjetas más cuadradas
      initialPage: _currentPage,
    );
    
    // Iniciar el temporizador para el desplazamiento automático
    _startAutoScroll();
  }
  
  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }
  
  /// Inicia el temporizador para el desplazamiento automático del carrusel
  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(widget.autoScrollDuration, (timer) {
      if (_currentPage < widget.partners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          // Carrusel principal
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: widget.partners.length,
              itemBuilder: (context, index) {
                // Aplicar animación de entrada escalonada a cada tarjeta
                return GlamAnimations.applyEntryEffect(
                  _buildPartnerCard(widget.partners[index]),
                  slideDistance: 0.15,
                  // Usamos retardo manual para escalonar las tarjetas
                  duration: Duration(milliseconds: 600 + (100 * index)),
                );
              },
            ),
          ),
          
          // Indicadores de página
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.partners.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index 
                      ? kAccentColor 
                      : ColorUtils.withOpacityValue(Colors.white, 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
  
  /// Construye una tarjeta individual para un socio
  Widget _buildPartnerCard(Partner partner) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: 1.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        // Establecemos un ancho fijo basado en una proporción más cuadrada
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          color: ColorUtils.withOpacityValue(kSurfaceColor, 0.7),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ColorUtils.withOpacityValue(Colors.black, 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Imagen de fondo con proporciones adecuadas
              Positioned.fill(
                child: Image.network(
                  partner.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: kPrimaryColorDark,
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported_rounded,
                          color: Colors.white54,
                          size: 32,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: kPrimaryColorDark,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: kAccentColor,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Gradiente oscuro para mejorar la legibilidad del texto
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        ColorUtils.withOpacityValue(Colors.black, 0.7),
                      ],
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),
              ),
              
              // Información del socio
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Nombre del negocio
                      Text(
                        partner.businessName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Categoría y puntuación
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Categoría
                          Text(
                            partner.category,
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorUtils.withOpacityValue(Colors.white, 0.8),
                            ),
                          ),
                          
                          // Puntuación
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: kAccentColor,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                partner.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
