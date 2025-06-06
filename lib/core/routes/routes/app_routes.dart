/// Define todas las rutas de la aplicación como constantes
/// para evitar errores de string literal
class AppRoutes {
  AppRoutes._(); // Constructor privado para evitar instanciación

  // Rutas de autenticación
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String recovery = '/recovery';
  
  // Rutas principales con barra de navegación
  static const String home = '/home';
  static const String explore = '/explore';
  static const String benefits = '/benefits';
  static const String profile = '/profile';
}
