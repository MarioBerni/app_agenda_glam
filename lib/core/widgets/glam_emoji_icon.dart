import 'package:flutter/material.dart';

/// Widget que muestra un emoji como icono con animaciones y efectos visuales
/// que mantienen la coherencia con el diseño de Agenda Glam.
///
/// Este widget permite usar emojis como alternativa a los iconos tradicionales
/// para dar un toque distintivo y personalizado a la aplicación.
class GlamEmojiIcon extends StatelessWidget {
  /// El emoji a mostrar como string (ej: "✨" o "🔍")
  final String emoji;
  
  /// Tamaño del emoji (equivalente a iconSize)
  final double size;
  
  /// Color para aplicar al emoji (opcional)
  final Color? color;
  
  /// Si el emoji está seleccionado (para efectos visuales)
  final bool isSelected;
  
  /// Constructor del icono de emoji
  const GlamEmojiIcon({
    super.key,
    required this.emoji,
    this.size = 24.0,
    this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected ? (color?.withOpacity(0.2) ?? Colors.transparent) : Colors.transparent,
        borderRadius: BorderRadius.circular(isSelected ? 16.0 : 0.0),
      ),
      padding: EdgeInsets.all(isSelected ? 8.0 : 0.0),
      child: Text(
        emoji,
        style: TextStyle(
          fontSize: size,
          color: color,
          // Aplicar efecto de sombra sutil si está seleccionado
          shadows: isSelected ? [
            Shadow(
              color: color?.withOpacity(0.5) ?? Colors.black12,
              blurRadius: 4.0,
            )
          ] : null,
        ),
      ),
    );
  }
}

/// Extensión para convertir fácilmente emojis en IconWidget
extension EmojiIconExtension on String {
  /// Convierte un emoji (string) en un widget GlamEmojiIcon
  Widget toEmojiIcon({
    double size = 24.0, 
    Color? color,
    bool isSelected = false,
  }) {
    return GlamEmojiIcon(
      emoji: this,
      size: size,
      color: color,
      isSelected: isSelected,
    );
  }
}

/// Widget específico para la barra de navegación que usa emojis
/// Esta implementación directa garantiza que los emojis siempre se muestren
class GlamEmojiBottomNavigationBarItem extends BottomNavigationBarItem {
  /// Crea un ítem de barra de navegación con un emoji
  GlamEmojiBottomNavigationBarItem({
    required String emoji,
    required String label,
    bool isSelected = false,
    Color? selectedColor,
    Color? unselectedColor,
  }) : super(
    icon: Text(
      emoji,
      style: TextStyle(
        fontSize: 22.0,
        color: isSelected ? selectedColor : unselectedColor,
      ),
    ),
    label: label,
  );
}
