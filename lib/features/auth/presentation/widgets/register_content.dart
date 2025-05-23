import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/presentation/pages/phone_register_page.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
// import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_google_button.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_auth_method_step.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_footer.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_header.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_personal_info_step.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_password_step.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/register_step_indicator.dart';
import 'package:flutter/material.dart';

/// Widget principal de contenido para la pantalla de registro
/// Organiza todos los componentes visuales en la estructura de la página
/// Enumeración para identificar el método de autenticación seleccionado
enum AuthMethod {
  /// Método tradicional con email y contraseña
  traditional,
  
  /// Método usando cuenta de Google
  google,
  
  /// Método usando verificación por SMS
  phone
}

/// Widget principal de contenido para la pantalla de registro
/// Organiza todos los componentes visuales en la estructura de la página
class RegisterContent extends StatelessWidget {
  /// Paso actual del registro
  final int currentStep;

  /// Total de pasos del registro
  final int totalSteps;
  
  /// Método de autenticación seleccionado
  final AuthMethod authMethod;

  /// Controlador para el campo de nombre
  final TextEditingController nameController;

  /// Controlador para el campo de email
  final TextEditingController emailController;
  
  /// Controlador para el campo de teléfono
  final TextEditingController phoneController;
  
  /// Tipo de usuario seleccionado (Propietario, Empleado, Cliente)
  final String? userType;
  
  /// Función para actualizar el tipo de usuario seleccionado
  final Function(String) onUserTypeChanged;

  /// Controlador para el campo de contraseña
  final TextEditingController passwordController;

  /// Controlador para el campo de confirmación de contraseña
  final TextEditingController confirmPasswordController;

  /// Error del campo de nombre
  final String? nameError;

  /// Error del campo de email
  final String? emailError;
  
  /// Error del campo de teléfono
  final String? phoneError;

  /// Error del campo de contraseña
  final String? passwordError;

  /// Error del campo de confirmación de contraseña
  final String? confirmPasswordError;

  /// Indica si el nombre es válido
  final bool isNameValid;

  /// Indica si el email es válido
  final bool isEmailValid;
  
  /// Indica si el teléfono es válido
  final bool isPhoneValid;

  /// Criterios para la validación de contraseña
  final Map<String, bool> passwordCriteria;

  /// Indica si las contraseñas coinciden
  final bool doPasswordsMatch;

  /// Indica si está en estado de carga
  final bool isLoading;
  
  /// Indica si el registro con Google está en estado de carga
  final bool isGoogleLoading;

  /// Función para ir al siguiente paso
  final VoidCallback onNextStep;

  /// Función para enviar el formulario
  final VoidCallback onRegister;
  
  /// Función para registrarse con Google
  final VoidCallback onGoogleRegister;

  const RegisterContent({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.userType,
    required this.onUserTypeChanged,
    required this.nameError,
    required this.emailError,
    this.phoneError,
    required this.passwordError,
    required this.confirmPasswordError,
    required this.isNameValid,
    required this.isEmailValid,
    this.isPhoneValid = false,
    required this.passwordCriteria,
    required this.doPasswordsMatch,
    required this.isLoading,
    this.isGoogleLoading = false,
    required this.onNextStep,
    required this.onRegister,
    required this.onGoogleRegister,
    this.authMethod = AuthMethod.traditional,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Encabezado con título, icono y descripción
          RegisterHeader(currentStep: currentStep),
          
          // Indicador de progreso (solo se muestra en el flujo tradicional después del paso 0)
          if (currentStep > 0) ...[  
            RegisterStepIndicator(
              currentStep: currentStep,
              totalSteps: totalSteps,
            ),
            const SizedBox(height: 24),
          ],
          
          // Formulario por pasos
          _buildCurrentStep(context),

          const SizedBox(height: 24),

          // Botón de acción principal (solo se muestra si no estamos en el paso de selección de método)
          if (currentStep != 0) ...[  
            Hero(
              tag: 'register_button',
              child: GlamButton(
                text: currentStep == 1 ? 'Continuar' : 'Crear Cuenta',
                onPressed: isLoading
                    ? null
                    : (currentStep == 1 ? onNextStep : onRegister),
                isLoading: isLoading,
                icon: currentStep == 1 ? Icons.arrow_forward : Icons.person_add_outlined,
                withShimmer: true,
              ),
            ),
            
            const SizedBox(height: 24),
          ],
          
          // Divisor dorado elegante
          const GlamDivider(
            widthFactor: 0.8,
            primaryOpacity: 0.5,
            animate: true,
          ),
          
          const SizedBox(height: 24),
          
          // Pie de página con enlace a login
          const RegisterFooter(),
          
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      ),
    );
  }

  /// Construye el paso actual del formulario con animación
  Widget _buildCurrentStep(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.05, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: _getStepContent(context),
    );
  }
  
  /// Determina el contenido a mostrar según el paso actual y el método de autenticación
  Widget _getStepContent(BuildContext context) {
    // Paso 0: Selección del método de autenticación
    if (currentStep == 0) {
      return RegisterAuthMethodStep(
        onGoogleRegister: onGoogleRegister,
        onPhoneRegister: () {
          // Navegar a la página consolidada de registro por teléfono usando la transición circular
          CircleNavigation.goToPhoneRegister(context);
        },
        isGoogleLoading: isGoogleLoading,
      );
    }
    
    // Si estamos en el flujo tradicional (email/contraseña)
    if (authMethod == AuthMethod.traditional) {
      return currentStep == 1
          ? RegisterPersonalInfoStep(
              nameController: nameController,
              emailController: emailController,
              phoneController: phoneController,
              userType: userType,
              onUserTypeChanged: onUserTypeChanged,
              nameError: nameError,
              emailError: emailError,
              phoneError: phoneError,
              isNameValid: isNameValid,
              isEmailValid: isEmailValid,
              isPhoneValid: isPhoneValid,
            )
          : RegisterPasswordStep(
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              passwordError: passwordError,
              confirmPasswordError: confirmPasswordError,
              passwordCriteria: passwordCriteria,
              doPasswordsMatch: doPasswordsMatch,
              onEditingComplete: onRegister,
            );
    }
    
    // Para los otros métodos de autenticación, este paso no debería mostrarse
    // ya que se redirige a otras pantallas
    return const SizedBox.shrink();
  }
}
