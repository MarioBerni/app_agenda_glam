import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';

/// Widget que muestra visualmente la fortaleza de una contraseña
/// basado en diferentes criterios como longitud, caracteres especiales, etc.
class PasswordStrengthIndicator extends StatelessWidget {
  /// Mapa de criterios y si se cumplen o no
  final Map<String, bool> criteria;
  
  /// Etiquetas descriptivas para cada criterio
  final Map<String, String> criteriaLabels;

  /// Constructor
  const PasswordStrengthIndicator({
    super.key,
    required this.criteria,
    this.criteriaLabels = const {
      'length': 'Al menos 6 caracteres',
      'uppercase': 'Al menos una mayúscula',
      'number': 'Al menos un número',
    },
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título de la sección
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0, left: 4.0),
          child: Text(
            'Fortaleza de la contraseña',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ),
        
        // Indicador de progreso
        _buildStrengthBar(),
        
        const SizedBox(height: 16),
        
        // Lista de criterios
        ...criteria.keys.map((key) => _buildCriterionItem(key)),
      ],
    );
  }

  /// Construye la barra de progreso de fortaleza
  Widget _buildStrengthBar() {
    // Calcular la fortaleza basada en cuántos criterios se cumplen
    final int fulfilledCriteria = criteria.values.where((v) => v).length;
    final double strength = criteria.isEmpty 
      ? 0.0 
      : fulfilledCriteria / criteria.length;
    
    // Determinar color basado en la fortaleza
    Color barColor;
    String strengthText;
    
    if (strength <= 0.33) {
      barColor = Colors.red.shade700;
      strengthText = 'Débil';
    } else if (strength <= 0.66) {
      barColor = Colors.orange.shade700;
      strengthText = 'Media';
    } else {
      barColor = Colors.green.shade600;
      strengthText = 'Fuerte';
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Fondo de barra
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            
            // Barra de progreso animada
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 6,
              width: strength * 100.0.clamp(0, 100),
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 4),
        
        // Texto de fortaleza
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Text(
            strengthText,
            key: ValueKey(strengthText),
            style: TextStyle(
              fontSize: 12,
              color: barColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  /// Construye un elemento de criterio individual
  Widget _buildCriterionItem(String key) {
    final bool isFulfilled = criteria[key] ?? false;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          // Icono con animación de éxito/pendiente
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: isFulfilled
                ? GlamAnimations.applySuccessEffect(
                    Icon(
                      Icons.check_circle,
                      key: const ValueKey('check'),
                      color: kAccentColor,
                      size: 16,
                    ),
                  )
                : Icon(
                    Icons.circle_outlined,
                    key: const ValueKey('circle'),
                    color: Colors.white.withOpacity(0.6),
                    size: 16,
                  ),
          ),
          
          const SizedBox(width: 8),
          
          // Texto del criterio
          Text(
            criteriaLabels[key] ?? key,
            style: TextStyle(
              fontSize: 13,
              color: isFulfilled 
                ? Colors.white.withOpacity(0.9) 
                : Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
