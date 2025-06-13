import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/welcome_components/featured_partners_section.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/welcome_components/welcome_header.dart';
import 'package:app_agenda_glam/core/widgets/glam_icon_container.dart';
import 'package:app_agenda_glam/core/widgets/glam_emoji_container.dart';
import 'package:flutter/material.dart';

/// Página de bienvenida con diseño minimalista y elegante
/// que elimina botones tradicionales por áreas interactivas sutiles
/// y un enfoque visual sofisticado
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  // Controller para animaciones
  late AnimationController _animationController;
  
  // Estado para efectos visuales
  bool _isExploreHovered = false;
  bool _isLoginHovered = false;
  bool _isRegisterHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Manejar la navegación con efecto visual
  void _handleNavigation(NavigationType type) {
    // Pequeña animación de feedback visual
    _animationController.reverse().then((_) {
      if (!mounted) return;
      
      switch(type) {
        case NavigationType.explore:
          CircleNavigation.goToExplore(context);
          break;
        case NavigationType.login:
          CircleNavigation.goToLogin(context);
          break;
        case NavigationType.register:
          CircleNavigation.goToRegister(context);
          break;
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Fondo con gradiente elegante
          const GlamGradientBackground(
            primaryColor: kPrimaryColor,
            opacity: 0.95,
          ),
          
          // Contenido principal con diseño minimalista
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header con logo
                  const SizedBox(height: 30),
                  const WelcomeHeader(),
                  const SizedBox(height: 40),
                  
                  // Mensaje de bienvenida elegante
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: GlamAnimations.applyEntryEffect(
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Estilo que define ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                color: Colors.white.withOpacity(0.95),
                                height: 1.4,
                              ),
                            ),
                            const TextSpan(
                              text: 'personalidad',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: kAccentColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      slideDistance: 0.3,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Tagline sutil
                  GlamAnimations.applyEntryEffect(
                    Text(
                      'Experiencia personalizada para el cuidado masculino',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(0.7),
                        letterSpacing: 0.5,
                      ),
                    ),
                    slideDistance: 0.2,
                    duration: const Duration(milliseconds: 800),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Área principal con opciones de navegación elegantes
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Opción: Explorar
                        _buildNavigationOption(
                          icon: '🧭',
                          title: 'Descubrir tendencias',
                          subtitle: 'Explorar servicios y profesionales',
                          isActive: _isExploreHovered,
                          onHover: (value) => setState(() => _isExploreHovered = value),
                          onTap: () => _handleNavigation(NavigationType.explore),
                          delay: const Duration(milliseconds: 0),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Opción: Iniciar Sesión
                        _buildNavigationOption(
                          icon: '🔑',
                          title: 'Iniciar sesión',
                          subtitle: 'Accede a tu cuenta personal',
                          isActive: _isLoginHovered,
                          onHover: (value) => setState(() => _isLoginHovered = value),
                          onTap: () => _handleNavigation(NavigationType.login),
                          delay: const Duration(milliseconds: 100),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Opción: Registrarse
                        _buildNavigationOption(
                          icon: '👤',
                          title: 'Crear cuenta',
                          subtitle: 'Únete a la experiencia Glam',
                          isActive: _isRegisterHovered,
                          onHover: (value) => setState(() => _isRegisterHovered = value),
                          onTap: () => _handleNavigation(NavigationType.register),
                          delay: const Duration(milliseconds: 200),
                        ),
                      ],
                    ),
                  ),
                  
                  // Socios destacados con estilo minimalista
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                    child: GlamAnimations.applyEntryEffect(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'COLABORADORES PREMIUM',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const FeaturedPartnersSection(),
                        ],
                      ),
                      slideDistance: 0.15,
                      duration: const Duration(milliseconds: 1000),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Construye una opción de navegación elegante con efecto glassmorphism
  Widget _buildNavigationOption({
    required dynamic icon,
    required String title,
    required String subtitle,
    required bool isActive,
    required Function(bool) onHover,
    required VoidCallback onTap,
    required Duration delay,
  }) {
    return GlamAnimations.applyEntryEffect(
      MouseRegion(
        onEnter: (_) => onHover(true),
        onExit: (_) => onHover(false),
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: isActive 
                ? Colors.black.withOpacity(0.6) 
                : Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isActive 
                  ? kAccentColor.withOpacity(0.8) 
                  : Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Icono o emoji con estilo consistente
                icon is IconData
                ? GlamIconContainer(
                  icon: icon,
                  size: 50,
                  backgroundColor: isActive 
                    ? Colors.black.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.4),
                  enableShimmer: isActive,
                )
                : GlamEmojiContainer(
                  emoji: icon,
                  size: 50,
                  backgroundColor: isActive 
                    ? Colors.black.withOpacity(0.7) 
                    : Colors.black.withOpacity(0.4),
                  enableShimmer: isActive,
                ),
                const SizedBox(width: 16),
                
                // Textos informativos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: isActive ? kAccentColor : Colors.white.withOpacity(0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Indicador visual de acción
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isActive ? kAccentColor : Colors.white.withOpacity(0.3),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
      slideDistance: 0.25,
      duration: delay,
    );
  }
}

// Enum para los tipos de navegación
enum NavigationType {
  explore,
  login,
  register,
}