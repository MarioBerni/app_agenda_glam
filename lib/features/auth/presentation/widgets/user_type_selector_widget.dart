import 'package:app_agenda_glam/core/animations/animation_presets.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/// Widget reutilizable para seleccionar el tipo de usuario
/// (Cliente, Propietario, Empleado)
class UserTypeSelectorWidget extends StatefulWidget {
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
  State<UserTypeSelectorWidget> createState() => _UserTypeSelectorWidgetState();
}

class _UserTypeSelectorWidgetState extends State<UserTypeSelectorWidget> with TickerProviderStateMixin {
  // Controlador principal de animación
  late final AnimationController _sequenceController;
  
  // Lista ordenada de tipos de usuario para la secuencia
  final List<String> _userTypes = ['Propietario', 'Empleado', 'Cliente'];
  
  // Mapa para rastrear qué tarjeta está siendo presionada actualmente
  final Map<String, bool> _isCardPressed = {
    'Propietario': false,
    'Empleado': false,
    'Cliente': false,
  };
  
  // Mapa para rastrear cuál es la tarjeta activa en la secuencia
  late int _activeCardIndex = 0;
  
  // Timer para cambiar entre tarjetas
  Timer? _sequenceTimer;
  
  @override
  void initState() {
    super.initState();
    
    // Inicializar controlador de secuencia
    _sequenceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Duración más corta para un efecto más dinámico
    );
    
    // Iniciar la secuencia si no hay selección
    if (widget.selectedUserType.isEmpty) {
      _startSequence();
    }
  }
  
  @override
  void didUpdateWidget(UserTypeSelectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedUserType != widget.selectedUserType) {
      if (widget.selectedUserType.isEmpty) {
        _startSequence();
      } else {
        _stopSequence();
      }
    }
  }
  
  // Inicia la secuencia de animación
  void _startSequence() {
    // Detener cualquier secuencia previa
    _stopSequence();
    
    // Iniciar con la primera tarjeta
    _activeCardIndex = 0;
    
    // Iniciar la animación para la tarjeta actual
    _animateCurrentCard();
    
    // Programar el cambio a la siguiente tarjeta
    _sequenceTimer = Timer.periodic(const Duration(milliseconds: 1500), (_) {
      setState(() {
        // Avanzar al siguiente índice, volviendo al principio si es necesario
        _activeCardIndex = (_activeCardIndex + 1) % _userTypes.length;
      });
      
      // Reiniciar la animación para la nueva tarjeta activa
      _animateCurrentCard();
    });
  }
  
  // Anima la tarjeta actualmente seleccionada en la secuencia
  void _animateCurrentCard() {
    // Reiniciar la animación
    _sequenceController.reset();
    _sequenceController.forward().then((_) {
      _sequenceController.reverse();
    });
  }
  
  // Detiene la secuencia de animación
  void _stopSequence() {
    _sequenceTimer?.cancel();
    _sequenceTimer = null;
    _sequenceController.stop();
  }
  
  @override
  void dispose() {
    _stopSequence();
    _sequenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlamAnimations.applyEntryEffect(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        // Título condicional que solo se muestra si showTitle es true
        if (widget.showTitle) ...[  
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
    final bool isSelected = widget.selectedUserType == type;
    final bool isActive = _userTypes[_activeCardIndex] == type && widget.selectedUserType.isEmpty;
    
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isCardPressed[type] = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isCardPressed[type] = false;
        });
        widget.onUserTypeSelected(type);
      },
      onTapCancel: () {
        setState(() {
          _isCardPressed[type] = false;
        });
      },
      child: AnimatedBuilder(
        animation: _sequenceController,
        builder: (context, child) {
          // Calculamos la escala basada en si la tarjeta está activa en la secuencia
          // o presionada por el usuario
          final pressScale = _isCardPressed[type] == true ? 0.95 : 1.0;
          
          // Escala de "respiración" solo para la tarjeta activa y no seleccionada
          final breathingScale = isActive && !isSelected
              ? 1.0 + (0.05 * _sequenceController.value)
              : 1.0;
          
          // Colores para diferentes estados
          final bgColor = isSelected 
              ? kAccentColor.withValues(alpha: 0.15) 
              : isActive 
                  ? Colors.black.withValues(alpha: 0.4)
                  : Colors.black.withValues(alpha: 0.3);
          
          final iconColor = isSelected 
              ? kAccentColor 
              : isActive
                  ? Colors.white
                  : Colors.grey.shade400;
              
          // Elevación y efectos visuales
          final elevation = isSelected ? 4.0 : isActive ? 2.0 : 0.0;
          
          // Brillo del borde (más intenso para tarjeta activa)
          final borderGlow = isSelected 
              ? 0.0 
              : isActive 
                  ? 0.5 + (0.5 * _sequenceController.value)
                  : 0.0;
              
          return Transform.scale(
            scale: pressScale * breathingScale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected 
                      ? kAccentColor 
                      : isActive
                          ? kAccentColor.withValues(alpha: borderGlow)
                          : Colors.transparent,
                  width: isSelected ? 2.0 : 1.0,
                ),
                boxShadow: (isSelected || isActive) ? [
                  BoxShadow(
                    color: kAccentColor.withValues(
                      alpha: isSelected ? 0.2 : isActive ? 0.3 * _sequenceController.value : 0.0,
                    ),
                    blurRadius: isSelected ? 8.0 : isActive ? 6.0 * _sequenceController.value : 0.0,
                    spreadRadius: isSelected ? elevation / 4 : isActive ? elevation / 6 : 0.0,
                  ),
                ] : [],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icono con animación
                  AnimatedScale(
                    scale: isActive && !isSelected ? 1.0 + (0.2 * _sequenceController.value) : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      icon,
                      size: 28,
                      color: iconColor,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Texto
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: TextStyle(
                      color: iconColor,
                      fontWeight: isSelected || isActive ? FontWeight.bold : FontWeight.normal,
                    ),
                    child: Text(label),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
