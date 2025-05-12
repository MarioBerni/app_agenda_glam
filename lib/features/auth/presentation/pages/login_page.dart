import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_logo.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_password_field.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo reducido
                      const Center(
                        child: GlamLogo(
                          size: 60,
                          showTagline: false,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Título
                      Text(
                        'Iniciar Sesión',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Bienvenido de nuevo',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Campo de email
                      GlamTextField(
                        label: 'Email',
                        hintText: 'example@mail.com',
                        controller: _emailController,
                        errorText: _emailError,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Campo de contraseña
                      GlamPasswordField(
                        label: 'Contraseña',
                        hintText: '••••••••',
                        controller: _passwordController,
                        errorText: _passwordError,
                        onEditingComplete: _login,
                      ),
                      const SizedBox(height: 12),
                      // Enlace a recuperar contraseña
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Navegar a la página de recuperación de contraseña
                            context.go(AppRouter.forgotPassword);
                          },
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Botón de login
                      GlamButton(
                        text: 'Iniciar Sesión',
                        onPressed: _isLoading ? null : _login,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 24),
                      // Enlace a registro
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '¿No tienes una cuenta?',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onBackground.withOpacity(0.8),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go(AppRouter.register),
                            child: Text(
                              'Regístrate',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
