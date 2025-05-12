import 'package:app_agenda_glam/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/login_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/register_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Define las rutas de la aplicación utilizando go_router
/// Implementa la navegación basada en rutas para toda la app
class AppRouter {
  static const String home = '/';
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  
  /// Configuración del router con go_router
  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      // Pantalla de splash
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      
      // Pantalla de bienvenida/selector (login/registro)
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      
      // Pantalla de login
      GoRoute(
        path: login,
        builder: (context, state) => const LoginPage(),
      ),
      
      // Pantalla de registro
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterPage(),
      ),
      
      // Pantalla de recuperación de contraseña
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      
      // Pantalla de inicio (Home)
      GoRoute(
        path: home,
        builder: (context, state) => const HomeScreen(),
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

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navegar a la pantalla de bienvenida después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      context.go(AppRouter.welcome);
    });
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
            Icon(
              Icons.schedule,
              size: 80,
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
            const SizedBox(height: 16),
            Text(
              'Tu agenda de belleza masculina',
              style: theme.textTheme.bodyLarge,
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
      appBar: AppBar(
        title: const Text('Agenda Glam'),
      ),
      body: const Center(
        child: Text('Bienvenido a Agenda Glam'),
      ),
    );
  }
}
