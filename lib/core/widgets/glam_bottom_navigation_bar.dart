import 'package:flutter/material.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/core/utils/color_utils.dart';

/// Widget personalizado para la barra de navegación inferior que mantiene
/// la coherencia visual con el resto de la aplicación Agenda Glam.
///
/// Permite la navegación entre las principales secciones de la aplicación
/// con animaciones y efectos visuales que mejoran la experiencia de usuario.
class GlamBottomNavigationBar extends StatelessWidget {
  /// Índice del ítem actualmente seleccionado (0-based)
  final int currentIndex;
  
  /// Callback que se ejecuta cuando se selecciona un ítem
  final ValueChanged<int> onTap;
  
  /// Lista de etiquetas para los ítems (debe coincidir con la cantidad de ítems)
  final List<String> labels;
  
  /// Lista de iconos para los ítems (debe coincidir con la cantidad de ítems)
  final List<IconData> icons;
  
  /// Color de fondo de la barra (por defecto, azul oscuro de la app)
  final Color backgroundColor;
  
  /// Color de los ítems seleccionados (por defecto, dorado de la app)
  final Color selectedItemColor;
  
  /// Color de los ítems no seleccionados (por defecto, blanco con opacidad)
  final Color unselectedItemColor;
  
  /// Duración de la animación de transición entre ítems
  final Duration animationDuration;
  
  /// Constructor para la barra de navegación personalizada
  const GlamBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.labels,
    required this.icons,
    this.backgroundColor = kSurfaceColor,
    this.selectedItemColor = kAccentColor,
    this.unselectedItemColor = Colors.white70,
    this.animationDuration = const Duration(milliseconds: 200),
  }) : assert(labels.length == icons.length, 'Las listas de etiquetas e iconos deben tener la misma longitud');

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Colors.transparent,
          selectedItemColor: selectedItemColor,
          unselectedItemColor: unselectedItemColor,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 11,
          ),
          elevation: 0,
          items: List.generate(
            labels.length,
            (index) => _buildNavigationBarItem(
              icon: icons[index],
              label: labels[index],
              isSelected: index == currentIndex,
            ),
          ),
        ),
      ),
    );
  }
  
  /// Construye un ítem individual de la barra con efectos visuales mejorados
  BottomNavigationBarItem _buildNavigationBarItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: _buildIcon(icon, isSelected),
      label: label,
    );
  }
  
  /// Construye un ícono con efecto de selección y animación
  Widget _buildIcon(IconData icon, bool isSelected) {
    return AnimatedContainer(
      duration: animationDuration,
      padding: EdgeInsets.all(isSelected ? 12 : 8),
      decoration: BoxDecoration(
        color: isSelected 
            ? ColorUtils.withOpacityValue(selectedItemColor, 0.15) 
            : Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: isSelected ? 26 : 22,
      ),
    );
  }
}

/// Controlador para la barra de navegación inferior
/// Gestiona el índice seleccionado y notifica cambios a los listeners
class GlamBottomNavigationController extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isAuthenticated = false;
  
  /// Índice de la pestaña seleccionada actualmente
  int get selectedIndex => _selectedIndex;
  
  /// Establece el índice seleccionado y notifica a los listeners
  set selectedIndex(int value) {
    if (_selectedIndex != value) {
      _selectedIndex = value;
      notifyListeners();
    }
  }
  
  /// Estado de autenticación del usuario
  bool get isAuthenticated => _isAuthenticated;
  
  /// Actualiza el estado de autenticación y notifica a los listeners
  set isAuthenticated(bool value) {
    if (_isAuthenticated != value) {
      _isAuthenticated = value;
      notifyListeners();
    }
  }
  
  /// Obtiene el nombre de la ruta para la pestaña seleccionada
  /// Útil para integración con GoRouter
  String getRouteForIndex(int index) {
    switch (index) {
      case 0: return '/home';
      case 1: return '/explore';
      case 2: return '/benefits';
      case 3: return '/profile';
      default: return '/home';
    }
  }
  
  /// Verifica si la pestaña en el índice especificado requiere autenticación
  bool tabRequiresAuth(int index) {
    // Actualmente solo la pestaña de perfil (3) requiere autenticación
    return index == 3;
  }
  
  /// Obtiene el nombre de la ruta para el índice seleccionado (útil para GoRouter)
  String getRouteNameForIndex(int index, List<String> routeNames) {
    if (index >= 0 && index < routeNames.length) {
      return routeNames[index];
    }
    return routeNames.first; // Valor por defecto
  }
}
