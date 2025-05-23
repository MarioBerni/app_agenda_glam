import 'dart:async';
import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Pantalla para verificación de código SMS
///
/// Esta pantalla permite al usuario ingresar el código de verificación
/// que recibió por SMS para validar su número de teléfono.
class SMSCodeVerificationPage extends StatefulWidget {
  /// Número de teléfono al que se envió el código
  final String phoneNumber;
  
  const SMSCodeVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<SMSCodeVerificationPage> createState() => _SMSCodeVerificationPageState();
}

class _SMSCodeVerificationPageState extends State<SMSCodeVerificationPage> {
  // Controladores para cada dígito del código
  final List<TextEditingController> _codeControllers = List.generate(
    6, // Código de 6 dígitos
    (_) => TextEditingController(),
  );
  
  // Focus nodes para manejar el avance automático
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (_) => FocusNode(),
  );
  
  // Estado de verificación
  bool _isLoading = false;
  String? _verificationError;
  
  // Temporizador para reenvío
  late Timer _timer;
  int _timerSeconds = 120; // 2 minutos
  bool _canResend = false;
  int _resendCount = 0;
  final int _maxResends = 2;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    // Limpiar controladores y focus nodes
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    
    // Cancelar timer
    _timer.cancel();
    
    super.dispose();
  }
  
  /// Inicia el temporizador para reenvío de código
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }
  
  /// Formatea el tiempo restante en minutos:segundos
  String get _formattedTime {
    final minutes = _timerSeconds ~/ 60;
    final seconds = _timerSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
  
  /// Reenvía el código de verificación
  void _resendCode() {
    if (!_canResend || _resendCount >= _maxResends) return;
    
    setState(() {
      _isLoading = true;
    });
    
    // Simulación de reenvío
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _canResend = false;
          _timerSeconds = 120;
          _resendCount++;
        });
        
        // Reiniciar temporizador
        _startTimer();
        
        // Feedback visual
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Código reenviado. Revisa tu teléfono.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }
  
  /// Verifica el código ingresado
  void _verifyCode() {
    // Obtener código completo
    final code = _codeControllers.map((c) => c.text).join();
    
    // Validar que esté completo
    if (code.length != 6) {
      setState(() {
        _verificationError = 'Por favor ingresa el código completo';
      });
      return;
    }
    
    // Simular verificación
    setState(() {
      _isLoading = true;
      _verificationError = null;
    });
    
    // En un escenario real, aquí se verificaría el código con Firebase Auth
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        
        // Simulamos verificación exitosa (en la implementación real se validaría)
        // Aquí deberíamos navegar a la página de información adicional
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Código verificado correctamente. Implementar navegación a página de datos adicionales.'),
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
      // No usamos AppBar aquí, en su lugar incorporamos el encabezado directamente en el contenido
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
                    // Encabezado unificado con botón de retroceso dorado
                    GlamAnimations.applyEntryEffect(
                      GlamUI.buildHeader(
                        context,
                        title: 'Verificación por SMS',
                        subtitle: 'Ingresa el código enviado al número ${widget.phoneNumber}',
                        onBackPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    
                    // Espaciado estandarizado (32px) después del encabezado - igual que en todas las páginas
                    const SizedBox(height: 32),
                    
                    // Campos para el código
                    GlamAnimations.applyEntryEffect(
                      _buildCodeInputFields(),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Mensaje de error
                    if (_verificationError != null)
                      GlamAnimations.applyEntryEffect(
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            _verificationError!,
                            style: const TextStyle(
                              color: kErrorColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    
                    // Temporizador y opción de reenvío
                    GlamAnimations.applyEntryEffect(
                      _buildResendOption(),
                    ),
                    
                    // Espaciado estandarizado (32px) después del encabezado - igual que en todas las páginas
                    const SizedBox(height: 32),
                    
                    // Botón de verificación
                    GlamAnimations.applyEntryEffect(
                      GlamButton(
                        text: 'Verificar Código',
                        onPressed: !_isLoading ? _verifyCode : null,
                        isLoading: _isLoading,
                        icon: Icons.check_circle_outline,
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
  
  /// Construye los campos para ingresar el código
  Widget _buildCodeInputFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) => _buildDigitField(index)),
        ),
      ],
    );
  }
  
  /// Construye un campo individual para un dígito del código
  Widget _buildDigitField(int index) {
    return SizedBox(
      width: 45,
      height: 55,
      child: TextField(
        controller: _codeControllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: kAccentColor.withValues(alpha: 0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kAccentColor),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          // Auto-avanzar al siguiente campo cuando se ingresa un dígito
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          
          // Verificar si se completó todo el código
          final isComplete = _codeControllers.every((c) => c.text.isNotEmpty);
          if (isComplete) {
            // Quitar el foco
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
  
  /// Construye la opción de reenvío y temporizador
  Widget _buildResendOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No recibiste el código? ',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
        if (_canResend && _resendCount < _maxResends)
          TextButton(
            onPressed: _resendCode,
            child: const Text(
              'Reenviar',
              style: TextStyle(
                color: kAccentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else
          Row(
            children: [
              Text(
                _resendCount >= _maxResends 
                    ? 'Límite de reenvíos alcanzado' 
                    : 'Reenviar en $_formattedTime',
                style: TextStyle(
                  color: _resendCount >= _maxResends ? Colors.red.shade300 : kAccentColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
