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

/// PÃ¡gina de inicio de sesiÃ³n usando el sistema visual unificado
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

  // Criterios para la fortaleza de contraseÃ±a
  final Map<String, bool> _passwordCriteria = {
    'length': false, // Al menos 6 caracteres
    'uppercase': false, // Al menos una mayÃºscula
    'number': false, // Al menos un nÃºmero
  };

  @override
  void initState() {
    super.initState();
    // Escuchar cambios en el campo de contraseÃ±a para evaluar criterios
    _passwordController.addListener(_updatePasswordStrength);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_updatePasswordStrength);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Actualiza la evaluaciÃ³n de fortaleza de la contraseÃ±a en tiempo real
  void _updatePasswordStrength() {
    final String password = _passwordController.text;

    setState(() {
      // Evaluar criterios
      _passwordCriteria['length'] = password.length >= 6;
      _passwordCriteria['uppercase'] = password.contains(RegExp(r'[A-Z]'));
      _passwordCriteria['number'] = password.contains(RegExp(r'[0-9]'));
    });
  }

  /// Intenta iniciar sesiÃ³n con las credenciales proporcionadas
  void _login() {
    // ValidaciÃ³n bÃ¡sica
    setState(() {
      _emailError = _validateEmail(_emailController.text);
      _passwordError = _validatePassword(_passwordController.text);
    });

    if (_emailError == null && _passwordError == null) {
      // Si todo estÃ¡ validado, intentar login
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
      return 'Ingresa un email vÃ¡lido';
    }

    return null;
  }

  /// Valida que la contraseÃ±a no estÃ© vacÃ­a
  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'La contraseÃ±a es requerida';
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
            // Navegar a la pantalla principal cuando estÃ© autenticado
            context.go(AppRouter.home);
            break;
          case AuthStatus.error:
            setState(() => _isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Error desconocido'),
              ),
            );
            break;
          default:
            setState(() => _isLoading = false);
            break;
        }
      },
      builder: (context, state) {
        return GlamScaffold(
          title: 'Iniciar SesiÃ³n',
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
                  // Logo con animaciÃ³n
                  Center(
                    child: GlamAnimations.applyLogoEffect(
                      const GlamLogo(size: 70, showTagline: false),
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

                  // Campo de contraseÃ±a
                  GlamAnimations.applyEntryEffect(
                    GlamPasswordField(
                      label: 'ContraseÃ±a',
                      hintText: 'â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢',
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

                  // OpciÃ³n "Recordarme" con interruptor estilizado
                  GlamAnimations.applyEntryEffect(
                    Row(
                      children: [
                        Switch(
                          value: _rememberMe,
                          onChanged:
                              (value) => setState(() => _rememberMe = value),
                          activeColor: kAccentColor,
                          activeTrackColor: kAccentColor.withValues(alpha: 0.4),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.white.withValues(
                            alpha: 0.3,
                          ),
                        ),
                        Text(
                          'Recordarme',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                        const Spacer(),
                        // Enlace a recuperar contraseÃ±a
                        TextButton(
                          onPressed: () {
                            // Navegar a la pÃ¡gina de recuperaciÃ³n de contraseÃ±a
                            context.go(AppRouter.recovery);
                          },
                          child: Text(
                            'Â¿Olvidaste tu contraseÃ±a?',
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

                  // BotÃ³n de login con animaciÃ³n
                  GlamAnimations.applyEntryEffect(
                    GlamButton(
                      text: 'Iniciar SesiÃ³n',
                      onPressed: _isLoading ? null : _login,
                      isLoading: _isLoading,
                    ),
                    slideDistance: 0.22,
                  ),

                  const SizedBox(height: 24),

                  // Separador elegante
                  GlamAnimations.applyEntryEffect(
                    GlamTextDivider(
                      text: 'O inicia sesiÃ³n con',
                      textStyle: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
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
                          'Â¿No tienes una cuenta?',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go(AppRouter.register),
                          child: Text(
                            'RegÃ­strate',
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

  /// Construye un botÃ³n de inicio de sesiÃ³n con redes sociales
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
          // Implementar inicio de sesiÃ³n con redes sociales
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
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
