import 'package:app_agenda_glam/core/routes/routes/app_routes.dart';
import 'package:app_agenda_glam/core/routes/routes/transitions_helpers.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/login_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/recovery_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/register_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/welcome_page.dart';
import 'package:go_router/go_router.dart';

/// Define las rutas relacionadas con autenticación de la aplicación
class AuthRoutes {
  /// Obtiene todas las rutas de autenticación para agregarlas al router principal
  static List<RouteBase> getRoutes() {
    return [
      // Pantalla de bienvenida/selector (login/registro)
      GoRoute(
        path: AppRoutes.welcome,
        pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
          context: context,
          state: state,
          child: const WelcomePage(),
        ),
      ),
      
      // Pantalla de inicio de sesión
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
          context: context,
          state: state,
          child: const LoginPage(),
        ),
      ),

      // Pantalla de registro
      GoRoute(
        path: AppRoutes.register,
        pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
          context: context,
          state: state,
          child: const RegisterPage(),
        ),
      ),

      // Pantalla de recuperación
      GoRoute(
        path: AppRoutes.recovery,
        pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
          context: context,
          state: state,
          child: const RecoveryPage(),
        ),
      ),
    ];
  }
}
