import 'package:app_agenda_glam/core/routes/routes/app_routes.dart';
import 'package:app_agenda_glam/core/routes/routes/auth_routes.dart';
import 'package:app_agenda_glam/core/routes/routes/main_routes.dart';
import 'package:app_agenda_glam/core/routes/routes/splash_route.dart';
import 'package:go_router/go_router.dart';

/// Define las rutas de la aplicación utilizando go_router
/// Implementa la navegación basada en rutas para toda la app
/// 
/// Esta clase actúa como punto central de integración para todas las rutas
/// modulares definidas en los archivos separados por características
class AppRouter {
  // Las constantes de rutas ahora están en AppRoutes
  // para una mejor organización y reutilización
  
  /// Configuración del router con go_router y transiciones estándar
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    // Configuración global para transiciones estándar
    routes: [
      // Integra todas las rutas de módulos separados
      
      // 1. Ruta de splash screen (fuera del shell y auth)
      SplashRoute.getRoute(),
      
      // 2. Rutas de autenticación
      ...AuthRoutes.getRoutes(),
      
      // 3. Rutas principales con shell para navegación con tabs
      MainRoutes.getShellRoute(),
    ],
  );
}