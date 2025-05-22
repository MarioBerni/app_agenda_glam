import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:flutter/material.dart';

/// Botón reutilizable para autenticación con Google
/// 
/// Este componente mantiene una apariencia visual consistente
/// para los flujos de inicio de sesión y registro con Google.
class GlamGoogleButton extends StatelessWidget {
  /// Texto que se muestra en el botón
  final String text;
  
  /// Función que se ejecuta al presionar el botón
  final VoidCallback onPressed;
  
  /// Indica si el botón está en estado de carga
  final bool isLoading;
  
  /// Indica si el botón debe estar deshabilitado
  final bool disabled;

  /// Constructor del botón de Google
  const GlamGoogleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white30),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: (disabled || isLoading) ? null : onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading)
                    Container(
                      width: 20,
                      height: 20,
                      margin: const EdgeInsets.only(right: 12.0),
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
                      ),
                    )
                  else
                    // Icono de Google personalizado con círculos de colores
                    Container(
                      width: 24,
                      height: 24,
                      margin: const EdgeInsets.only(right: 12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ),
                  Text(
                    isLoading ? 'Conectando...' : text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      slideDistance: 0.2,
    );
  }
}
