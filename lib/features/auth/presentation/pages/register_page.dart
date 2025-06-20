import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/domain/validators/register_validator.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_agenda_glam/features/auth/presentation/controllers/register_controller.dart';
import 'package:app_agenda_glam/features/auth/presentation/controllers/register_google_handler.dart';
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
  int _currentStep = 0; // Iniciamos en el paso 0 (selección de método)
  final int _totalSteps = 2; // Los pasos 1 y 2 son los del flujo tradicional
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _termsAccepted = false; // Estado de aceptación de términos

  // Controladores
  late final AnimationController _animController;
  late final RegisterController _registerController;
  late final RegisterGoogleHandler _googleHandler;

  // Errores de validación
  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _termsError;

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
    
    // Inicializar controlador de registro con Google
    _googleHandler = RegisterGoogleHandler(
      onLoadingChanged: (isLoading) {
        if (mounted) {
          setState(() => _isGoogleLoading = isLoading);
        }
      },
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
  void _nextStep() {
    // Si estamos en el paso 0 (selección de método), simplemente avanzar
    if (_currentStep == 0) {
      setState(() {
        _currentStep = 1; // Avanzar al paso de información personal
      });
      return;
    }
    
    // Para los demás pasos, validar campos antes de avanzar
    if (!_validateCurrentStepFields()) {
      return;
    }

    // Avanzar al siguiente paso
    setState(() {
      _currentStep++;
    });
  }

  /// Validar campos según el paso actual del formulario
  bool _validateCurrentStepFields() {
    if (_currentStep == 1) {
      // Validar nombre, email y teléfono
      final nameError = RegisterValidator.validateName(_nameController.text);
      final emailError = RegisterValidator.validateEmail(_emailController.text);
      final phoneError = RegisterValidator.validatePhone(_phoneController.text);
      
      setState(() {
        _nameError = nameError;
        _emailError = emailError;
        _phoneError = phoneError;
      });
      
      return nameError == null && emailError == null && phoneError == null;
    } else if (_currentStep == 2) {
      // Validar contraseña, confirmación y aceptación de términos
      final passwordError = RegisterValidator.validatePassword(_passwordController.text, _passwordCriteria);
      
      String? confirmError;
      if (_passwordController.text != _confirmPasswordController.text) {
        confirmError = 'Las contraseñas no coinciden';
      }
      
      String? termsError;
      if (!_termsAccepted) {
        termsError = 'Debes aceptar los términos y condiciones';
      }
      
      setState(() {
        _passwordError = passwordError;
        _confirmPasswordError = confirmError;
        _termsError = termsError;
      });
      
      return passwordError == null && confirmError == null && termsError == null;
    }
    
    return true; // Paso 0 o cualquier otro paso no requiere validación
  }

  /// Navegar al paso anterior o volver a la pantalla de login
  void _previousStep() {
    if (_currentStep > 1) {
      // Si estamos después del paso 1, retroceder normalmente
      setState(() {
        _currentStep--;
      });
    } else if (_currentStep == 1) {
      // Si estamos en el paso 1, volver al paso de selección de método
      setState(() {
        _currentStep = 0;
      });
    } else {
      // Si estamos en el paso 0, volver a la pantalla de login con efecto circular
      // Usar CircleNavigation para mantener consistencia en todas las transiciones
      CircleNavigation.goToWelcome(context);
    }
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
    if (_validateCurrentStepFields()) {
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
  
  /// Maneja el registro con una cuenta de Google
  /// Delega la implementación al controlador especializado RegisterGoogleHandler
  void _handleGoogleRegister() {
    _googleHandler.handleGoogleRegister(context);
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
          // No usamos AppBar, usaremos nuestro encabezado unificado
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Encabezado unificado con botón de retroceso dorado
                          GlamAnimations.applyEntryEffect(
                            GlamUI.buildHeader(
                              context,
                              title: 'Crear Cuenta',
                              subtitle: 'Completa tu información para registrarte',
                              onBackPressed: _previousStep,
                            ),
                          ),
                          
                          // Espaciado estandarizado (32px) después del encabezado - igual que en todas las páginas
                          const SizedBox(height: 32),
                          
                          // Contenido principal del registro
                          RegisterContent(
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
                            termsError: _termsError,
                            isNameValid: _isNameValid,
                            isEmailValid: _isEmailValid,
                            isPhoneValid: _isPhoneValid,
                            passwordCriteria: _passwordCriteria,
                            doPasswordsMatch: _doPasswordsMatch,
                            termsAccepted: _termsAccepted,
                            onTermsAcceptedChanged: (accepted) {
                              setState(() {
                                _termsAccepted = accepted;
                                if (accepted) {
                                  _termsError = null;
                                }
                              });
                            },
                            isLoading: _isLoading,
                            isGoogleLoading: _isGoogleLoading,
                            onNextStep: _nextStep,
                            onRegister: _register,
                            onGoogleRegister: _handleGoogleRegister,
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
