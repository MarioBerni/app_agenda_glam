import 'package:app_agenda_glam/core/routes/app_page_transitions.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/recovery_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/login_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/register_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_plus/go_router_plus.dart';
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
        pageBuilder:
            (context, state) => AppPageTransitions.buildTransitionPage(
              context: context,
              state: state,
              child: const SplashScreen(),
              transitionType: TransitionType.fade,
            ),
      ),

      // Pantalla de bienvenida/selector (login/registro)
      GoRoute(
        path: welcome,
        pageBuilder:
            (context, state) => AppPageTransitions.buildTransitionPage(
              context: context,
              state: state,
              child: const WelcomePage(),
              transitionType: TransitionType.defaultTransition,
            ),
      ),

      // Pantalla de login
      GoRoute(
        path: login,
        pageBuilder:
            (context, state) => AppPageTransitions.buildTransitionPage(
              context: context,
              state: state,
              child: const LoginPage(),
              transitionType: TransitionType.authForward,
            ),
      ),

      // Pantalla de registro
      GoRoute(
        path: register,
        pageBuilder:
            (context, state) => AppPageTransitions.buildTransitionPage(
              context: context,
              state: state,
              child: const RegisterPage(),
              transitionType: TransitionType.authForward,
            ),
      ),

      // Pantalla de recuperación de contraseña
      GoRoute(
        path: recovery,
        pageBuilder:
            (context, state) => AppPageTransitions.buildTransitionPage(
              context: context,
              state: state,
              child: const RecoveryPage(),
              transitionType: TransitionType.authForward,
            ),
      ),

      // Pantalla de inicio (Home)
      GoRoute(
        path: home,
        pageBuilder:
            (context, state) => AppPageTransitions.buildTransitionPage(
              context: context,
              state: state,
              child: const HomeScreen(),
              transitionType: TransitionType.fade,
            ),
      ),
    ],
  );
}

/// Pantalla de splash temporal
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
