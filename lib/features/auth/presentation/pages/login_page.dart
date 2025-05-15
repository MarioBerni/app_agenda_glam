import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_logo.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Página de inicio de sesión usando el sistema visual unificado
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para los campos de texto
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  // Variables de estado
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;
  bool _rememberMe = false;
  
  // Criterios para la fortaleza de contraseña
  final Map<String, bool> _passwordCriteria = {
    'length': false,      // Al menos 6 caracteres
    'uppercase': false,   // Al menos una mayúscula
    'number': false,      // Al menos un número
  };

  @override
  void initState() {
    super.initState();
    // Escuchar cambios en el campo de contraseña para evaluar criterios
    _passwordController.addListener(_updatePasswordStrength);
  }
  
  @override
  void dispose() {
    _passwordController.removeListener(_updatePasswordStrength);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
  /// Actualiza la evaluación de fortaleza de la contraseña en tiempo real
  void _updatePasswordStrength() {
    final String password = _passwordController.text;
    
    setState(() {
      // Evaluar criterios
      _passwordCriteria['length'] = password.length >= 6;
      _passwordCriteria['uppercase'] = password.contains(RegExp(r'[A-Z]'));
      _passwordCriteria['number'] = password.contains(RegExp(r'[0-9]'));
    });
  }

  /// Intenta iniciar sesión con las credenciales proporcionadas
  void _login() {
    // Validación básica
    setState(() {
      _emailError = _validateEmail(_emailController.text);
      _passwordError = _validatePassword(_passwordController.text);
    });

    if (_emailError == null && _passwordError == null) {
      // Si todo está validado, intentar login
      context.read<AuthCubit>().login(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  /// Valida el formato del email
  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'El email es requerido';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un email válido';
    }
    
    return null;
  }

  /// Valida que la contraseña no esté vacía
  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'La contraseña es requerida';
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.loading:
            setState(() => _isLoading = true);
            break;
          case AuthStatus.authenticated:
            setState(() => _isLoading = false);
            // Navegar a la pantalla principal cuando esté autenticado
            context.go(AppRouter.home);
            break;
          case AuthStatus.error:
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Error desconocido')),
            );
            break;
          default:
            setState(() => _isLoading = false);
            break;
        }
      },
      builder: (context, state) {
        return GlamScaffold(
          title: 'Iniciar Sesión',
          subtitle: 'Bienvenido de nuevo',
          showBackButton: true,
          onBackPressed: () => context.go(AppRouter.welcome),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo con animación
                  Center(
                    child: GlamAnimations.applyLogoEffect(
                      const GlamLogo(
                        size: 70,
                        showTagline: false,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Campo de email
                  GlamAnimations.applyEntryEffect(
                    GlamTextField(
                      label: 'Email',
                      hintText: 'example@mail.com',
                      controller: _emailController,
                      errorText: _emailError,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                    ),
                    slideDistance: 0.12,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Campo de contraseña
                  GlamAnimations.applyEntryEffect(
                    GlamPasswordField(
                      label: 'Contraseña',
                      hintText: '••••••••',
                      controller: _passwordController,
                      errorText: _passwordError,
                      onFieldSubmitted: (_) => _login(),
                      // Habilitar indicador de fortaleza
                      showStrengthIndicator: true,
                      passwordCriteria: _passwordCriteria,
                    ),
                    slideDistance: 0.15,
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Opción "Recordarme" con interruptor estilizado
                  GlamAnimations.applyEntryEffect(
                    Row(
                      children: [
                        Switch(
                          value: _rememberMe,
                          onChanged: (value) => setState(() => _rememberMe = value),
                          activeColor: kAccentColor,
                          activeTrackColor: kAccentColor.withOpacity(0.4),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.white.withOpacity(0.3),
                        ),
                        Text('Recordarme',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const Spacer(),
                        // Enlace a recuperar contraseña
                        TextButton(
                          onPressed: () {
                            // Navegar a la página de recuperación de contraseña
                            context.go(AppRouter.recovery);
                          },
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: kAccentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    slideDistance: 0.18,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Botón de login con animación
                  GlamAnimations.applyEntryEffect(
                    GlamButton(
                      text: 'Iniciar Sesión',
                      onPressed: _isLoading ? null : _login,
                      isLoading: _isLoading,
                    ),
                    slideDistance: 0.22,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Separador elegante
                  GlamAnimations.applyEntryEffect(
                    GlamTextDivider(
                      text: 'O inicia sesión con',
                      textStyle: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    slideDistance: 0.25,
                  ),
                  
                  // Botones de redes sociales
                  const SizedBox(height: 24),
                  GlamAnimations.applyEntryEffect(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialButton(
                          icon: Icons.g_mobiledata_rounded,
                          backgroundColor: Colors.red.shade700,
                        ),
                        const SizedBox(width: 20),
                        _socialButton(
                          icon: Icons.facebook_rounded,
                          backgroundColor: Colors.blue.shade800,
                        ),
                      ],
                    ),
                    slideDistance: 0.28,
                  ),
                  
                  // Enlace a registro
                  const SizedBox(height: 32),
                  GlamAnimations.applyEntryEffect(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿No tienes una cuenta?',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go(AppRouter.register),
                          child: Text(
                            'Regístrate',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: kAccentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    slideDistance: 0.32,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  /// Construye un botón de inicio de sesión con redes sociales
  Widget _socialButton({
    required IconData icon,
    required Color backgroundColor,
  }) {
    return Material(
      color: backgroundColor,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Implementar inicio de sesión con redes sociales
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Funcionalidad en desarrollo'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}