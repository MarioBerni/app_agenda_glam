import 'dart:async';
import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:flutter/services.dart';
import 'package:app_agenda_glam/features/auth/domain/validators/register_validator.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Página unificada para registro con teléfono
///
/// Incluye todos los campos necesarios en una sola pantalla:
/// - Nombre completo
/// - Fecha de nacimiento
/// - Número de teléfono
/// - Código de verificación (se activa después de enviar el código)
class PhoneRegisterPage extends StatefulWidget {
  const PhoneRegisterPage({super.key});

  @override
  State<PhoneRegisterPage> createState() => _PhoneRegisterPageState();
}

class _PhoneRegisterPageState extends State<PhoneRegisterPage> {
  // Controladores
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  
  // Estado
  bool _isLoading = false;
  bool _isCodeSent = false;
  bool _isVerifying = false;
  String? _nameError;
  String? _phoneError;
  String? _codeError;
  bool _isNameValid = false;
  bool _isPhoneValid = false;
  bool _isCodeValid = false;
  String? _userType; // Sin selección por defecto
  DateTime _birthDate = DateTime(2000, 1, 1);
  bool _isBirthDateSelected = false;
  
  // Temporizador para reenvío
  late Timer? _timer;
  int _timerSeconds = 120; // 2 minutos
  bool _canResend = false;
  int _resendCount = 0;
  final int _maxResends = 2;
  
  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateNameRealtime);
    _phoneController.addListener(_validatePhoneRealtime);
    _codeController.addListener(_validateCodeRealtime);
    _timer = null;
  }
  
  @override
  void dispose() {
    _nameController.removeListener(_validateNameRealtime);
    _phoneController.removeListener(_validatePhoneRealtime);
    _codeController.removeListener(_validateCodeRealtime);
    _nameController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    _timer?.cancel();
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
  
  /// Valida el nombre en tiempo real
  void _validateNameRealtime() {
    final nameText = _nameController.text.trim();
    
    if (nameText.isEmpty) {
      setState(() {
        _isNameValid = false;
      });
      return;
    }
    
    final validationError = RegisterValidator.validateName(nameText);
    final isValid = validationError == null;
    
    if (_isNameValid != isValid) {
      setState(() {
        _isNameValid = isValid;
      });
    }
  }
  
  /// Valida el teléfono en tiempo real
  void _validatePhoneRealtime() {
    final phoneText = _phoneController.text.trim();
    
    if (phoneText.isEmpty) {
      setState(() {
        _isPhoneValid = false;
      });
      return;
    }
    
    final validationError = RegisterValidator.validatePhone(phoneText);
    final isValid = validationError == null;
    
    if (_isPhoneValid != isValid) {
      setState(() {
        _isPhoneValid = isValid;
      });
    }
  }
  
  /// Valida el código en tiempo real
  void _validateCodeRealtime() {
    final codeText = _codeController.text.trim();
    
    if (codeText.isEmpty) {
      setState(() {
        _isCodeValid = false;
      });
      return;
    }
    
    // Código simple de 6 dígitos
    final isValid = codeText.length == 6 && int.tryParse(codeText) != null;
    
    if (_isCodeValid != isValid) {
      setState(() {
        _isCodeValid = isValid;
      });
    }
  }
  
  /// Actualiza el tipo de usuario seleccionado
  void _updateUserType(String type) {
    setState(() {
      _userType = type;
    });
  }
  
  /// Selecciona la fecha de nacimiento
  Future<void> _selectBirthDate() async {
    final initialDate = _isBirthDateSelected ? _birthDate : DateTime(2000, 1, 1);
    final firstDate = DateTime(1940, 1, 1);
    final lastDate = DateTime.now().subtract(const Duration(days: 365 * 18)); // 18 años mínimo
    
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('es', 'ES'), // Configurar localización en español
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: kAccentColor,
              onPrimary: Colors.white,
              surface: kSurfaceColor,
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: kSurfaceColor),
          ),
          child: child!,
        );
      },
    );
    
    if (selectedDate != null) {
      setState(() {
        _birthDate = selectedDate;
        _isBirthDateSelected = true;
      });
    }
  }
  
  /// Envía el código de verificación
  void _sendVerificationCode() {
    // Validación final antes de enviar
    final nameText = _nameController.text.trim();
    final nameValidationError = RegisterValidator.validateName(nameText);
    
    if (nameValidationError != null) {
      setState(() {
        _nameError = nameValidationError;
        _isNameValid = false;
      });
      return;
    }
    
    // Validar fecha de nacimiento
    if (!_isBirthDateSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona tu fecha de nacimiento'),
          backgroundColor: kErrorColor,
        ),
      );
      return;
    }
    
    // Validar teléfono
    final phoneText = _phoneController.text.trim();
    final phoneValidationError = RegisterValidator.validatePhone(phoneText);
    
    if (phoneValidationError != null) {
      setState(() {
        _phoneError = phoneValidationError;
        _isPhoneValid = false;
      });
      return;
    }
    
    // Simulación de envío de código
    setState(() {
      _isLoading = true;
      _nameError = null;
      _phoneError = null;
    });
    
    // Simulamos un proceso de envío de SMS
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isCodeSent = true;
        });
        
        // Iniciar temporizador para reenvío
        _startTimer();
        
        // Feedback visual
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Código enviado. Por favor verifica tu teléfono.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
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
  
  /// Verifica el código y completa el registro
  void _verifyAndRegister() {
    // Validar código
    final codeText = _codeController.text.trim();
    if (codeText.length != 6 || int.tryParse(codeText) == null) {
      setState(() {
        _codeError = 'Por favor ingresa un código válido de 6 dígitos';
        _isCodeValid = false;
      });
      return;
    }
    
    // Simular verificación
    setState(() {
      _isVerifying = true;
      _codeError = null;
    });
    
    // En un escenario real, aquí se verificaría el código con Firebase Auth
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
        
        // Simulamos verificación exitosa
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registro completado con éxito.'),
            backgroundColor: Colors.green,
          ),
        );
        
        // Navegar a home (en implementación real)
        Navigator.of(context).pop(); // Por ahora solo volvemos atrás
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
                        title: 'Registro con Teléfono',
                        subtitle: 'Completa tus datos para registrarte en Agenda Glam',
                        onBackPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    
                    // Espaciado estandarizado (32px) después del encabezado - igual que en todas las páginas
                    const SizedBox(height: 32),
                    
                    // Campo de nombre
                    GlamAnimations.applyEntryEffect(
                      GlamTextField(
                        controller: _nameController,
                        label: 'Nombre completo',
                        prefixIcon: Icons.person_outline,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        errorText: _nameError,
                        hintText: 'Ingresa tu nombre completo',
                        suffixIcon: _isNameValid 
                            ? const Icon(Icons.check_circle, color: Colors.green) 
                            : null,
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Selector de fecha de nacimiento
                    GlamAnimations.applyEntryEffect(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fecha de Nacimiento',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: _selectBirthDate,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _isBirthDateSelected 
                                      ? kAccentColor 
                                      : Colors.white.withValues(alpha: 0.3),
                                ),
                                color: Colors.white.withValues(alpha: 0.05),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: _isBirthDateSelected 
                                        ? kAccentColor 
                                        : Colors.white.withValues(alpha: 0.7),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _isBirthDateSelected 
                                        ? DateFormat('dd/MM/yyyy').format(_birthDate)
                                        : 'Selecciona tu fecha de nacimiento',
                                    style: TextStyle(
                                      color: _isBirthDateSelected 
                                          ? Colors.white 
                                          : Colors.white.withValues(alpha: 0.5),
                                    ),
                                  ),
                                  const Spacer(),
                                  if (_isBirthDateSelected)
                                    const Icon(Icons.check_circle, color: Colors.green),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Tipo de usuario
                    GlamAnimations.applyEntryEffect(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tipo de Usuario',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildUserTypeSelector(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
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
                    
                    const SizedBox(height: 8),
                    
                    // Texto informativo
                    GlamAnimations.applyEntryEffect(
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          'Te enviaremos un código de verificación a este número.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Botón de enviar código
                    if (!_isCodeSent)
                      GlamAnimations.applyEntryEffect(
                        GlamButton(
                          text: 'Enviar Código',
                          onPressed: _isNameValid && _isPhoneValid && _isBirthDateSelected && !_isLoading 
                              ? _sendVerificationCode 
                              : null,
                          isLoading: _isLoading,
                          icon: Icons.send,
                          withShimmer: true,
                        ),
                      ),
                    
                    // Campo de código de verificación (inicialmente oculto)
                    if (_isCodeSent) ...[
                      const SizedBox(height: 20),
                      GlamAnimations.applyEntryEffect(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Código de Verificación',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GlamTextField(
                              controller: _codeController,
                              label: 'Código de 6 dígitos',
                              prefixIcon: Icons.lock_outline,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              errorText: _codeError,
                              hintText: '123456',
                              suffixIcon: _isCodeValid 
                                  ? const Icon(Icons.check_circle, color: Colors.green) 
                                  : null,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(6),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Opción de reenvío
                            Row(
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
                            
                            const SizedBox(height: 20),
                            
                            // Botón de verificar y registrar
                            GlamButton(
                              text: 'Verificar y Registrar',
                              onPressed: _isCodeValid && !_isVerifying ? _verifyAndRegister : null,
                              isLoading: _isVerifying,
                              icon: Icons.check_circle_outline,
                              withShimmer: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                    
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
  
  /// Construye el selector de tipo de usuario con diseño atractivo
  Widget _buildUserTypeSelector() {
    return Row(
      children: [
        // Opción Propietario
        Expanded(
          child: _buildUserTypeOption(
            'Propietario',
            Icons.business,
            'Propietario',
          ),
        ),
        const SizedBox(width: 8),
        
        // Opción Empleado
        Expanded(
          child: _buildUserTypeOption(
            'Empleado',
            Icons.work,
            'Empleado',
          ),
        ),
        const SizedBox(width: 8),
        
        // Opción Cliente
        Expanded(
          child: _buildUserTypeOption(
            'Cliente',
            Icons.person,
            'Cliente',
          ),
        ),
      ],
    );
  }
  
  /// Construye una opción individual del selector de tipo de usuario
  Widget _buildUserTypeOption(String type, IconData icon, String label) {
    final bool isSelected = _userType != null && _userType == type;
    
    return InkWell(
      onTap: () => _updateUserType(type),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? kAccentColor.withValues(alpha: 0.15) : Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? kAccentColor : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? kAccentColor : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? kAccentColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
