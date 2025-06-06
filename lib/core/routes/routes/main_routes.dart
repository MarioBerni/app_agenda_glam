import 'package:app_agenda_glam/core/routes/routes/app_routes.dart';
import 'package:app_agenda_glam/core/routes/routes/transitions_helpers.dart';
import 'package:app_agenda_glam/core/widgets/main_scaffold.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/welcome_page.dart';
import 'package:app_agenda_glam/features/explore/presentation/pages/explore_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Define las rutas principales de la aplicación que aparecen
/// dentro del MainNavigator con la barra de navegación inferior
class MainRoutes {
  /// Obtiene la configuración del shell para las rutas principales
  static ShellRoute getShellRoute() {
    return ShellRoute(
      builder: (context, state, child) {
        return MainNavigator(child: child);
      },
      routes: [
        // Pantalla principal (Home)
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
            context: context,
            state: state,
            child: const WelcomePage(),
          ),
        ),
        
        // Pantalla de exploración
        GoRoute(
          path: AppRoutes.explore,
          pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
            context: context,
            state: state,
            child: const ExplorePage(),
          ),
        ),
        
        // Pantalla de beneficios
        GoRoute(
          path: AppRoutes.benefits,
          pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
            context: context,
            state: state,
            child: const BenefitsPage(),
          ),
        ),
        
        // Pantalla de perfil
        GoRoute(
          path: AppRoutes.profile,
          pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
            context: context,
            state: state,
            child: const ProfilePage(),
          ),
        ),
      ],
    );
  }
}

/// Página de beneficios temporal (para prueba de navegación)
class BenefitsPage extends StatelessWidget {
  const BenefitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star_rounded, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            const Text(
              'Beneficios',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Descubre todas las ventajas de usar Agenda Glam',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Saber más'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Página de perfil temporal (para prueba de navegación)
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_rounded, size: 80, color: Colors.teal),
            const SizedBox(height: 20),
            const Text(
              'Perfil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Inicia sesión o regístrate para acceder a todas las funcionalidades',
              style: TextStyle(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.login),
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => context.go(AppRoutes.register),
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
