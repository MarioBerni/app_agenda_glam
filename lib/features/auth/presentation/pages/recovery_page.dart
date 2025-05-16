import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_agenda_glam/features/auth/presentation/controllers/recovery_controller.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/recovery_confirmation.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/recovery_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla para recuperación de contraseña con flujo visual completo
///
/// Implementa un proceso de recuperación de contraseña con dos estados principales:
/// 1. Formulario para ingresar el email
/// 2. Confirmación de envío con animación
///
/// Sigue el patrón de arquitectura limpia con separación de:
/// - Presentación (UI)
/// - Controlador (lógica de interacción)
/// - Validador (lógica de dominio)
class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage>
    with SingleTickerProviderStateMixin {
  // Controlador de texto para el campo de email
  final _emailController = TextEditingController();

  // Estado de la página
  bool _isLoading = false;
  bool _emailSent = false;
  String? _error;

  // Controladores
  late final AnimationController _animController;
  late final RecoveryController _recoveryController;

  @override
  void initState() {
    super.initState();

    // Inicializar controlador de animación
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Inicializar controlador de recuperación
    _recoveryController = RecoveryController(
      animationController: _animController,
      onError: _setError,
      onStartProcessing: _startProcessing,
      onEndProcessing: _endProcessing,
      onEmailSent: _onEmailSent,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _animController.dispose();
    _recoveryController.dispose();
    super.dispose();
  }

  /// Inicia el proceso de recuperación de contraseña
  void _recoverPassword() {
    // Limpiar error previo
    setState(() => _error = null);

    // Iniciar proceso de recuperación usando el controlador
    _recoveryController.recoverPassword(_emailController.text);
  }

  /// Callback cuando hay un error
  void _setError(String message) {
    setState(() => _error = message);
  }

  /// Callback cuando inicia el procesamiento
  void _startProcessing() {
    setState(() => _isLoading = true);
  }

  /// Callback cuando finaliza el procesamiento
  void _endProcessing() {
    setState(() => _isLoading = false);
  }

  /// Callback cuando se ha enviado el email
  void _onEmailSent() {
    setState(() => _emailSent = true);
  }

  // Nota: Se podría implementar un método para reiniciar el flujo
  // en caso de que se necesite volver al formulario desde la confirmación

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        // Aquí se pueden manejar cambios de estado globales del AuthCubit
        // Por ejemplo, si el usuario ya inició sesión, redirigir
      },
      child: GlamScaffold(
        title: _emailSent ? 'Recuperación Enviada' : 'Recuperar Contraseña',
        subtitle:
            _emailSent
                ? null
                : 'Te enviaremos instrucciones para restablecer tu contraseña',
        content:
            _emailSent
                // Si se envió el email, mostrar confirmación
                ? RecoveryConfirmation(email: _emailController.text)
                // Si no, mostrar formulario
                : RecoveryContent(
                  emailController: _emailController,
                  isLoading: _isLoading,
                  onRecoverPassword: _recoverPassword,
                  error: _error,
                ),
      ),
    );
  }
}
