import 'package:flutter/material.dart';

/// Botón personalizado con el estilo de Agenda Glam
/// Soporta estados de carga, deshabilitado y normal
class GlamButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final bool isSecondary;

  const GlamButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = 50,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.transparent : theme.colorScheme.secondary,
          foregroundColor: isSecondary ? theme.colorScheme.secondary : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isSecondary 
                ? BorderSide(color: theme.colorScheme.secondary, width: 2)
                : BorderSide.none,
          ),
          elevation: isSecondary ? 0 : 2,
          shadowColor: isSecondary ? Colors.transparent : theme.colorScheme.secondary.withOpacity(0.3),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isSecondary ? theme.colorScheme.secondary : Colors.black,
                  ),
                ),
              )
            : Text(
                text,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isSecondary ? theme.colorScheme.secondary : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
