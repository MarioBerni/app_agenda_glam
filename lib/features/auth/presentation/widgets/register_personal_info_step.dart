import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/widgets/glam_text_field.dart';
import 'package:flutter/material.dart';

/// Widget que representa el primer paso del registro donde se ingresan
/// los datos personales del usuario (tipo de usuario, nombre, teléfono y email).
class RegisterPersonalInfoStep extends StatelessWidget {
  /// Controlador para el campo de nombre
  final TextEditingController nameController;

  /// Controlador para el campo de email
  final TextEditingController emailController;
  
  /// Controlador para el campo de teléfono
  final TextEditingController? phoneController;
  
  /// Tipo de usuario seleccionado (Propietario, Empleado, Cliente)
  final String? userType;
  
  /// Función para actualizar el tipo de usuario seleccionado
  final Function(String) onUserTypeChanged;

  /// Mensaje de error para el campo de nombre (si existe)
  final String? nameError;

  /// Mensaje de error para el campo de email (si existe)
  final String? emailError;
  
  /// Mensaje de error para el campo de teléfono (si existe)
  final String? phoneError;

  /// Indica si el nombre es válido para efectos visuales
  final bool isNameValid;

  /// Indica si el email es válido para efectos visuales
  final bool isEmailValid;
  
  /// Indica si el teléfono es válido para efectos visuales
  final bool isPhoneValid;

  const RegisterPersonalInfoStep({
    super.key,
    required this.nameController,
    required this.emailController,
    this.phoneController,
    this.userType,
    required this.onUserTypeChanged,
    this.nameError,
    this.emailError,
    this.phoneError,
    this.isNameValid = false,
    this.isEmailValid = false,
    this.isPhoneValid = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      key: const ValueKey('personal_info_step'),
      children: [
        // Selector de tipo de usuario
        _buildUserTypeSelector(),
        
        const SizedBox(height: 24),
        
        // Campo de nombre con animación
        GlamTextField(
          controller: nameController,
          label: 'Nombre completo',
          prefixIcon: Icons.person_outline,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          errorText: nameError,
          hintText: 'Ingresa tu nombre completo',
        ),
        
        const SizedBox(height: 20),
        
        // Campo de teléfono
        GlamTextField(
          controller: phoneController,
          label: 'Número de teléfono',
          prefixIcon: Icons.phone_android,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          errorText: phoneError,
          hintText: '09XXXXXXXX',
        ),
        
        const SizedBox(height: 20),

        // Campo de email con animación
        GlamTextField(
          controller: emailController,
          label: 'Email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          errorText: emailError,
          hintText: 'nombre@ejemplo.com',
        ),

        // Texto informativo sobre el siguiente paso
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 14,
                color: Colors.white.withValues(alpha: 0.7),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'En el siguiente paso configurarás tu contraseña de acceso',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  /// Construye el selector de tipo de usuario con diseño atractivo
  Widget _buildUserTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título del selector
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 12.0),
          child: Text(
            '¿Cómo usarás esta aplicación?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ),
        
        // Opciones de tipo de usuario
        Row(
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
        ),
      ],
    );
  }
  
  /// Construye una opción individual del selector de tipo de usuario
  Widget _buildUserTypeOption(String type, IconData icon, String label) {
    final bool isSelected = userType == type;
    
    return InkWell(
      onTap: () => onUserTypeChanged(type),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? kAccentColor : Colors.white24,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? kAccentColor.withValues(alpha: 0.15) : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? kAccentColor : Colors.white70,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? kAccentColor : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
