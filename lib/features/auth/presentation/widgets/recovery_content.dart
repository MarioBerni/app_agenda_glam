import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';

/// Widget que muestra el formulario de recuperación de contraseña
/// con animaciones y validaciones en tiempo real.
/// Detecta automáticamente si el usuario está utilizando email o teléfono.
class RecoveryContent extends StatefulWidget {
  /// Controlador del campo de identificador (email o teléfono)
  final TextEditingController identifierController;

  /// Estado de carga del proceso
  final bool isLoading;

  /// Función para iniciar el proceso de recuperación
  final VoidCallback onRecoverPassword;
  
  /// Función para notificar cambios en el tipo de identificador
  final Function(bool isEmail)? onIdentifierTypeChanged;

  /// Error actual si existe
  final String? error;

  /// Constructor
  const RecoveryContent({
    super.key,
    required this.identifierController,
    required this.isLoading,
    required this.onRecoverPassword,
    this.error,
    this.onIdentifierTypeChanged,
  });
  
  @override
  State<RecoveryContent> createState() => _RecoveryContentState();

}

class _RecoveryContentState extends State<RecoveryContent> {
  // Estado para controlar si se usa email o teléfono
  bool _isEmailMode = true; // Por defecto, usamos modo email
  bool _showIdentifierType = false; // Para mostrar el tipo de identificador
  
  /// Detecta automáticamente si el valor ingresado es un email o teléfono
  void _detectIdentifierType(String value) {
    if (value.isEmpty) {
      setState(() {
        _showIdentifierType = false;
      });
      return;
    }
    
    // Detectar si es email (contiene @) o teléfono (solo números)
    final bool looksLikeEmail = value.contains('@');
    final bool looksLikePhone = RegExp(r'^[0-9]+$').hasMatch(value);
    
    final bool newIsEmailMode = looksLikeEmail || !looksLikePhone;
    
    // Solo notificar si cambió el tipo de identificador
    if (newIsEmailMode != _isEmailMode) {
      // Notificar al componente padre del cambio
      widget.onIdentifierTypeChanged?.call(newIsEmailMode);
    }
    
    setState(() {
      _isEmailMode = newIsEmailMode;
      _showIdentifierType = true;
    });
  }
  
  // Función para validar el identificador (email o teléfono)
  String? _validateIdentifier(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu correo electrónico o número de teléfono';
    }
    
    if (_isEmailMode) {
      // Validación básica de formato de correo
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        return 'Ingresa un correo electrónico válido';
      }
    } else {
      // Validación básica de formato de teléfono (solo números y mínimo 8 dígitos)
      final phoneRegex = RegExp(r'^[0-9]{8,}$');
      if (!phoneRegex.hasMatch(value)) {
        return 'Ingresa un número de teléfono válido (mínimo 8 dígitos)';
      }
    }
    
    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Campo de email con validación
        GlamAnimations.applyEntryEffect(
          _buildIdentifierField(),
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

  /// Construye el campo de identificador utilizando el componente GlamTextField
  Widget _buildIdentifierField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Campo de identificador (email o teléfono)
        GlamTextField(
          controller: widget.identifierController,
          label: 'Correo electrónico o teléfono',
          prefixIcon: Icons.person_outline,
          keyboardType: TextInputType.emailAddress, // Comienza con teclado de email por defecto
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => widget.onRecoverPassword(),
          validator: _validateIdentifier,
          errorText: widget.error,
          enabled: !widget.isLoading,
          hintText: 'nombre@ejemplo.com o 09XXXXXXXX',
          onChanged: (value) {
            _detectIdentifierType(value);
          },
        ),
        
        // Indicador de tipo de identificador
        if (_showIdentifierType)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Row(
              children: [
                Icon(
                  _isEmailMode ? Icons.email : Icons.phone_android,
                  size: 14,
                  color: kAccentColor.withValues(alpha: 0.7),
                ),
                const SizedBox(width: 6),
                Text(
                  'Utilizando ${_isEmailMode ? "correo electrónico" : "teléfono"}',
                  style: TextStyle(
                    fontSize: 12,
                    color: kAccentColor.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
  


  /// Construye el botón de envío de instrucciones utilizando el componente GlamButton
  Widget _buildRecoverButton() {
    return GlamButton(
      text: 'Enviar instrucciones',
      onPressed: widget.isLoading ? null : widget.onRecoverPassword,
      isLoading: widget.isLoading,
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