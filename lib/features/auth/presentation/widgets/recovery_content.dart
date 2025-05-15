import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/domain/validators/recovery_validator.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono representativo animado
            _buildRecoveryIcon(),
            
            const SizedBox(height: 32),
            
            // Mensaje de recuperación
            Text(
              'Ingresa tu dirección de correo electrónico para recibir instrucciones sobre cómo restablecer tu contraseña.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ).glamEntry(
              duration: const Duration(milliseconds: 800),
              offset: const Offset(0, 0.08),
            ),
            
            const SizedBox(height: 32),
            
            // Campo de email con animación
            _buildEmailField(),
            
            const SizedBox(height: 8),
            
            const SizedBox(height: 32),
            
            // Botón de recuperación con animación
            _buildRecoverButton(),
            
            const SizedBox(height: 16),
            
            // Límite de intentos con contador visual (solo decorativo)
            _buildAttemptsCounter(),
          ],
        ),
      ),
    );
  }

  /// Construye el icono representativo de recuperación
  Widget _buildRecoveryIcon() {
    return const GlamIconContainer(
      icon: Icons.lock_reset_outlined,
      size: 100,
      enableShimmer: true,
      animateEntry: true,
    );
  }

  /// Construye el campo de email con animación en tiempo real
  Widget _buildEmailField() {
    return GlamTextField(
      controller: emailController,
      label: 'Email',
      hintText: 'nombre@ejemplo.com',
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => onRecoverPassword(),
      validator: (value) => RecoveryValidator.validateEmail(value ?? ''),
      errorText: error,
    );
  }

  /// Construye el botón de recuperación con animación
  Widget _buildRecoverButton() {
    return GlamButton(
      text: 'Enviar instrucciones',
      onPressed: isLoading ? null : onRecoverPassword,
      isLoading: isLoading,
      icon: Icons.send_outlined,
      variant: GlamButtonVariant.primary,
      size: GlamButtonSize.medium,
      primaryColor: kAccentColor,
    );
  }

  /// Construye el contador de intentos visual (decorativo)
  Widget _buildAttemptsCounter() {
    // Simulamos un límite de 3 intentos para el diseño visual
    const int maxAttempts = 3;
    const int currentAttempt = 1; // Para diseño, siempre mostramos 1/3
    
    return Column(
      children: [
        // Separador con texto
        GlamTextDivider(
          text: 'Intento $currentAttempt de $maxAttempts',
          dividerHeight: 1.0,
          primaryColor: kAccentColor,
          primaryOpacity: 0.4,
          textStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(0.6),
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
                  color: kAccentColor.withOpacity(0.8),
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
                  color: Colors.white.withOpacity(0.15),
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
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
