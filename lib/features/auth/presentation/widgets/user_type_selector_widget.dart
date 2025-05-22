import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';

/// Widget reutilizable para seleccionar el tipo de usuario
/// (Cliente, Propietario, Empleado)
class UserTypeSelectorWidget extends StatelessWidget {
  /// El tipo de usuario actualmente seleccionado
  final String selectedUserType;
  
  /// Callback que se ejecuta cuando se selecciona un tipo de usuario
  final Function(String) onUserTypeSelected;
  
  /// Controla si se debe mostrar el título interno del componente
  /// Útil cuando el componente se usa dentro de otra sección que ya tiene un título
  final bool showTitle;

  const UserTypeSelectorWidget({
    super.key,
    required this.selectedUserType,
    required this.onUserTypeSelected,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título condicional que solo se muestra si showTitle es true
          if (showTitle) ...[  
            Text(
              'Tipo de Usuario',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
          ],
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
      ),
    );
  }
  
  /// Construye una opción individual del selector de tipo de usuario
  Widget _buildUserTypeOption(String type, IconData icon, String label) {
    final bool isSelected = selectedUserType == type;
    
    return InkWell(
      onTap: () => onUserTypeSelected(type),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? kAccentColor.withOpacity(0.15) : Colors.black.withOpacity(0.3),
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
              style: TextStyle(
                color: isSelected ? kAccentColor : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
