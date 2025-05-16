import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/app_router.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Widget modularizado que contiene el formulario de inicio de sesión
/// Extrae la lógica de validación y UI del formulario en un componente reutilizable
class LoginForm extends StatefulWidget {
  /// Función callback para manejar el evento de login
  final Function(String email, String password) onLogin;
  
  /// Indicador de estado de carga
  final bool isLoading;
  
  /// Mensaje de error a mostrar (si existe)
  final String? errorMessage;

  const LoginForm({
    super.key,
    required this.onLogin,
    required this.isLoading,
    this.errorMessage,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // Controladores para los campos de texto
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Función para validar el correo electrónico
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
      widget.onLogin(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de correo electrónico
            GlamTextField(
              controller: _emailController,
              label: 'Correo electrónico',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: _validateEmail,
              hintText: 'nombre@ejemplo.com',
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
                  context.go(AppRouter.recovery);
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
          ],
        ),
      ),
      slideDistance: 0.2,
    );
  }
}
