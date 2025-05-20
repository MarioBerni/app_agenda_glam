import 'dart:math' as math;
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/recovery_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/login_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/register_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Define las rutas de la aplicación utilizando go_router
/// Implementa la navegación basada en rutas para toda la app
class AppRouter {
  static const String home = '/';
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String recovery = '/recovery';

  /// Configuración del router con go_router y transiciones personalizadas
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      // Pantalla de splash
      GoRoute(
        path: splash,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SplashScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Usar fade para la pantalla de splash
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          );
        },
      ),

      // Pantalla de bienvenida/selector (login/registro)
      GoRoute(
        path: welcome,
        pageBuilder: (context, state) {
          final bool isBack = state.extra != null && 
                               state.extra is Map && 
                               (state.extra as Map)['isBack'] == true;
          
          return CustomTransitionPage(
            key: state.pageKey,
            child: const WelcomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return buildCircleTransition(
                context: context,
                animation: animation,
                child: child,
                alignment: isBack ? Alignment.bottomRight : Alignment.bottomLeft,
              );
            },
            transitionDuration: const Duration(milliseconds: 1200),
          );
        },
      ),

      // Pantalla de login
      GoRoute(
        path: login,
        pageBuilder: (context, state) {
          final bool isBack = state.extra != null && 
                               state.extra is Map && 
                               (state.extra as Map)['isBack'] == true;
          
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LoginPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return buildCircleTransition(
                context: context,
                animation: animation,
                child: child,
                alignment: isBack ? Alignment.bottomRight : Alignment.bottomLeft,
              );
            },
            transitionDuration: const Duration(milliseconds: 1200),
          );
        },
      ),

      // Pantalla de registro
      GoRoute(
        path: register,
        pageBuilder: (context, state) {
          final bool isBack = state.extra != null && 
                               state.extra is Map && 
                               (state.extra as Map)['isBack'] == true;
          
          return CustomTransitionPage(
            key: state.pageKey,
            child: const RegisterPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return buildCircleTransition(
                context: context,
                animation: animation,
                child: child,
                alignment: isBack ? Alignment.bottomRight : Alignment.bottomLeft,
              );
            },
            transitionDuration: const Duration(milliseconds: 1200),
          );
        },
      ),

      // Pantalla de recuperación de contraseña
      GoRoute(
        path: recovery,
        pageBuilder: (context, state) {
          final bool isBack = state.extra != null && 
                               state.extra is Map && 
                               (state.extra as Map)['isBack'] == true;
          
          return CustomTransitionPage(
            key: state.pageKey,
            child: const RecoveryPage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return buildCircleTransition(
                context: context,
                animation: animation,
                child: child,
                alignment: isBack ? Alignment.bottomRight : Alignment.bottomLeft,
              );
            },
            transitionDuration: const Duration(milliseconds: 1200),
          );
        },
      ),

      // Pantalla de inicio (Home)
      GoRoute(
        path: home,
        pageBuilder: (context, state) {
          final bool isBack = state.extra != null && 
                               state.extra is Map && 
                               (state.extra as Map)['isBack'] == true;
          
          return CustomTransitionPage(
            key: state.pageKey,
            child: const HomeScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return buildCircleTransition(
                context: context,
                animation: animation,
                child: child,
                alignment: isBack ? Alignment.bottomRight : Alignment.bottomLeft,
              );
            },
            transitionDuration: const Duration(milliseconds: 1200),
          );
        },
      ),
    ],
  );
}

/// Pantalla de splash temporal
/// Función para construir una transición de círculo con la alineación especificada
Widget buildCircleTransition({
  required BuildContext context,
  required Animation<double> animation,
  required Widget child,
  required Alignment alignment,
}) {
  return Stack(
    children: [
      // Fondo común que permanece visible durante toda la transición
      const GlamGradientBackground(),
      
      // Utilizar la animación proporcionada por GoRouter para animar el círculo
      AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return ClipPath(
            clipper: CircleRevealClipper(
              fraction: animation.value,
              alignment: alignment,
            ),
            child: child,
          );
        },
      ),
    ],
  );
}

/// Clipper que crea un círculo que se expande para la transición
class CircleRevealClipper extends CustomClipper<Path> {
  /// Valor entre 0.0 y 1.0 que indica cuánto del círculo se ha revelado
  final double fraction;
  
  /// Alineación del centro del círculo
  final Alignment alignment;
  
  CircleRevealClipper({
    required this.fraction,
    required this.alignment,
  });
  
  @override
  Path getClip(Size size) {
    final center = Offset(
      size.width * (alignment.x * 0.5 + 0.5),
      size.height * (alignment.y * 0.5 + 0.5),
    );
    
    // Calculamos el radio máximo necesario para cubrir toda la pantalla
    final maxRadius = math.sqrt(
      math.pow(size.width, 2) + math.pow(size.height, 2)
    );
    
    // Actualizar todas las llamadas a context.go en los botones para especificar la dirección de navegación
    // Ejemplo:
    // context.go(AppRouter.welcome) -> context.go(AppRouter.welcome, extra: {'isBack': true})
    final radius = maxRadius * fraction;
    
    final path = Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );
      
    return path;
  }
  
  @override
  bool shouldReclip(CircleRevealClipper oldClipper) {
    return oldClipper.fraction != fraction || oldClipper.alignment != alignment;
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Controlador para animación del botón
  late AnimationController _buttonAnimController;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();

    // Inicializar controlador de animación
    _buttonAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Mostrar el botón después de 2 segundos para dar tiempo a que se aprecien las animaciones
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showButton = true;
        });
        _buttonAnimController.forward();
      }
    });
  }

  @override
  void dispose() {
    _buttonAnimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Aquí podría ir un logo o imagen cuando se tengan los assets
            Icon(Icons.schedule, size: 80, color: theme.colorScheme.secondary)
                .animate()
                .fade(duration: const Duration(milliseconds: 800))
                .scale(delay: const Duration(milliseconds: 300)),

            const SizedBox(height: 24),
            Text(
                  'Agenda Glam',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .animate()
                .fade(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 400),
                )
                .slideY(
                  begin: 0.2,
                  end: 0,
                  delay: const Duration(milliseconds: 400),
                ),

            const SizedBox(height: 16),
            Text(
                  'Tu agenda de belleza masculina',
                  style: theme.textTheme.bodyLarge,
                )
                .animate()
                .fade(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 700),
                )
                .slideY(
                  begin: 0.2,
                  end: 0,
                  delay: const Duration(milliseconds: 700),
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
                  onPressed: () => context.go(AppRouter.welcome),
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
    );
  }
}

/// Pantalla Home temporal
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agenda Glam')),
      body: const Center(child: Text('Bienvenido a Agenda Glam')),
    );
  }
}
