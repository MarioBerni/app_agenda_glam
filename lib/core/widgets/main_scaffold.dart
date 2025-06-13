import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_agenda_glam/core/widgets/glam_bottom_navigation_bar.dart';
import 'package:app_agenda_glam/core/widgets/glam_gradient_background.dart';
import 'package:app_agenda_glam/core/theme/app_theme_constants.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_agenda_glam/features/auth/presentation/bloc/auth_state.dart';
import 'package:go_router/go_router.dart';

/// Scaffold principal que incluye la barra de navegación inferior
/// para todas las pantallas principales de la aplicación.
///
/// Este scaffold proporciona una estructura consistente manteniendo
/// la estética visual de la aplicación y la navegación entre pestañas.
class MainScaffold extends StatelessWidget {
  /// El cuerpo principal del scaffold (contenido de la pantalla)
  final Widget body;
  
  /// El índice de la pestaña seleccionada actualmente (0-3)
  final int currentIndex;
  
  /// Callback para navegar entre pestañas
  final Function(int) onTabChanged;
  
  /// Color principal para el fondo degradado (opcional)
  final Color? primaryColor;
  
  /// Intensidad del degradado del fondo (opcional)
  final double backgroundIntensity;
  
  /// Si se debe mostrar un AppBar en la parte superior
  final bool showAppBar;
  
  /// Título para el AppBar (si está habilitado)
  final String? appBarTitle;
  
  /// Si se debe mostrar un botón de regreso en el AppBar
  final bool showBackButton;
  
  /// Lista de etiquetas para los ítems de la barra de navegación
  final List<String> labels;
  
  /// Lista de iconos para los ítems de la barra de navegación
  /// Pueden ser objetos IconData tradicionales o emojis como String
  final List<dynamic> icons;
  
  /// Constructor del scaffold principal
  const MainScaffold({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onTabChanged,
    this.labels = const ['Inicio', 'Explorar', 'Beneficios', 'Perfil'],
    this.icons = const ['🏠', '🔍', '✨', '👤'],
    this.primaryColor,
    this.backgroundIntensity = 0.8,
    this.showAppBar = false,
    this.appBarTitle,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fondo con gradiente consistente con el resto de la app
      backgroundColor: Colors.transparent,
      extendBody: true, // Permite que el contenido se extienda debajo de la barra
      
      // AppBar opcional para algunas pantallas
      appBar: showAppBar ? AppBar(
        title: Text(appBarTitle ?? ''),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: showBackButton ? IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ) : null,
      ) : null,
      
      // Contenido principal
      body: Stack(
        children: [
          // Fondo con degradado
          GlamGradientBackground(
            primaryColor: primaryColor ?? kPrimaryColor,
            opacity: backgroundIntensity,
          ),
          
          // Contenido de la pantalla
          SafeArea(
            bottom: false, // No aplicar SafeArea en la parte inferior (donde está la barra)
            child: body,
          ),
        ],
      ),
      
      // Barra de navegación inferior personalizada
      bottomNavigationBar: GlamBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabChanged,
        labels: labels,
        icons: icons,
      ),
    );
  }
}

/// Widget que gestiona la navegación entre las pestañas principales
/// usando el controlador de navegación inferior y GoRouter.
class MainNavigator extends StatefulWidget {
  /// Widget a mostrar como contenido principal (determinado por GoRouter)
  final Widget child;
  
  /// Constructor del navegador principal
  const MainNavigator({
    super.key,
    required this.child,
  });

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  /// Controlador de la barra de navegación
  final _navigationController = GlamBottomNavigationController();
  
  @override
  void dispose() {
    _navigationController.dispose();
    super.dispose();
  }
  
  /// Cambia a la pestaña seleccionada actualizando la ruta
  void _handleTabChanged(int index) {
    final List<String> routes = [
      '/home',
      '/explore',
      '/benefits',
      '/profile',
    ];
    
    if (index >= 0 && index < routes.length) {
      // Usar context.go() para navegar a la ruta correspondiente
      context.go(routes[index]);
      
      // Actualizar el índice en el controlador
      _navigationController.selectedIndex = index;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // Obtener la ruta actual y determinar el índice seleccionado
    final String location = GoRouterState.of(context).uri.path;
    int currentIndex = 0;
    
    if (location.startsWith('/explore')) {
      currentIndex = 1;
    } else if (location.startsWith('/benefits')) {
      currentIndex = 2;
    } else if (location.startsWith('/profile')) {
      currentIndex = 3;
    }
    
    // Actualizar el controlador
    _navigationController.selectedIndex = currentIndex;
    
    // Determinar si se debe mostrar la barra de navegación
    final bool showBottomNav = [
      '/home',
      '/explore',
      '/benefits',
      '/profile',
    ].any((route) => location.startsWith(route));
    
    // Si no es una ruta con barra de navegación, mostrar solo el contenido
    if (!showBottomNav) {
      return widget.child;
    }
    
    // Escuchar el estado de autenticación para ajustar la navegación
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        // Personalizar las etiquetas según el estado de autenticación
        final customLabels = [
          'Inicio', 
          'Explorar', 
          'Beneficios', 
          authState.status == AuthStatus.authenticated ? 'Perfil' : 'Acceder'
        ];
        
        final customIcons = const [
          '🏠', 
          '🔍', 
          '✨', 
          '👤'
        ];
        
        // Crear el scaffold principal con la barra de navegación
        return MainScaffold(
          body: widget.child,
          currentIndex: currentIndex,
          onTabChanged: (index) {
            // Verificar si la pestaña seleccionada requiere autenticación
            if (index == 3 && authState.status != AuthStatus.authenticated) {
              // La pestaña de perfil requiere autenticación
              // Se usa el método de AuthCubit para manejar la redirección
              final authCubit = context.read<AuthCubit>();
              authCubit.handleAuthRequiredFeature(context);
            } else {
              // Navegación normal para tabs que no requieren autenticación
              _handleTabChanged(index);
            }
          },
          labels: customLabels,
          icons: customIcons,
          // Las siguientes propiedades podrían personalizarse según la ruta
          showAppBar: false,
          primaryColor: kPrimaryColor,
        );
      },
    );
  }
}
