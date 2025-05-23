import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/routes/circle_navigation.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:app_agenda_glam/core/widgets/glam_ui.dart';
import 'package:app_agenda_glam/features/auth/domain/validators/register_validator.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Pantalla para recopilar información adicional después de la verificación por teléfono
///
/// Esta pantalla permite al usuario ingresar su nombre completo, fecha de nacimiento
/// y seleccionar su tipo de usuario para completar el proceso de registro.
class PhoneRegisterAdditionalInfoPage extends StatefulWidget {
  /// Número de teléfono verificado
  final String phoneNumber;
  
  const PhoneRegisterAdditionalInfoPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<PhoneRegisterAdditionalInfoPage> createState() => _PhoneRegisterAdditionalInfoPageState();
}

class _PhoneRegisterAdditionalInfoPageState extends State<PhoneRegisterAdditionalInfoPage> {
  // Controladores
  final _nameController = TextEditingController();
  
  // Estado
  bool _isLoading = false;
  String? _nameError;
  bool _isNameValid = false;
  String _userType = 'Cliente'; // Valor por defecto
  DateTime _birthDate = DateTime(2000, 1, 1);
  bool _isBirthDateSelected = false;
  
  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateNameRealtime);
  }
  
  @override
  void dispose() {
    _nameController.removeListener(_validateNameRealtime);
    _nameController.dispose();
    super.dispose();
  }
  
  /// Actualiza el tipo de usuario seleccionado
  void _updateUserType(String type) {
    setState(() {
      _userType = type;
    });
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
  
  /// Completa el registro con la información adicional
  void _completeRegistration() {
    // Validar nombre
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
    
    // Simular registro
    setState(() {
      _isLoading = true;
      _nameError = null;
    });
    
    // En un escenario real, aquí se registraría al usuario con Firebase Auth
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        
        // Simulamos registro exitoso
        CircleNavigation.goToHome(context);
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
                        title: 'Completar Registro',
                        subtitle: 'Solo unos datos más para terminar',
                        onBackPressed: () => CircleNavigation.goBackFromPhoneAdditionalInfo(context),
                      ),
                    ),
                    
                    // Espaciado estandarizado (32px) después del encabezado - igual que en todas las páginas
                    const SizedBox(height: 32),
                    
                    // Información del teléfono verificado
                    GlamAnimations.applyEntryEffect(
                      Card(
                        color: kSurfaceColor.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kBorderRadiusM),
                          side: BorderSide(color: kAccentColor.withValues(alpha: 0.3)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.check_circle, color: Colors.green),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Número verificado',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Teléfono: ${widget.phoneNumber}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
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
                    
                    const SizedBox(height: 24),
                    
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
                    
                    const SizedBox(height: 24),
                    
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
                    
                    const SizedBox(height: 40),
                    
                    // Botón de completar registro
                    GlamAnimations.applyEntryEffect(
                      GlamButton(
                        text: 'Completar Registro',
                        onPressed: !_isLoading ? _completeRegistration : null,
                        isLoading: _isLoading,
                        icon: Icons.check,
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
    final bool isSelected = _userType == type;
    
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
