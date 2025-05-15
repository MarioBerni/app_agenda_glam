import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Campo de texto estilizado con etiqueta flotante y diseÃ±o visual unificado
///
/// Proporciona un campo de texto con estilo visual consistente para toda la aplicaciÃ³n,
/// incluyendo animaciones, validaciÃ³n visual y estados de error.
class GlamTextField extends StatefulWidget {
  /// Controlador de texto para el campo
  final TextEditingController? controller;

  /// Etiqueta para el campo
  final String label;

  /// Icono a mostrar en el campo (opcional)
  final IconData? prefixIcon;

  /// Si el campo es para contraseÃ±a
  final bool isPassword;

  /// Texto de ayuda (opcional)
  final String? hintText;

  /// FunciÃ³n de validaciÃ³n (opcional)
  final String? Function(String?)? validator;

  /// Tipo de teclado
  final TextInputType keyboardType;

  /// AcciÃ³n del teclado
  final TextInputAction textInputAction;

  /// FunciÃ³n cuando se completa la ediciÃ³n
  final Function(String)? onFieldSubmitted;

  /// FunciÃ³n cuando cambia el valor
  final Function(String)? onChanged;

  /// Texto de error (opcional)
  final String? errorText;

  /// Widget de sufijo (opcional)
  final Widget? suffixIcon;

  /// Si el campo estÃ¡ habilitado
  final bool enabled;

  /// Lista de formateadores de texto (opcional)
  final List<TextInputFormatter>? inputFormatters;

  /// NÃºmero mÃ¡ximo de lÃ­neas (opcional)
  final int? maxLines;

  /// Constructor
  const GlamTextField({
    super.key,
    this.controller,
    required this.label,
    this.prefixIcon,
    this.isPassword = false,
    this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onChanged,
    this.errorText,
    this.suffixIcon,
    this.enabled = true,
    this.inputFormatters,
    this.maxLines = 1,
  });

  @override
  State<GlamTextField> createState() => _GlamTextFieldState();
}

class _GlamTextFieldState extends State<GlamTextField> {
  bool _obscureText = true;
  bool _isFocused = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Construir el campo de texto con animaciÃ³n
    return GlamAnimations.applyEntryEffect(
      TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: _obscureText && widget.isPassword,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        cursorColor: kAccentColor,
        decoration: InputDecoration(
          // Etiqueta y texto de sugerencia
          labelText: widget.label,
          hintText: widget.hintText,
          errorText: widget.errorText,

          // Estilos para estados activo/inactivo
          labelStyle: TextStyle(
            color: _isFocused ? kAccentColor : Colors.white70,
            fontSize: 16,
          ),
          hintStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.4),
            fontSize: 14,
          ),
          errorStyle: const TextStyle(color: kErrorColor, fontSize: 12),

          // Bordes y colores
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: kAccentColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: kErrorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: kErrorColor),
          ),

          // Fondo con transparencia sutil
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.05),

          // Iconos
          prefixIcon:
              widget.prefixIcon != null
                  ? Icon(
                    widget.prefixIcon,
                    color: _isFocused ? kAccentColor : Colors.white70,
                  )
                  : null,
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.white70,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                  : widget.suffixIcon,
        ),
      ),
    );
  }
}
