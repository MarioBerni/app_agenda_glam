import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/core/routes/circle_page_route.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/login_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/recovery_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/register_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Clase utilitaria para la navegación con transiciones circulares
/// 
/// Esta clase centraliza la navegación con transiciones circulares
/// para mantener la consistencia visual en toda la aplicación.
class CircleNavigation {
  /// Prevenir la instanciación
  CircleNavigation._();
  
  /// Navega a la página de bienvenida con efecto circular
  /// El círculo se expande desde la esquina inferior derecha (navegación hacia atrás)
  static void goToWelcome(BuildContext context) {
    context.popCircle(const WelcomePage());
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
  
  /// Navega desde la página de recuperación a la página de login con efecto circular
  /// El círculo se expande desde la esquina inferior derecha (navegación hacia atrás)
  static void goBackToLogin(BuildContext context) {
    context.popCircle(const LoginPage());
  }
  
  /// Navega a la página de inicio con el router estándar
  /// Se utiliza el router estándar para la navegación a la página principal
  /// ya que es una transición especial que marca el ingreso a la aplicación
  static void goToHome(BuildContext context) {
    context.go(AppRouter.home);
  }
}
