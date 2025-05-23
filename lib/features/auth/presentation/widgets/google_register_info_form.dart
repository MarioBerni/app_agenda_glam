import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/auth/presentation/widgets/glam_button.dart';
import 'package:flutter/material.dart';

/// Formulario para recopilar información adicional después del registro con Google
///
/// Este widget presenta un formulario que solicita al usuario su tipo de usuario
/// (Cliente, Propietario o Empleado) y su número de teléfono. Se utiliza específicamente
/// después de que el usuario se ha autenticado con Google, pero antes de completar
/// el proceso de registro.
class GoogleRegisterInfoForm extends StatefulWidget {
  /// Nombre del usuario obtenido de Google
  final String userName;
  
  /// Email del usuario obtenido de Google
  final String userEmail;
  
  /// Función que se ejecuta cuando el usuario envía el formulario
  final Function(String userType, String phone) onSubmit;
  
  /// Indica si el formulario está en estado de carga
  final bool isLoading;
  
  /// Función que se ejecuta cuando el usuario cancela el proceso
  final VoidCallback onCancel;
  
  /// Error en la validación del teléfono
  final String? phoneError;
  
  /// Indicador de validez del teléfono en tiempo real
  final bool isPhoneValid;
  
  /// Controlador para el campo de teléfono
  final TextEditingController phoneController;

  const GoogleRegisterInfoForm({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.onSubmit,
    required this.onCancel,
    required this.phoneController,
    this.isLoading = false,
    this.phoneError,
    this.isPhoneValid = false,
  });

  @override
  State<GoogleRegisterInfoForm> createState() => _GoogleRegisterInfoFormState();
}

class _GoogleRegisterInfoFormState extends State<GoogleRegisterInfoForm> {
  // Tipo de usuario seleccionado
  String _selectedUserType = 'Cliente'; // Valor por defecto
  
  // Lista de tipos de usuario disponibles
  final List<String> _userTypes = ['Cliente', 'Propietario', 'Empleado'];

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Información de Google
        _buildGoogleUserInfo(),
        
        const SizedBox(height: kSpaceXL),
        
        // Selector de tipo de usuario
        _buildUserTypeSelector(),
        
        const SizedBox(height: kSpaceL),
        
        // Campo de teléfono
        _buildPhoneField(),
        
        const SizedBox(height: kSpaceXL),
        
        // Botones de acción
        _buildActionButtons(),
      ],
    );
  }
  
  /// Construye la sección de información del usuario de Google
  Widget _buildGoogleUserInfo() {
    return GlamAnimations.applyEntryEffect(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¡Hola, ${widget.userName}!',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: kSpaceXS),
          Text(
            'Tu cuenta de Google (${widget.userEmail}) ha sido vinculada correctamente.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: kSecondaryTextColor,
            ),
          ),
          const SizedBox(height: kSpaceM),
          Text(
            'Para completar tu registro, necesitamos algunos datos adicionales:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
  /// Construye el selector de tipo de usuario
  Widget _buildUserTypeSelector() {
    return GlamAnimations.applyEntryEffect(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tipo de Usuario',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: kSpaceS),
          Container(
            decoration: BoxDecoration(
              color: kSurfaceColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(kBorderRadiusM),
              border: Border.all(color: kAccentColor.withValues(alpha: 0.3)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: kSpaceS),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedUserType,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedUserType = newValue;
                    });
                  }
                },
                dropdownColor: kSurfaceColor,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
                icon: const Icon(Icons.arrow_drop_down, color: kAccentColor),
                isExpanded: true,
                items: _userTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: kSpaceS),
                      child: Text(value),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Construye el campo de teléfono
  Widget _buildPhoneField() {
    return GlamAnimations.applyEntryEffect(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Número de Teléfono',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: kSpaceS),
          TextFormField(
            controller: widget.phoneController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Ej: 099123456',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
              prefixIcon: const Icon(Icons.phone, color: kAccentColor),
              filled: true,
              fillColor: kSurfaceColor.withValues(alpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kBorderRadiusM),
                borderSide: BorderSide(color: kAccentColor.withValues(alpha: 0.3)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kBorderRadiusM),
                borderSide: BorderSide(color: kAccentColor.withValues(alpha: 0.3)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kBorderRadiusM),
                borderSide: const BorderSide(color: kAccentColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kBorderRadiusM),
                borderSide: const BorderSide(color: kErrorColor),
              ),
              errorText: widget.phoneError,
              suffixIcon: widget.isPhoneValid
                  ? const Icon(Icons.check_circle, color: Colors.green)
                  : null,
            ),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
  
  /// Construye los botones de acción
  Widget _buildActionButtons() {
    return GlamAnimations.applyEntryEffect(
      Row(
        children: [
          Expanded(
            child: GlamButton(
              text: 'Cancelar',
              onPressed: widget.onCancel,
              isSecondary: true,
            ),
          ),
          const SizedBox(width: kSpaceM),
          Expanded(
            child: GlamButton(
              text: 'Completar',
              onPressed: () => widget.onSubmit(_selectedUserType, widget.phoneController.text),
              isLoading: widget.isLoading,
              withShimmer: true,
            ),
          ),
        ],
      ),
    );
  }
}