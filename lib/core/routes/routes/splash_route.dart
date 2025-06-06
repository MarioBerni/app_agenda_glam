import 'package:app_agenda_glam/core/routes/routes/app_routes.dart';
import 'package:app_agenda_glam/core/routes/routes/transitions_helpers.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Define la ruta para la pantalla de splash
class SplashRoute {
  /// Obtiene la configuración de la ruta del splash
  static RouteBase getRoute() {
    return GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
        context: context,
        state: state,
        child: const SplashScreen(),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }
}

/// Pantalla de splash
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _showButton = false;
  
  @override
  void initState() {
    super.initState();
    
    // Mostrar el botón después de un retraso
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showButton = true;
        });
      }
    });
  }
  
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kPrimaryColorDark,
              kPrimaryColor,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo con animación
              Icon(
                Icons.event_available_rounded,
                size: 100,
                color: theme.colorScheme.secondary,
              ),

              const SizedBox(height: 24),
              Text(
                'Agenda Glam',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 60),
              // Botón con animación de aparición
              AnimatedOpacity(
                opacity: _showButton ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                child: AnimatedScale(
                  scale: _showButton ? 1.0 : 0.8,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.elasticOut,
                  child: ElevatedButton(
                    onPressed: () => context.go(AppRoutes.home),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('Comenzar', style: TextStyle(fontSize: 18)),
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
