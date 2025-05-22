import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';

/// Widget modularizado que contiene el formulario de inicio de sesión
/// Extrae la lógica de validación y UI del formulario en un componente reutilizable
class LoginForm extends StatefulWidget {
  /// Función callback para manejar el evento de login con email o teléfono
  final Function(String identifier, String password, bool isEmail) onLogin;
  
  /// Función callback para manejar el evento de login con Google
  final Function() onGoogleLogin;
  
  /// Indicador de estado de carga
  final bool isLoading;
  
  /// Indicador de estado de carga para Google
  final bool isGoogleLoading;
  
  /// Mensaje de error a mostrar (si existe)
  final String? errorMessage;

  const LoginForm({
    super.key,
    required this.onLogin,
    required this.onGoogleLogin,
    required this.isLoading,
    this.isGoogleLoading = false,
    this.errorMessage,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controladores para los campos de texto
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  // Estado para controlar si se usa email o teléfono
  bool _isEmailMode = true; // Por defecto, usamos modo email
  bool _showIdentifierType = false; // Para mostrar el tipo de identificador

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  
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
    
    setState(() {
      _isEmailMode = looksLikeEmail || !looksLikePhone;
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

  // Función para validar la contraseña
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingresa tu contraseña';
    }
    
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    
    return null;
  }

  // Función para manejar el envío del formulario
  void _handleSubmit() {
    // Oculta el teclado
    FocusScope.of(context).unfocus();
    
    // Valida el formulario
    if (_formKey.currentState?.validate() ?? false) {
      widget.onLogin(
        _identifierController.text, 
        _passwordController.text,
        _isEmailMode,
      );
    }
  }
  
  // Función para validar automáticamente al cambiar el contenido
  void _onIdentifierChanged(String value) {
    _detectIdentifierType(value);
  }
  
  // Función para manejar el inicio de sesión con Google
  void _handleGoogleLogin() {
    widget.onGoogleLogin();
  }

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de identificador (email o teléfono)
            GlamTextField(
              controller: _identifierController,
              label: 'Correo electrónico o teléfono',
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.emailAddress, // Comienza con teclado de email por defecto
              textInputAction: TextInputAction.next,
              validator: _validateIdentifier,
              hintText: 'nombre@ejemplo.com o 09XXXXXXXX',
              onChanged: _onIdentifierChanged,
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
            
            
            const SizedBox(height: 20),
            
            // Campo de contraseña
            GlamTextField(
              controller: _passwordController,
              label: 'Contraseña',
              prefixIcon: Icons.lock,
              isPassword: true,
              validator: _validatePassword,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _handleSubmit(),
            ),
            
            // Olvidé mi contraseña
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  CircleNavigation.goToRecovery(context);
                },
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: kAccentColor.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            
            // Mensaje de error si existe
            if (widget.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kErrorColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kErrorColor),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: kErrorColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.errorMessage!,
                          style: const TextStyle(color: kErrorColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            const SizedBox(height: 24),
            
            // Botón de inicio de sesión
            Hero(
              tag: 'login_button',
              child: GlamButton(
                text: 'Iniciar Sesión',
                isLoading: widget.isLoading,
                onPressed: widget.isLoading ? null : _handleSubmit,
                icon: Icons.login_rounded,
                withShimmer: true,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Separador "o"
            Row(
              children: [
                const Expanded(child: Divider(color: Colors.white30)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'o',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: Colors.white30)),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Botón de inicio con Google
            Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white30),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: (widget.isLoading || widget.isGoogleLoading) ? null : _handleGoogleLogin,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.isGoogleLoading)
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(right: 12.0),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                            ),
                          )
                        else
                          // Icono de Google personalizado con círculos de colores
                          Container(
                            width: 24,
                            height: 24,
                            margin: const EdgeInsets.only(right: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                'G',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ),
                          ),
                        Text(
                          widget.isGoogleLoading ? 'Conectando...' : 'Continuar con Google',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      slideDistance: 0.2,
    );
  }
}
