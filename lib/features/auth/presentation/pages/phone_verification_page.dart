import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/domain/validators/register_validator.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';

/// Pantalla para la verificación del número de teléfono
///
/// Esta pantalla permite al usuario ingresar su número de teléfono
/// para recibir un código de verificación por SMS.
class PhoneVerificationPage extends StatefulWidget {
  const PhoneVerificationPage({super.key});

  @override
  State<PhoneVerificationPage> createState() => _PhoneVerificationPageState();
}

class _PhoneVerificationPageState extends State<PhoneVerificationPage> {
  final _phoneController = TextEditingController();
  bool _isLoading = false;
  bool _isPhoneValid = false;
  String? _phoneError;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhoneRealtime);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_validatePhoneRealtime);
    _phoneController.dispose();
    super.dispose();
  }

  /// Valida el teléfono en tiempo real mientras el usuario escribe
  void _validatePhoneRealtime() {
    final phoneText = _phoneController.text.trim();
    
    // Validar que no esté vacío
    if (phoneText.isEmpty) {
      setState(() {
        _phoneError = null; // No mostrar error mientras escribe
        _isPhoneValid = false;
      });
      return;
    }
    
    // Validar formato usando el mismo validador que en RegisterPage
    final validationError = RegisterValidator.validatePhone(phoneText);
    final isValid = validationError == null;
    
    setState(() {
      _phoneError = isValid ? null : null; // No mostrar error mientras escribe
      _isPhoneValid = isValid;
    });
  }

  /// Envía el código de verificación al número proporcionado
  void _sendVerificationCode() {
    // Validación final antes de enviar
    final phoneText = _phoneController.text.trim();
    final validationError = RegisterValidator.validatePhone(phoneText);
    
    if (validationError != null) {
      setState(() {
        _phoneError = validationError;
        _isPhoneValid = false;
      });
      return;
    }
    
    // Simulación de envío de código
    setState(() {
      _isLoading = true;
      _phoneError = null;
      _isPhoneValid = true;
    });
    
    // Simulamos un proceso de envío de SMS
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        
        // Navegar a la página de verificación de código
        // Implementar cuando se cree SMSCodeVerificationPage
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Código enviado. Implementar navegación a página de verificación.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GlamAnimations.applyEntryEffect(
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Fondo degradado
          const GlamGradientBackground(
            primaryColor: kPrimaryColor,
            opacity: 0.9,
          ),
          
          // Contenido principal
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    
                    // Título y subtítulo
                    GlamAnimations.applyEntryEffect(
                      Text(
                        'Verificación por Teléfono',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GlamAnimations.applyEntryEffect(
                      Text(
                        'Ingresa tu número para recibir un código de verificación',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Campo de teléfono
                    GlamAnimations.applyEntryEffect(
                      GlamTextField(
                        controller: _phoneController,
                        label: 'Número de Teléfono',
                        prefixIcon: Icons.phone_android,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.done,
                        errorText: _phoneError,
                        hintText: '09XXXXXXXX',
                        suffixIcon: _isPhoneValid 
                            ? const Icon(Icons.check_circle, color: Colors.green) 
                            : null,
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Texto informativo
                    GlamAnimations.applyEntryEffect(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          'Te enviaremos un código de verificación a este número.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Botón de acción
                    GlamAnimations.applyEntryEffect(
                      GlamButton(
                        text: 'Enviar Código',
                        onPressed: _isPhoneValid && !_isLoading ? _sendVerificationCode : null,
                        isLoading: _isLoading,
                        icon: Icons.send,
                        withShimmer: true,
                      ),
                    ),
                    
                    // Espacio para que no quede pegado al fondo
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
