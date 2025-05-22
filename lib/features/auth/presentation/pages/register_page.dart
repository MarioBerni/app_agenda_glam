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
/// 1. Información personal (tipo de usuario, nombre, teléfono y email)
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
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  // Tipo de usuario
  String _userType = 'Cliente'; // Valor por defecto

  // Estado del registro
  int _currentStep = 1;
  final int _totalSteps = 2;
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  // Controladores
  late final AnimationController _animController;
  late final RegisterController _registerController;

  // Errores de validación
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;

  // Estado de validación en tiempo real
  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isPhoneValid = false;
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
    _phoneController.addListener(_validatePhoneRealtime);
    _passwordController.addListener(_validatePasswordRealtime);
    _confirmPasswordController.addListener(_validateConfirmPasswordRealtime);
  }

  @override
  void dispose() {
    // Eliminar listeners
    _nameController.removeListener(_validateNameRealtime);
    _emailController.removeListener(_validateEmailRealtime);
    _phoneController.removeListener(_validatePhoneRealtime);
    _passwordController.removeListener(_validatePasswordRealtime);
    _confirmPasswordController.removeListener(_validateConfirmPasswordRealtime);

    // Dispose de controllers
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
        _phoneError = RegisterValidator.validatePhone(_phoneController.text);
      });
      return [_nameError, _emailError, _phoneError];
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
  
  /// Actualizar el tipo de usuario seleccionado
  void _updateUserType(String type) {
    setState(() {
      _userType = type;
    });
  }

  /// Enviar datos de registro al backend (mock)
  void _register() {
    if (_validateCurrentStepFields().every((error) => error == null)) {
      context.read<AuthCubit>().register(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        userType: _userType,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
  }
  
  // Manejar registro con Google
  void _handleGoogleRegister() {
    setState(() {
      _isGoogleLoading = true;
    });
    
    // Simula un proceso de registro con Google
    Future.delayed(const Duration(seconds: 2), () {
      // Aquí se implementaría la integración real con Firebase Auth o Google Sign-In
      // usando el BLoC/Cubit y los casos de uso
      
      debugPrint('Registrando con Google - Tipo de usuario: $_userType');
      
      // En un escenario real, después de autenticar con Google, necesitaríamos
      // verificar si es un usuario nuevo o existente y posiblemente solicitar
      // información adicional como el tipo de usuario.
      
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
        
        // Para este ejemplo, simplemente navegamos a Home
        // En una implementación real, podríamos mostrar un diálogo para seleccionar
        // el tipo de usuario si es necesario
        CircleNavigation.goToHome(context);
      }
    });
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
  
  void _validatePhoneRealtime() {
    final isValid =
        RegisterValidator.validatePhone(_phoneController.text) == null;
    if (_isPhoneValid != isValid) {
      setState(() => _isPhoneValid = isValid);
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
                      child: RegisterContent(
                        currentStep: _currentStep,
                        totalSteps: _totalSteps,
                        nameController: _nameController,
                        emailController: _emailController,
                        phoneController: _phoneController,
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        userType: _userType,
                        onUserTypeChanged: _updateUserType,
                        nameError: _nameError,
                        emailError: _emailError,
                        phoneError: _phoneError,
                        passwordError: _passwordError,
                        confirmPasswordError: _confirmPasswordError,
                        isNameValid: _isNameValid,
                        isEmailValid: _isEmailValid,
                        isPhoneValid: _isPhoneValid,
                        passwordCriteria: _passwordCriteria,
                        doPasswordsMatch: _doPasswordsMatch,
                        isLoading: _isLoading,
                        isGoogleLoading: _isGoogleLoading,
                        onNextStep: _nextStep,
                        onRegister: _register,
                        onGoogleRegister: _handleGoogleRegister,
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
