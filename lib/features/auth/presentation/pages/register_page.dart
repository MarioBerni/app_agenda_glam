import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/features/auth/domain/validators/register_validator.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_agenda_glam/features/auth/presentation/controllers/register_controller.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Página de registro de nuevos usuarios con flujo por pasos
///
/// Esta página implementa un proceso de registro dividido en dos pasos:
/// 1. Información personal (nombre y email)
/// 2. Configuración de contraseña (contraseña y confirmación)
///
/// La arquitectura está modularizada utilizando componentes independientes
/// para cada sección, facilitando el mantenimiento y las pruebas unitarias.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  // Controladores de texto
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Estado del registro
  int _currentStep = 1;
  final int _totalSteps = 2;
  bool _isLoading = false;

  // Controladores
  late final AnimationController _animController;
  late final RegisterController _registerController;

  // Errores de validación
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  // Estado de validación en tiempo real
  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _doPasswordsMatch = false;

  // Criterios de contraseña
  final Map<String, bool> _passwordCriteria = {
    'length': false, // Al menos 6 caracteres
    'uppercase': false, // Al menos una mayúscula
    'number': false, // Al menos un número
  };

  @override
  void initState() {
    super.initState();

    // Inicializar controlador de animación
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Inicializar controlador de registro
    _registerController = RegisterController(
      animationController: _animController,
      onFieldError: _showFieldError,
    );

    // Escuchar cambios en los campos para validación en tiempo real
    _nameController.addListener(_validateNameRealtime);
    _emailController.addListener(_validateEmailRealtime);
    _passwordController.addListener(_validatePasswordRealtime);
    _confirmPasswordController.addListener(_validateConfirmPasswordRealtime);
  }

  @override
  void dispose() {
    // Eliminar listeners
    _nameController.removeListener(_validateNameRealtime);
    _emailController.removeListener(_validateEmailRealtime);
    _passwordController.removeListener(_validatePasswordRealtime);
    _confirmPasswordController.removeListener(_validateConfirmPasswordRealtime);

    // Dispose de controllers
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animController.dispose();
    _registerController.dispose();
    super.dispose();
  }

  /// Navegar al siguiente paso del registro
  void _nextStep() async {
    await _registerController.nextStep(
      _currentStep,
      () => setState(() => _currentStep++),
      () => [
        // Validar campos del paso actual
        _validateCurrentStepFields(),
      ].expand((element) => element).toList(),
    );
  }

  /// Validar campos según el paso actual del formulario
  List<String?> _validateCurrentStepFields() {
    if (_currentStep == 1) {
      setState(() {
        _nameError = RegisterValidator.validateName(_nameController.text);
        _emailError = RegisterValidator.validateEmail(_emailController.text);
      });
      return [_nameError, _emailError];
    } else {
      setState(() {
        _passwordError = RegisterValidator.validatePassword(
          _passwordController.text,
          _passwordCriteria,
        );
        _confirmPasswordError = RegisterValidator.validateConfirmPassword(
          _passwordController.text,
          _confirmPasswordController.text,
        );
      });
      return [_passwordError, _confirmPasswordError];
    }
  }

  /// Navegar al paso anterior o volver a la pantalla de login
  void _previousStep() async {
    await _registerController.previousStep(
      _currentStep,
      () => setState(() => _currentStep--),
      () {
        // Usar la navegación centralizada con transición circular hacia atrás
        CircleNavigation.goToWelcome(context);
      },
    );
  }

  /// Mostrar efecto visual para campos con error
  void _showFieldError(String field) {
    // Esta función se puede ampliar para mostrar efectos visuales
    // específicos para diferentes campos con error
  }

  /// Enviar datos de registro al backend (mock)
  void _register() {
    if (_validateCurrentStepFields().every((error) => error == null)) {
      context.read<AuthCubit>().register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
  }

  /// Métodos de validación en tiempo real
  void _validateNameRealtime() {
    final isValid =
        RegisterValidator.validateName(_nameController.text) == null;
    if (_isNameValid != isValid) {
      setState(() => _isNameValid = isValid);
    }
  }

  void _validateEmailRealtime() {
    final isValid =
        RegisterValidator.validateEmail(_emailController.text) == null;
    if (_isEmailValid != isValid) {
      setState(() => _isEmailValid = isValid);
    }
  }

  void _validatePasswordRealtime() {
    final isValid =
        RegisterValidator.validatePassword(
          _passwordController.text,
          _passwordCriteria,
        ) ==
        null;

    if (_isPasswordValid != isValid) {
      setState(() => _isPasswordValid = isValid);
    }

    // También verificar coincidencia cuando cambia la contraseña
    _validateConfirmPasswordRealtime();
  }

  void _validateConfirmPasswordRealtime() {
    final doMatch =
        _passwordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;

    if (_doPasswordsMatch != doMatch) {
      setState(() => _doPasswordsMatch = doMatch);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.loading:
            setState(() => _isLoading = true);
            break;
          case AuthStatus.authenticated:
            setState(() => _isLoading = false);
            CircleNavigation.goToHome(context);
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
        return Scaffold(
          backgroundColor: Colors.transparent,
          // Controla el redimensionamiento cuando aparece el teclado
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GlamAnimations.applyEntryEffect(
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: _previousStep,
              ),
            ),
          ),
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
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          
                          // Contenido del formulario según paso actual
                          RegisterContent(
                            currentStep: _currentStep,
                            totalSteps: _totalSteps,
                            nameController: _nameController,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            confirmPasswordController: _confirmPasswordController,
                            nameError: _nameError,
                            emailError: _emailError,
                            passwordError: _passwordError,
                            confirmPasswordError: _confirmPasswordError,
                            isNameValid: _isNameValid,
                            isEmailValid: _isEmailValid,
                            passwordCriteria: _passwordCriteria,
                            doPasswordsMatch: _doPasswordsMatch,
                            isLoading: _isLoading,
                            onNextStep: _nextStep,
                            onRegister: _register,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
