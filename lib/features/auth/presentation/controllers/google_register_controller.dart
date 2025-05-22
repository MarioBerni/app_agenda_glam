import 'package:app_agenda_glam/features/auth/domain/validators/register_validator.dart';
import 'package:app_agenda_glam/features/auth/presentation/helpers/verification_service.dart';
import 'package:app_agenda_glam/features/auth/presentation/helpers/verification_timer_helper.dart';
import 'package:flutter/material.dart';

/// Controlador para la pantalla de registro adicional con Google
/// Implementa el patrón MVVM para separar la lógica de negocio de la UI

/// Controlador para la lógica de registro con Google
class GoogleRegisterController with ChangeNotifier {
  // Estado general
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  // Tipo de usuario sin preseleccionar para forzar una selección explícita
  String _userType = '';
  String get userType => _userType;
  
  // Estado del teléfono
  final TextEditingController phoneController = TextEditingController();
  String? _phoneError;
  String? get phoneError => _phoneError;
  bool _isPhoneValid = false;
  bool get isPhoneValid => _isPhoneValid;
  
  // Estado de la verificación de código
  final TextEditingController codeController = TextEditingController();
  String? _codeError;
  String? get codeError => _codeError;
  bool _isCodeValid = false;
  bool get isCodeValid => _isCodeValid;
  
  bool _isCodeSent = false;
  bool get isCodeSent => _isCodeSent;
  
  bool _isVerifying = false;
  bool get isVerifying => _isVerifying;
  
  // Timer para reenvío
  late VerificationTimerHelper timerHelper;
  bool _canResend = false;
  bool get canResend => _canResend;
  
  // Callbacks
  final Function(String) onVerificationSuccess;
  final Function(String) onError;
  
  GoogleRegisterController({
    required this.onVerificationSuccess,
    required this.onError,
  }) {
    // Inicializar controladores y listeners
    phoneController.addListener(_validatePhoneRealtime);
    codeController.addListener(_validateCodeRealtime);
    
    // Inicializar helper del timer
    timerHelper = VerificationTimerHelper(
      initialSeconds: 120, // 2 minutos
      onTimerTick: (_) {
        notifyListeners();
      },
      onTimerComplete: () {
        _canResend = true;
        notifyListeners();
      },
    );
  }
  
  /// Actualiza el tipo de usuario seleccionado
  void updateUserType(String type) {
    _userType = type;
    notifyListeners();
  }
  
  /// Valida el teléfono en tiempo real
  void _validatePhoneRealtime() {
    final phoneText = phoneController.text.trim();
    
    if (phoneText.isEmpty) {
      _isPhoneValid = false;
      notifyListeners();
      return;
    }
    
    final validationError = RegisterValidator.validatePhone(phoneText);
    final isValid = validationError == null;
    
    if (_isPhoneValid != isValid) {
      _isPhoneValid = isValid;
      notifyListeners();
    }
  }
  
  /// Valida el código en tiempo real
  void _validateCodeRealtime() {
    final codeText = codeController.text.trim();
    
    if (codeText.isEmpty) {
      _isCodeValid = false;
      notifyListeners();
      return;
    }
    
    // Código simple de 6 dígitos
    final isValid = codeText.length == 6 && int.tryParse(codeText) != null;
    
    if (_isCodeValid != isValid) {
      _isCodeValid = isValid;
      notifyListeners();
    }
  }
  
  /// Envía el código de verificación
  void sendVerificationCode() {
    final phoneText = phoneController.text.trim();
    final phoneValidationError = RegisterValidator.validatePhone(phoneText);
    
    if (phoneValidationError != null) {
      _phoneError = phoneValidationError;
      _isPhoneValid = false;
      notifyListeners();
      return;
    }
    
    // Utilizamos el servicio de verificación para enviar el código
    VerificationService.sendVerificationCode(
      phone: phoneText,
      onSendingProgress: (isLoading) {
        _isLoading = isLoading;
        _phoneError = null;
        notifyListeners();
      },
      onSendingError: (error) {
        _phoneError = error;
        _isPhoneValid = false;
        _isLoading = false;
        onError(error);
        notifyListeners();
      },
      onSendingSuccess: () {
        _isCodeSent = true;
        _isLoading = false;
        
        // Iniciar temporizador para reenvío
        timerHelper.startTimer();
        notifyListeners();
      },
    );
  }
  
  /// Reenvía el código de verificación
  void resendCode() {
    if (!_canResend || timerHelper.hasReachedResendLimit) return;
    
    _isLoading = true;
    notifyListeners();
    
    // Utilizamos el servicio de verificación para reenviar el código
    VerificationService.sendVerificationCode(
      phone: phoneController.text.trim(),
      onSendingProgress: (isLoading) {
        _isLoading = isLoading;
        notifyListeners();
      },
      onSendingError: (error) {
        _phoneError = error;
        _isLoading = false;
        onError(error);
        notifyListeners();
      },
      onSendingSuccess: () {
        _isLoading = false;
        _canResend = false;
        
        // Incrementar contador de reenvíos y reiniciar temporizador
        timerHelper.incrementResendCount();
        notifyListeners();
      },
    );
  }
  
  /// Completa el registro verificando el código
  void completeRegistration(String userName, String userEmail) {
    final phone = phoneController.text.trim();
    
    // Validación final del teléfono
    final validationError = RegisterValidator.validatePhone(phone);
    if (validationError != null) {
      _phoneError = validationError;
      _isPhoneValid = false;
      notifyListeners();
      return;
    }
    
    // Si estamos en modo de verificación, validar el código
    if (_isCodeSent) {
      final codeText = codeController.text.trim();
      
      // Validar que el código tenga 6 dígitos
      if (codeText.length != 6 || int.tryParse(codeText) == null) {
        _codeError = 'Ingresa un código válido de 6 dígitos';
        _isCodeValid = false;
        notifyListeners();
        return;
      }
      
      // Verificar el código usando el servicio
      VerificationService.verifyCode(
        phone: phone,
        code: codeText,
        onVerificationProgress: (isVerifying) {
          _isVerifying = isVerifying;
          _codeError = null;
          notifyListeners();
        },
        onVerificationError: (error) {
          _codeError = error;
          _isCodeValid = false;
          _isVerifying = false;
          onError(error);
          notifyListeners();
        },
        onVerificationSuccess: () {
          // Llamar al callback de éxito con los datos necesarios
          onVerificationSuccess(phone);
        },
      );
    } else {
      // Si no estamos en modo de verificación, simplemente enviar el código
      _phoneError = null;
      _isPhoneValid = true;
      notifyListeners();
      
      sendVerificationCode();
    }
  }
  
  /// Limpia los recursos al destruir el controlador
  @override
  void dispose() {
    // Eliminar listeners para evitar fugas de memoria
    phoneController.removeListener(_validatePhoneRealtime);
    codeController.removeListener(_validateCodeRealtime);
    
    // Liberar recursos de los controladores
    phoneController.dispose();
    codeController.dispose();
    timerHelper.dispose();
    
    // Importante: llamar al dispose del padre
    // Es obligatorio ya que ChangeNotifier.dispose() está anotado con @mustCallSuper
    super.dispose();
  }
}
