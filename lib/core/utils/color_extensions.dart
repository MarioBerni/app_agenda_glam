import 'dart:ui';

/// Extensiones para la clase [Color] que proporcionan mÃ©todos alternativos
/// a los mÃ©todos deprecados, manteniendo la consistencia visual.
extension ColorExtensions on Color {
  /// MÃ©todo moderno para aplicar opacidad que evita pÃ©rdida de precisiÃ³n.
  ///
  /// Este mÃ©todo aplica una nueva opacidad manteniendo los componentes RGB.
  ///
  /// @param opacity Valor de opacidad entre 0.0 y 1.0
  /// @return Un nuevo color con la opacidad aplicada
  Color withAlpha(double opacity) {
    // Aseguramos que el valor de opacidad estÃ© en el rango vÃ¡lido
    final clampedOpacity = opacity.clamp(0.0, 1.0);

    // Creamos un nuevo color con los componentes actuales pero con la nueva opacidad
    // usando la API moderna de Color con withValues
    return withValues(alpha: clampedOpacity);
  }

  /// MÃ©todo de conveniencia para crear un nuevo color con valores RGBA.
  /// Facilita la transiciÃ³n desde withOpacity a la API moderna.
  ///
  /// @param r Componente rojo (0-255)
  /// @param g Componente verde (0-255)
  /// @param b Componente azul (0-255)
  /// @param opacity Opacidad (0.0-1.0)
  static Color fromRGBAValues(int r, int g, int b, double opacity) {
    // Aseguramos que el valor de opacidad estÃ© en el rango vÃ¡lido
    final clampedOpacity = opacity.clamp(0.0, 1.0);

    // Crear un color inicial y luego usar withValues para mantener precisiÃ³n
    final color = Color.fromARGB(255, r, g, b);
    return color.withValues(alpha: clampedOpacity);
  }

  /// Aclara un color mezclÃ¡ndolo con blanco.
  ///
  /// @param amount Valor entre 0.0 y 1.0 que indica cuÃ¡nto aclarar el color
  /// @return Un nuevo color aclarado
  Color lighten(double amount) {
    // Limitamos el valor entre 0.0 y 1.0
    final clampedAmount = amount.clamp(0.0, 1.0);

    // Usar los nuevos accesores .r, .g, .b en lugar de .r, .g, .b
    return Color.fromARGB(
      a.toInt(),
      r.toInt() + ((255 - r.toInt()) * clampedAmount).round(),
      g.toInt() + ((255 - g.toInt()) * clampedAmount).round(),
      b.toInt() + ((255 - b.toInt()) * clampedAmount).round(),
    );
  }

  /// Oscurece un color mezclÃ¡ndolo con negro.
  ///
  /// @param amount Valor entre 0.0 y 1.0 que indica cuÃ¡nto oscurecer el color
  /// @return Un nuevo color oscurecido
  Color darken(double amount) {
    // Limitamos el valor entre 0.0 y 1.0
    final clampedAmount = amount.clamp(0.0, 1.0);

    // Usar los nuevos accesores .r, .g, .b en lugar de .r, .g, .b
    return Color.fromARGB(
      a.toInt(),
      (r.toInt() * (1 - clampedAmount)).round(),
      (g.toInt() * (1 - clampedAmount)).round(),
      (b.toInt() * (1 - clampedAmount)).round(),
    );
  }
}
