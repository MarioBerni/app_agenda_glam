import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';

/// Widget que muestra el formulario de recuperación de contraseña
/// con animaciones y validaciones en tiempo real.
class RecoveryContent extends StatelessWidget {
  /// Controlador del campo de email
  final TextEditingController emailController;

  /// Estado de carga del proceso
  final bool isLoading;

  /// Función para iniciar el proceso de recuperación
  final VoidCallback onRecoverPassword;

  /// Error actual si existe
  final String? error;

  /// Constructor
  const RecoveryContent({
    super.key,
    required this.emailController,
    required this.isLoading,
    required this.onRecoverPassword,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Campo de email con validación
        GlamAnimations.applyEntryEffect(
          _buildEmailField(),
          slideDistance: 0.2,
        ),
        
        const SizedBox(height: 24),
        
        // Botón de recuperación con animación
        GlamAnimations.applyEntryEffect(
          _buildRecoverButton(),
          slideDistance: 0.2,
        ),
        
        const SizedBox(height: 24),
        
        // Mostrar contador de intentos
        GlamAnimations.applyEntryEffect(
          _buildAttemptsCounter(),
          slideDistance: 0.2,
        ),
      ],
    );
  }

  /// Construye el campo de email utilizando el componente GlamTextField
  Widget _buildEmailField() {
    return GlamTextField(
      controller: emailController,
      label: 'Correo electrónico',
      hintText: 'nombre@ejemplo.com',
      prefixIcon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => onRecoverPassword(),
      validator: _validateEmail,
      errorText: error,
      enabled: !isLoading,
    );
  }
  
  /// Valida el formato del email ingresado
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu correo electrónico';
    }
    
    // Validación básica de formato de correo
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un correo electrónico válido';
    }
    
    return null;
  }

  /// Construye el botón de envío de instrucciones utilizando el componente GlamButton
  Widget _buildRecoverButton() {
    return GlamButton(
      text: 'Enviar instrucciones',
      onPressed: isLoading ? null : onRecoverPassword,
      isLoading: isLoading,
      icon: Icons.arrow_forward,
      isSecondary: false,
      withShimmer: true,
    );
  }

  /// Construye el contador de intentos visual utilizando GlamTextDivider y otros componentes comunes
  Widget _buildAttemptsCounter() {
    // Valores fijos para mostrar el primer intento de tres
    const int maxAttempts = 3;
    const int currentAttempt = 1;

    return Column(
      children: [
        // Divisor dorado elegante con texto
        GlamTextDivider(
          text: 'Intento $currentAttempt de $maxAttempts',
          dividerHeight: 1.0,
          primaryColor: kAccentColor,
          primaryOpacity: 0.4,
          textStyle: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        // Indicador visual con barras de progreso
        Row(
          children: [
            // Primer intento (actual)
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: kAccentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(width: 4),

            // Segundo intento (no usado)
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            const SizedBox(width: 4),

            // Tercer intento (no usado)
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}