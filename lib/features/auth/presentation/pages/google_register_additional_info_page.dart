import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:app_agenda_glam/features/auth/presentation/controllers/google_register_controller.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/action_buttons_widget.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/phone_input_widget.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/user_type_selector_widget.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/verification_code_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

/// Pantalla para recopilar información adicional después del registro con Google
///
/// Esta pantalla se muestra después de que el usuario ha completado la autenticación
/// con Google y solicita información adicional necesaria para completar el registro:
/// - Tipo de usuario (Cliente, Propietario o Empleado)
/// - Número de teléfono
class GoogleRegisterAdditionalInfoPage extends StatefulWidget {
  /// Nombre del usuario obtenido de Google
  final String userName;
  
  /// Email del usuario obtenido de Google
  final String userEmail;

  const GoogleRegisterAdditionalInfoPage({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<GoogleRegisterAdditionalInfoPage> createState() => _GoogleRegisterAdditionalInfoPageState();
}

class _GoogleRegisterAdditionalInfoPageState extends State<GoogleRegisterAdditionalInfoPage> {
  // Controlador para la lógica de negocio
  late GoogleRegisterController _controller;

  @override
  void initState() {
    super.initState();
    
    // Inicializar el controlador con callbacks
    _controller = GoogleRegisterController(
      onVerificationSuccess: _onVerificationSuccess,
      onError: _showErrorMessage,
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  /// Callback para cuando la verificación es exitosa
  void _onVerificationSuccess(String phone) {
    // Registrar con Google usando el Cubit
    context.read<AuthCubit>().registerWithGoogle(
      name: widget.userName,
      email: widget.userEmail,
      phone: phone,
      userType: _controller.userType,
    );
    
    // Feedback visual
    _showSuccessMessage('Número verificado correctamente');
  }
  
  /// Muestra un mensaje de error
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
  
  /// Muestra un mensaje de éxito
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.loading) {
            // No es necesario hacer nada, el controlador maneja el estado de carga
          } else if (state.status == AuthStatus.error) {
            _showErrorMessage(state.errorMessage ?? 'Error desconocido');
          } else if (state.status == AuthStatus.authenticated) {
            CircleNavigation.goToHome(context);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              GlamGradientBackground(),
              SafeArea(
                child: _GoogleRegisterContent(
                  userName: widget.userName,
                  userEmail: widget.userEmail,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget interno para el contenido de la página
/// Separado para mejorar la legibilidad y mantenibilidad
class _GoogleRegisterContent extends StatelessWidget {
  final String userName;
  final String userEmail;

  const _GoogleRegisterContent({
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Consumer<GoogleRegisterController>(
              builder: (context, controller, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    _buildHeader(context),
                    
                    const SizedBox(height: 24),
                    
                    // Tarjeta de confirmación de datos de Google
                    GlamAnimations.applyEntryEffect(
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kSurfaceColor,
                          border: Border.all(color: kAccentColor.withValues(alpha: 0.5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  'Datos de Google verificados',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(Icons.person, 'Nombre', userName),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.email, 'Email', userEmail),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Selector de tipo de usuario
                    GlamAnimations.applyEntryEffect(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selecciona cómo utilizarás la App',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          UserTypeSelectorWidget(
                            selectedUserType: controller.userType,
                            onUserTypeSelected: controller.updateUserType,
                            showTitle: false, // No mostrar el título del componente
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Campo de teléfono
                    GlamAnimations.applyEntryEffect(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Número de Teléfono',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          PhoneInputWidget(
                            phoneController: controller.phoneController,
                            errorText: controller.phoneError,
                            isPhoneValid: controller.isPhoneValid,
                            showInfoText: !controller.isCodeSent,
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Sección condicional: código de verificación o botón de envío
                    _buildVerificationSection(context, controller),
                    
                    // Espacio para que no quede pegado al fondo en pantallas pequeñas
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
  
  /// Construye una fila de información para la tarjeta de datos
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: kAccentColor, size: 16),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  /// Construye el encabezado de la página
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Importar GlamUI en el ámbito local
        Builder(builder: (context) => GlamUI.buildBackButton(context)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Completar Registro',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Hola $userName, solo necesitamos unos datos más',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  /// Construye la sección de verificación o botón de envío según el estado
  Widget _buildVerificationSection(
    BuildContext context, 
    GoogleRegisterController controller,
  ) {
    if (!controller.isCodeSent) {
      // Mostrar botón de enviar código si aún no se ha enviado
      return ActionButtonsWidget(
        primaryButtonText: 'Enviar Código',
        onPrimaryPressed: controller.isPhoneValid && !controller.isLoading 
            ? controller.sendVerificationCode 
            : null,
        onCancelPressed: () => CircleNavigation.goToWelcome(context),
        isLoading: controller.isLoading,
      );
    } else {
      // Mostrar sección de verificación si ya se envió el código
      return Column(
        children: [
          VerificationCodeInputWidget(
            codeController: controller.codeController,
            errorText: controller.codeError,
            isCodeValid: controller.isCodeValid,
            canResend: controller.canResend,
            formattedTime: controller.timerHelper.formattedTime,
            onResend: controller.resendCode,
            reachedResendLimit: controller.timerHelper.hasReachedResendLimit,
          ),
          
          const SizedBox(height: 30),
          
          ActionButtonsWidget(
            primaryButtonText: 'Verificar y Completar',
            onPrimaryPressed: controller.isCodeValid && !controller.isVerifying 
                ? () => controller.completeRegistration(userName, userEmail)
                : null,
            onCancelPressed: () => CircleNavigation.goToWelcome(context),
            isLoading: controller.isLoading || controller.isVerifying,
          ),
        ],
      );
    }
  }
}