import 'package:app_agenda_glam/features/auth/presentation/widgets/password_strength_indicator.dart';
import 'package:flutter/material.dart';

/// Campo de contraseña personalizado que permite mostrar/ocultar el texto
/// y opcionalmente mostrar un indicador de fortaleza
class GlamPasswordField extends StatefulWidget {
  /// Etiqueta del campo
  final String label;

  /// Texto de sugerencia (placeholder)
  final String? hintText;

  /// Controlador para el campo de texto
  final TextEditingController controller;

  /// Mensaje de error a mostrar
  final String? errorText;

  /// Si el campo está habilitado
  final bool enabled;

  /// Acción del teclado al completar
  final TextInputAction textInputAction;

  /// Nodo de foco para controlar el foco del campo
  final FocusNode? focusNode;

  /// Callback cuando se completa la edición
  final VoidCallback? onEditingComplete;

  /// Callback cuando cambia el valor
  final ValueChanged<String>? onChanged;

  /// Callback cuando se completa la entrada en el campo (al presionar 'Done' o 'Next')
  final ValueChanged<String>? onFieldSubmitted;

  /// Si se debe mostrar el indicador de fortaleza de contraseña
  final bool showStrengthIndicator;

  /// Criterios para evaluar la fortaleza de la contraseña
  final Map<String, bool> passwordCriteria;

  /// Etiquetas descriptivas para cada criterio
  final Map<String, String>? criteriaLabels;

  const GlamPasswordField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.onEditingComplete,
    this.onChanged,
    this.onFieldSubmitted,
    this.showStrengthIndicator = false,
    this.passwordCriteria = const {},
    this.criteriaLabels,
  });

  @override
  State<GlamPasswordField> createState() => _GlamPasswordFieldState();
}

class _GlamPasswordFieldState extends State<GlamPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          obscureText: _obscureText,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.errorText,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Color.fromRGBO(
                  theme.colorScheme.onSurface.r.toInt(),
                  theme.colorScheme.onSurface.g.toInt(),
                  theme.colorScheme.onSurface.b.toInt(),
                  0.6,
                ),
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.surface,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.secondary,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 1.0,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.error,
                width: 2.0,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),

        // Indicador de fortaleza de contraseña (si está habilitado)
        if (widget.showStrengthIndicator &&
            widget.passwordCriteria.isNotEmpty) ...[
          const SizedBox(height: 16),
          PasswordStrengthIndicator(
            criteria: widget.passwordCriteria,
            criteriaLabels:
                widget.criteriaLabels ??
                const {
                  'length': 'Al menos 6 caracteres',
                  'uppercase': 'Al menos una mayúscula',
                  'number': 'Al menos un número',
                },
          ),
        ],
      ],
    );
  }
}
