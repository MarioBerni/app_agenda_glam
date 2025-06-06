import 'package:app_agenda_glam/core/routes/circle_page_route.dart';
import 'package:app_agenda_glam/core/routes/routes/app_routes.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/login_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/recovery_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/register_page.dart';
// Import eliminado por no ser utilizado
import 'package:app_agenda_glam/features/auth/presentation/pages/phone_register_page.dart';
import 'package:app_agenda_glam/features/explore/presentation/pages/explore_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Clase utilitaria para la navegación con transiciones circulares
/// 
/// Esta clase centraliza la navegación con transiciones circulares
/// para mantener la consistencia visual en toda la aplicación.
class CircleNavigation {
  /// Prevenir la instanciación
  CircleNavigation._();
  
  /// Navega a la página de bienvenida
  /// Originalmente usaba una transición circular desde la esquina inferior derecha
  /// Modificado para usar Navigator.pop() para compatibilidad con GoRouter
  static void goToWelcome(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  /// Navega hacia atrás desde la página de inicio de sesión a la página de bienvenida
  /// El círculo se expande desde la esquina inferior derecha (navegación hacia atrás)
  static void goBackFromLogin(BuildContext context) {
    // Usamos Navigator.pop() para mantener compatibilidad con GoRouter
    // evitando conflictos de estado al modificar la pila de navegación
    Navigator.of(context).pop();
  }
  
  /// Navega a la página de inicio de sesión con efecto circular
  /// El círculo se expande desde la esquina inferior izquierda (navegación hacia adelante)
  static void goToLogin(BuildContext context) {
    context.pushCircle(const LoginPage());
  }
  
  /// Versión segura para operaciones asíncronas que navega a la página de inicio de sesión
  /// Utiliza NavigatorState y ThemeData capturados antes de la operación asíncrona
  static void goToLoginWithState(NavigatorState navigator, ThemeData theme) {
    navigator.push(
      CirclePageRoute(
        page: const LoginPage(),
        circleColor: theme.primaryColor,
        alignment: Alignment.bottomLeft,
      ),
    );
  }
  
  /// Navega a la página de registro con efecto circular
  /// El círculo se expande desde la esquina inferior izquierda (navegación hacia adelante)
  static void goToRegister(BuildContext context) {
    context.pushCircle(const RegisterPage());
  }
  
  /// Versión segura para operaciones asíncronas que navega a la página de registro
  /// Utiliza NavigatorState y ThemeData capturados antes de la operación asíncrona
  static void goToRegisterWithState(NavigatorState navigator, ThemeData theme) {
    navigator.push(
      CirclePageRoute(
        page: const RegisterPage(),
        circleColor: theme.primaryColor,
        alignment: Alignment.bottomLeft,
      ),
    );
  }
  
  /// Navega a la página de recuperación de contraseña con efecto circular
  /// El círculo se expande desde la esquina inferior izquierda (navegación hacia adelante)
  static void goToRecovery(BuildContext context) {
    context.pushCircle(const RecoveryPage());
  }
  
  /// Navega hacia atrás desde la página de recovery a la página de login
  /// Originalmente usaba una transición circular desde la esquina inferior derecha
  /// Modificado para usar Navigator.pop() para compatibilidad con GoRouter
  static void goBackToLogin(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  /// Navega a la página de registro con teléfono con efecto circular
  /// El círculo se expande desde la esquina inferior izquierda (navegación hacia adelante)
  static void goToPhoneRegister(BuildContext context) {
    context.pushCircle(const PhoneRegisterPage());
  }
  
  /// Navega hacia atrás desde la página de phone register a la página de registro
  /// Originalmente usaba una transición circular desde la esquina inferior derecha
  /// Modificado para usar Navigator.pop() para compatibilidad con GoRouter
  static void goBackToRegister(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  /// Navega hacia atrás desde la página de información adicional de Google a la página de registro
  /// Originalmente usaba una transición circular desde la esquina inferior derecha
  /// Modificado para usar Navigator.pop() para compatibilidad con GoRouter
  static void goBackFromGoogleAdditionalInfo(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  /// Navega hacia atrás desde la página de información adicional de registro telefónico
  /// Originalmente usaba una transición circular desde la esquina inferior derecha
  /// Modificado para usar Navigator.pop() para compatibilidad con GoRouter
  static void goBackFromPhoneAdditionalInfo(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  /// Navega a la página de inicio con el router estándar
  /// Se utiliza el router estándar para la navegación a la página principal
  /// ya que es una transición especial que marca el ingreso a la aplicación
  static void goToHome(BuildContext context) {
    context.go(AppRoutes.home);
  }
  
  /// Navega a la página de exploración sin registro con efecto circular
  /// El círculo se expande desde la esquina inferior izquierda (navegación hacia adelante)
  static void goToExplore(BuildContext context) {
    context.pushCircle(const ExplorePage());
  }
  
  /// Versión segura para operaciones asíncronas que navega a la página de exploración
  /// Utiliza NavigatorState y ThemeData capturados antes de la operación asíncrona
  static void goToExploreWithState(NavigatorState navigator, ThemeData theme) {
    navigator.push(
      CirclePageRoute(
        page: const ExplorePage(),
        circleColor: theme.primaryColor,
        alignment: Alignment.bottomLeft,
      ),
    );
  }
}
