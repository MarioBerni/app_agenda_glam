import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_agenda_glam/features/auth/presentation/controllers/recovery_controller.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/recovery_confirmation.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/recovery_content.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/recovery_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pantalla para recuperación de contraseña con flujo visual completo
///
/// Implementa un proceso de recuperación de contraseña con dos estados principales:
/// 1. Formulario para ingresar el email o teléfono
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
  // Controlador de texto para el campo de identificador (email o teléfono)
  final _identifierController = TextEditingController();
  
  // Para rastrear si se está usando email o teléfono
  bool _isEmailMode = true;

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
    _identifierController.dispose();
    _animController.dispose();
    _recoveryController.dispose();
    super.dispose();
  }

  /// Inicia el proceso de recuperación de contraseña
  void _recoverPassword() {
    // Limpiar error previo
    setState(() => _error = null);

    // Iniciar proceso de recuperación usando el controlador
    _recoveryController.recoverPassword(_identifierController.text, _isEmailMode);
  }
  
  /// Actualiza el modo de identificación (email o teléfono)
  void _onIdentifierModeChanged(bool isEmail) {
    setState(() {
      _isEmailMode = isEmail;
    });
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GlamAnimations.applyEntryEffect(
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => CircleNavigation.goBackToLogin(context),
            ),
          ),
        ),
        body: Stack(
          children: [
            // Fondo degradado elegante
            const GlamGradientBackground(
              primaryColor: kPrimaryColor,
              opacity: 0.9,
            ),
            
            // Contenido principal
            SafeArea(
              child: SingleChildScrollView(
                child: _emailSent
                  // Si se envió el email o SMS, mostrar confirmación
                  ? RecoveryConfirmation(identifier: _identifierController.text, isEmail: _isEmailMode)
                  // Si no, mostrar formulario
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Encabezado con icono y título
                        const RecoveryHeader(),
                        
                        // Espacio entre header y formulario
                        const SizedBox(height: 32),
                        
                        // Formulario de recuperación (ahora sin padding innecesario)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: RecoveryContent(
                            identifierController: _identifierController,
                            isLoading: _isLoading,
                            onRecoverPassword: _recoverPassword,
                            onIdentifierTypeChanged: _onIdentifierModeChanged,
                            error: _error,
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Divisor dorado elegante
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: GlamDivider(
                            widthFactor: 0.8, // 80% del ancho disponible
                            primaryOpacity: 0.5, // Sutilmente visible
                            animate: true, // Con animación de aparición
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Enlace para iniciar sesión
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: GlamAnimations.applyEntryEffect(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '¿Recordaste tu contraseña?',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    CircleNavigation.goBackToLogin(context);
                                  },
                                  child: const Text(
                                    'Iniciar sesión',
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
                        ),
                        
                        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
