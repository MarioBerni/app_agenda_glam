import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart'; // Para usar GlamUI.buildHeader
import 'package:app_agenda_glam/features/auth/presentation/widgets/login_form.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/login_header.dart';
import 'package:flutter/material.dart';

/// Página de inicio de sesión que permite a los usuarios acceder a su cuenta
/// con un diseño visual elegante consistente con las demás páginas de autenticación

/// Página de inicio de sesión que permite a los usuarios acceder a su cuenta
/// con un diseño visual elegante y animaciones fluidas
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Estado del formulario
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    super.dispose();
  }

  // Función para manejar el inicio de sesión con email o teléfono
  void _handleLogin(String identifier, String password, bool isEmail) {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    // Simula un proceso de inicio de sesión
    Future.delayed(const Duration(seconds: 2), () {
      // Aquí se implementaría la lógica real de autenticación
      // usando el BLoC/Cubit y los casos de uso
      
      // Logueamos el tipo de identificador usado para debugging
      debugPrint('Iniciando sesión con ${isEmail ? "email" : "teléfono"}: $identifier');
      
      // Por ahora, simulamos un error para mostrar la UI
      if (isEmail && identifier == 'error@example.com') {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Credenciales incorrectas. Intenta nuevamente.';
        });
      } else {
        // Login exitoso, navegar a la pantalla principal
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          
          // Usar navegación centralizada para ir a Home
          CircleNavigation.goToHome(context);
        }
      }
    });
  }

  // Función para manejar el inicio de sesión con Google
  void _handleGoogleLogin() {
    setState(() {
      _isGoogleLoading = true;
      _errorMessage = null;
    });
    
    // Simula un proceso de inicio de sesión con Google
    Future.delayed(const Duration(seconds: 2), () {
      // Aquí se implementaría la integración real con Firebase Auth o Google Sign-In
      // usando el BLoC/Cubit y los casos de uso
      
      debugPrint('Iniciando sesión con Google');
      
      // Login exitoso, navegar a la pantalla principal
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
        
        // Usar navegación centralizada para ir a Home
        CircleNavigation.goToHome(context);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // Controla el redimensionamiento cuando aparece el teclado
      // false: el contenido no se redimensiona (el fondo permanece estable)
      resizeToAvoidBottomInset: false,
      // No usamos AppBar aquí, en su lugar incorporamos el encabezado directamente en el contenido
      body: Stack(
        children: [
          // Fondo degradado centralizado
          const GlamGradientBackground(
            primaryColor: kPrimaryColor,
            opacity: 0.9,
          ),
          
          // Contenido principal
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Encabezado unificado con botón de retroceso dorado y espaciado superior integrado
                    GlamAnimations.applyEntryEffect(
                      GlamUI.buildHeader(
                        context,
                        title: 'Iniciar Sesión',
                        subtitle: 'Accede a tu cuenta para gestionar tus citas y servicios',
                        onBackPressed: () => CircleNavigation.goToWelcome(context),
                        // El espaciado superior ahora está integrado en el componente
                        // con un valor predeterminado de 0.04
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Logo y elementos visuales adicionales
                    const LoginHeader(showTitle: false),
                    
                    // Formulario de login
                    LoginForm(
                      onLogin: _handleLogin,
                      onGoogleLogin: _handleGoogleLogin,
                      isLoading: _isLoading,
                      isGoogleLoading: _isGoogleLoading,
                      errorMessage: _errorMessage,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Divisor dorado elegante
                    const GlamDivider(
                      widthFactor: 0.8, // 80% del ancho disponible
                      primaryOpacity: 0.5, // Sutilmente visible
                      animate: true, // Con animación de aparición
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Enlace para crear cuenta
                    GlamAnimations.applyEntryEffect(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '¿No tienes una cuenta?',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Usar la navegación centralizada con transición circular
                              CircleNavigation.goToRegister(context);
                            },
                            child: const Text(
                              'Regístrate',
                              style: TextStyle(
                                color: kAccentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      slideDistance: 0.25,
                    ),
                    
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}