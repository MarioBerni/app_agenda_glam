import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_background.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_logo.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_password_field.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// Página de inicio de sesión
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'La contraseña es requerida';
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.go(AppRouter.welcome),
          child: GlamAnimations.applyEntryEffect(
            const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
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
          return Stack(
            children: [
              // Fondo con degradado y patrón sutil
              const GlamBackground(intensity: 0.7),
              
              // Contenido principal
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
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
                          // Título con animación de entrada
                          GlamAnimations.applyEntryEffect(
                            Text(
                              'Iniciar Sesión',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            slideDistance: 0.05,
                          ),
                          const SizedBox(height: 8),
                          GlamAnimations.applyEntryEffect(
                            Text(
                              'Bienvenido de nuevo',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                            slideDistance: 0.08,
                          ),
                          const SizedBox(height: 32),
                          // Campos de formulario con animaciones escalonadas
                          const SizedBox(height: 32),
                          GlamAnimations.applyEntryEffect(
                            GlamTextField(
                              label: 'Email',
                              hintText: 'example@mail.com',
                              controller: _emailController,
                              errorText: _emailError,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                            slideDistance: 0.12,
                          ),
                          const SizedBox(height: 24),
                          GlamAnimations.applyEntryEffect(
                            GlamPasswordField(
                              label: 'Contraseña',
                              hintText: '••••••••',
                              controller: _passwordController,
                              errorText: _passwordError,
                              onEditingComplete: _login,
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
                                    context.go(AppRouter.forgotPassword);
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
                          const SizedBox(height: 24),
                          GlamAnimations.applyEntryEffect(
                            Row(
                              children: [
                                Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    'O inicia sesión con',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                ),
                                Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                              ],
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  // Método para crear botones de redes sociales
  Widget _socialButton({
    required IconData icon,
    required Color backgroundColor,
  }) {
    return GlamAnimations.applyButtonPressEffect(
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
