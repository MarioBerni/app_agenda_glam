import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_logo.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// PÃ¡gina para recuperar contraseÃ±a olvidada
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _emailError;
  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _requestPasswordReset() {
    // ValidaciÃ³n bÃ¡sica
    setState(() {
      _emailError = _validateEmail(_emailController.text);
    });

    if (_emailError == null) {
      // Si el email es vÃ¡lido, enviar solicitud
      context.read<AuthCubit>().recoverPassword(_emailController.text);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state.status) {
            case AuthStatus.loading:
              setState(() {
                _isLoading = true;
                _isSuccess = false;
              });
              break;
            case AuthStatus.unauthenticated:
              setState(() {
                _isLoading = false;
                _isSuccess = true;
              });
              break;
            case AuthStatus.error:
              setState(() {
                _isLoading = false;
                _isSuccess = false;
              });
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
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child:
                      _isSuccess
                          ? _buildSuccessView(theme)
                          : _buildFormView(theme),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormView(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo reducido
        const Center(child: GlamLogo(size: 60, showTagline: false)),
        const SizedBox(height: 32),
        // TÃ­tulo
        Text(
          'Recuperar contraseÃ±a',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Ingresa tu email y te enviaremos un enlace para restablecer tu contraseÃ±a',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
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
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 32),
        // BotÃ³n de enviar
        GlamButton(
          text: 'Enviar enlace',
          onPressed: _isLoading ? null : _requestPasswordReset,
          isLoading: _isLoading,
        ),
        const SizedBox(height: 24),
        // Enlace a login
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Â¿Recordaste tu contraseÃ±a?',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            TextButton(
              onPressed: () => context.go(AppRouter.login),
              child: Text(
                'Inicia sesiÃ³n',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSuccessView(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Icon(
          Icons.check_circle_outline,
          size: 80,
          color: theme.colorScheme.secondary,
        ),
        const SizedBox(height: 24),
        Text(
          'Â¡Enlace enviado!',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Te hemos enviado un correo con instrucciones para restablecer tu contraseÃ±a',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        GlamButton(
          text: 'Volver a inicio de sesiÃ³n',
          onPressed: () => context.go(AppRouter.login),
        ),
      ],
    );
  }
}
