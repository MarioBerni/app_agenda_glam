import 'package:flutter/material.dart';

/// Campo de contraseña personalizado que permite mostrar/ocultar el texto
class GlamPasswordField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController controller;
  final String? errorText;
  final bool enabled;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;

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
              color: theme.colorScheme.onBackground,
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
          onChanged: widget.onChanged,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onBackground,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            errorText: widget.errorText,
            prefixIcon: Icon(
              Icons.lock_outline,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: theme.colorScheme.onSurface.withOpacity(0.6),
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
      ],
    );
  }
}
