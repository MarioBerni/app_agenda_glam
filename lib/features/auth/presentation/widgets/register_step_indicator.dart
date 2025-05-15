import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';

/// Widget que muestra el indicador de progreso para el flujo de registro
/// con animaciones para las transiciones entre pasos.
class RegisterStepIndicator extends StatelessWidget {
  /// El paso actual del registro
  final int currentStep;
  
  /// El número total de pasos en el flujo de registro
  final int totalSteps;

  const RegisterStepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 1; i <= totalSteps; i++) _buildStep(context, i),
      ],
    );
  }

  /// Construye un indicador individual de paso
  Widget _buildStep(BuildContext context, int step) {
    final bool isCompleted = step < currentStep;
    final bool isCurrent = step == currentStep;
    
    return Expanded(
      child: Row(
        children: [
          // Círculo indicador
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isCompleted || isCurrent 
                ? kAccentColor 
                : Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: isCompleted || isCurrent 
                  ? kAccentColor 
                  : Colors.white.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: isCompleted || isCurrent 
                ? [
                    BoxShadow(
                      color: kAccentColor.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ] 
                : null,
            ),
            child: Center(
              child: isCompleted
                ? const Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 18,
                  )
                : Text(
                    '$step',
                    style: TextStyle(
                      color: isCurrent ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ),
          ),
          
          // Línea entre pasos (excepto el último)
          if (step < totalSteps)
            Expanded(
              child: Container(
                height: 2,
                color: isCompleted 
                  ? kAccentColor 
                  : Colors.white.withOpacity(0.15),
              ),
            ),
        ],
      ),
    );
  }
}
