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

/// Página de registro de nuevos usuarios
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    // Validación básica
    setState(() {
      _nameError = _validateName(_nameController.text);
      _emailError = _validateEmail(_emailController.text);
      _passwordError = _validatePassword(_passwordController.text);
      _confirmPasswordError = _validateConfirmPassword(
        _passwordController.text,
        _confirmPasswordController.text,
      );
    });

    if (_nameError == null && 
        _emailError == null && 
        _passwordError == null && 
        _confirmPasswordError == null) {
      // Si todo está validado, intentar registro
      context.read<AuthCubit>().register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
  }

  String? _validateName(String value) {
    if (value.isEmpty) {
      return 'El nombre es requerido';
    }
    
    return null;
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
    
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    
    return null;
  }

  String? _validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'Confirma tu contraseña';
    }
    
    if (password != confirmPassword) {
      return 'Las contraseñas no coinciden';
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
              // Navegar a la pantalla principal cuando esté registrado
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
                        'Crea tu cuenta',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Regístrate para comenzar',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Campo de nombre
                      GlamTextField(
                        label: 'Nombre completo',
                        hintText: 'Juan Pérez',
                        controller: _nameController,
                        errorText: _nameError,
                        keyboardType: TextInputType.name,
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 24),
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
                      ),
                      const SizedBox(height: 24),
                      // Campo de confirmar contraseña
                      GlamPasswordField(
                        label: 'Confirmar contraseña',
                        hintText: '••••••••',
                        controller: _confirmPasswordController,
                        errorText: _confirmPasswordError,
                        onEditingComplete: _register,
                      ),
                      const SizedBox(height: 32),
                      // Botón de registro
                      GlamButton(
                        text: 'Registrarse',
                        onPressed: _isLoading ? null : _register,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 24),
                      // Enlace a login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '¿Ya tienes una cuenta?',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onBackground.withOpacity(0.8),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.go(AppRouter.login),
                            child: Text(
                              'Inicia sesión',
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
