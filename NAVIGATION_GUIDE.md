# Guía de Navegación: Agenda Glam - Sistema Modular

**Propósito**: Esta guía explica el sistema de navegación modular de Agenda Glam, basado en GoRouter con transiciones estandarizadas y una arquitectura modular por funcionalidades. Proporciona instrucciones para implementar correctamente la navegación entre pantallas y mantener un sistema coherente y escalable.

## Índice
1. [Introducción al Sistema de Navegación Modular](#introducción-al-sistema-de-navegación-modular)
2. [Estructura y Componentes](#estructura-y-componentes)
3. [Implementación de Nuevas Rutas](#implementación-de-nuevas-rutas)
4. [Transiciones de Página](#transiciones-de-página)
5. [Navegación en la Aplicación](#navegación-en-la-aplicación)
6. [Solución de Problemas](#solución-de-problemas)

## Introducción al Sistema de Navegación Modular

Agenda Glam utiliza un sistema de navegación modular basado en `go_router` con transiciones estandarizadas para proporcionar una experiencia de usuario coherente, mantenible y escalable. El sistema está diseñado siguiendo principios de modularidad y Clean Architecture:

1. **Centralización de Constantes**: Todas las rutas se definen como constantes en `app_routes.dart`
2. **Modularización por Características**: Las rutas se agrupan según su funcionalidad (auth, main, splash, etc.)
3. **Transiciones Estandarizadas**: Implementadas en `transitions_helpers.dart` para mantener consistencia
4. **Integración Central**: `app_router.dart` integra todas las rutas modularizadas

Este enfoque modular permite:
- **Mantenibilidad mejorada** al separar las rutas por funcionalidad
- **Cumplimiento del límite de 300 líneas** por archivo
- **Coherencia visual** gracias a transiciones estandarizadas
- **Escalabilidad** facilitando la adición de nuevas rutas

## Estructura y Componentes

El sistema de navegación modular se organiza siguiendo una estructura clara y modular:

```
lib/core/routes/
├── app_router.dart                # Integrador principal de todas las rutas
└── routes/
    ├── app_routes.dart          # Constantes de rutas centralizadas
    ├── transitions_helpers.dart  # Helpers para transiciones estandarizadas
    ├── auth_routes.dart         # Rutas de autenticación
    ├── main_routes.dart         # Rutas principales con barra de navegación
    └── splash_route.dart        # Ruta de splash screen
```

### app_routes.dart

`app_routes.dart` centraliza todas las constantes de rutas, evitando la duplicación de strings y facilitando el mantenimiento.

```dart
// lib/core/routes/routes/app_routes.dart
class AppRoutes {
  // Rutas de autenticación
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String recovery = '/recovery';
  
  // Rutas principales con barra de navegación
  static const String home = '/home';
  static const String explore = '/explore';
  static const String benefits = '/benefits';
  static const String profile = '/profile';
}
```

### transitions_helpers.dart

`transitions_helpers.dart` contiene implementaciones reutilizables de transiciones de página para mantener la coherencia visual en toda la aplicación.

```dart
// lib/core/routes/routes/transitions_helpers.dart
class TransitionsHelpers {
  // Transiciones estandarizadas como fade, fadeScale, slide
  static CustomTransitionPage buildFadeTransition({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }
  
  // Otras transiciones...
}
```

### auth_routes.dart

`auth_routes.dart` contiene todas las rutas relacionadas con la autenticación, agrupadas lógicamente.

```dart
// lib/core/routes/routes/auth_routes.dart
class AuthRoutes {
  /// Obtener todas las rutas de autenticación en una lista
  static List<RouteBase> getRoutes() {
    return [
      // Ruta de welcome (pantalla de inicio/bienvenida)
      GoRoute(
        path: AppRoutes.welcome,
        pageBuilder: (context, state) => TransitionsHelpers.buildFadeScaleTransition(
          context: context,
          state: state,
          child: const WelcomePage(),
        ),
      ),
      // Rutas de login, registro, recuperación...
    ];
  }
}
```

### main_routes.dart

`main_routes.dart` implementa un ShellRoute para manejar la navegación con tabs en la parte inferior:

```dart
// lib/core/routes/routes/main_routes.dart
class MainRoutes {
  /// Obtener el ShellRoute con todas las rutas principales
  static ShellRoute getShellRoute() {
    return ShellRoute(
      builder: (context, state, child) {
        return MainNavigator(child: child);
      },
      routes: [
        // Rutas dentro del shell (home, explore, benefits, profile)
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => TransitionsHelpers.buildFadeTransition(
            context: context,
            state: state,
            child: const HomePage(),
          ),
        ),
        // Otras rutas...
      ],
    );
  }
}
```

### app_router.dart

`app_router.dart` actúa como el integrador principal de todas las rutas modulares:

```dart
// lib/core/routes/app_router.dart
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    routes: [
      // Integra todas las rutas de módulos separados
      
      // 1. Ruta de splash screen (fuera del shell y auth)
      SplashRoute.getRoute(),
      
      // 2. Rutas de autenticación
      ...AuthRoutes.getRoutes(),
  
  static void goBackFromGoogleAdditionalInfo(BuildContext context) {
    context.popCircle(const RegisterPage());
  }
  
  static void goBackFromPhoneAdditionalInfo(BuildContext context) {
    context.popCircle(const PhoneRegisterPage());
  }
  
  // Otros métodos de navegación específicos...
}
```

### Extensiones de BuildContext

Las extensiones facilitan el uso de las transiciones circulares directamente desde el contexto.

```dart
// lib/core/extensions/context_extensions.dart
extension NavigationExtensions on BuildContext {
  // Navegación hacia adelante desde bottomLeft
  Future<T?> pushCircle<T>(Widget page) {
    return Navigator.of(this).push(
      CirclePageRoute(
        page: page,
        alignment: Alignment.bottomLeft,
      ),
    );
  }
  
  // Navegación hacia atrás desde bottomRight
  Future<T?> popCircle<T>(Widget page) {
    return Navigator.of(this).push(
      CirclePageRoute(
        page: page,
        alignment: Alignment.bottomRight,
      ),
    );
  }
}
```

## Implementación Paso a Paso

### 1. Añadir un Nuevo Método de Navegación

Si necesitas crear una nueva transición entre páginas, sigue estos pasos:

1. **Identificar el patrón de navegación**: ¿Es navegación hacia adelante o hacia atrás?
2. **Añadir un método en `CircleNavigation`**:

```dart
// Para navegación hacia adelante (desde bottomLeft)
static void goToNewFeaturePage(BuildContext context) {
  context.pushCircle(const NewFeaturePage());
}

// Para navegación hacia atrás (desde bottomRight)
static void goBackFromNewFeature(BuildContext context) {
  context.popCircle(const PreviousPage());
}
```

3. **Utilizar el método en el widget correspondiente**:

```dart
ElevatedButton(
  onPressed: () => CircleNavigation.goToNewFeaturePage(context),
  child: const Text('Ir a Nueva Característica'),
)
```

### 2. Implementar Navegación con Parámetros

Si necesitas pasar parámetros durante la navegación:

```dart
// En CircleNavigation
static void goToUserProfile(BuildContext context, String userId) {
  context.pushCircle(UserProfilePage(userId: userId));
}

// En el widget
CircleNavigation.goToUserProfile(context, '12345');
```

### 3. Manejar Navegación con Retorno de Datos

Para casos donde necesitas obtener un resultado de la página a la que navegas:

```dart
// En el widget que inicia la navegación
Future<void> _selectDate() async {
  final DateTime? selectedDate = await CircleNavigation.goToDatePicker(context);
  if (selectedDate != null) {
    // Usar la fecha seleccionada
  }
}

// En CircleNavigation
static Future<DateTime?> goToDatePicker(BuildContext context) async {
  return await context.pushCircle<DateTime>(const DatePickerPage());
}

// En DatePickerPage
ElevatedButton(
  onPressed: () => Navigator.of(context).pop(selectedDate),
  child: const Text('Confirmar'),
)
```

## Patrones y Casos de Uso

### Flujo de Registro

El flujo de registro utiliza varios patrones de navegación:

1. **Navegación Inicial**: De WelcomePage a RegisterPage
   ```dart
   CircleNavigation.goToRegister(context);
   ```

2. **Navegación a Métodos de Registro**: De RegisterPage a PhoneRegisterPage
   ```dart
   CircleNavigation.goToPhoneRegister(context);
   ```

3. **Navegación de Retorno**: De PhoneRegisterAdditionalInfoPage a PhoneRegisterPage
   ```dart
   CircleNavigation.goBackFromPhoneAdditionalInfo(context);
   ```

### Cambios en el Flujo de Exploración

**Nota Importante**: El flujo "Experimentar sin registro" ha sido eliminado debido a una decisión de diseño para simplificar la interfaz. Los elementos clave de la página de exploración ahora están integrados directamente en la página de bienvenida, eliminando la necesidad de navegación adicional.

**Implementación Actual**:
- El carrusel de socios se muestra directamente en la página de bienvenida
- Se ha eliminado la navegación a ExplorePage
- La página de bienvenida utiliza `SingleChildScrollView` para resolver problemas de desbordamiento

### Reglas Visuales

Para mantener una experiencia coherente:

1. **Navegación hacia adelante** (profundizando en la jerarquía):
   - Usar transiciones desde `bottomLeft`
   - Utilizar métodos `goTo...` en CircleNavigation

2. **Navegación hacia atrás** (regresando en la jerarquía):
   - Usar transiciones desde `bottomRight`
   - Utilizar métodos `goBackFrom...` en CircleNavigation

### Duración de las Transiciones

La duración estándar de las transiciones es de 1100ms, lo que proporciona un equilibrio entre una animación visible y una navegación eficiente. Esta duración está configurada en `CirclePageRoute` y no debe modificarse para mantener la coherencia.

## Solución de Problemas

### Pantalla Negra Durante la Transición

**Problema**: La pantalla se vuelve completamente negra durante la transición circular.

**Solución**: Asegúrate de que el `circleColor` en `CirclePageRoute` coincida con el color de fondo de tu aplicación o pantalla.

### Resolución de Problemas de Desbordamiento

**Problema**: La interfaz presenta errores de desbordamiento ("RenderFlex overflowed") en ciertas pantallas.

**Solución**: Utiliza `SingleChildScrollView` como contenedor principal para permitir el desplazamiento del contenido cuando sea necesario. Esto se ha implementado en la página de bienvenida para resolver el problema de desbordamiento de 26 píxeles.

### Dirección Incorrecta de la Animación

**Problema**: La animación se expande desde la dirección incorrecta.

**Solución**: Verifica que estás utilizando el método correcto:
- `context.pushCircle()` para navegación hacia adelante (desde bottomLeft)
- `context.popCircle()` para navegación hacia atrás (desde bottomRight)

### Conflictos con GoRouter

**Problema**: Las transiciones circulares no funcionan cuando se usa GoRouter directamente.

**Solución**: Evita mezclar llamadas directas a GoRouter con el sistema de transiciones circulares. Usa siempre los métodos de `CircleNavigation` o las extensiones de contexto para mantener la coherencia.

---

## Mejores Prácticas

1. **Centralizar la Navegación**: Siempre añade nuevos métodos de navegación a `CircleNavigation` en lugar de implementar la lógica de navegación directamente en los widgets.

2. **Consistencia Visual**: Mantén la coherencia visual utilizando `bottomLeft` para navegación hacia adelante y `bottomRight` para navegación hacia atrás.

3. **Nombres Descriptivos**: Utiliza nombres descriptivos para los métodos de navegación que indiquen claramente el destino y el origen.

4. **Documentación**: Documenta cualquier nuevo método de navegación con comentarios `///` que expliquen su propósito y uso.

5. **Pruebas**: Implementa pruebas para verificar que las transiciones funcionan correctamente y mantienen la coherencia visual.

---

**Referencia Rápida**:

| Acción | Método Recomendado | Dirección |
|--------|-------------------|-----------|
| Ir a una nueva pantalla | `CircleNavigation.goToScreen(context)` | bottomLeft |
| Volver a una pantalla anterior | `CircleNavigation.goBackFromScreen(context)` | bottomRight |
| Navegación directa (uso avanzado) | `context.pushCircle(Widget)` | bottomLeft |
| Navegación atrás directa (uso avanzado) | `context.popCircle(Widget)` | bottomRight |

---

**Recursos Adicionales**:
- Consulta `ARCHITECTURE.MD` para entender cómo el sistema de navegación se integra con la arquitectura general.
- Revisa `UI_COMPONENTS.md` para detalles sobre los componentes de UI relacionados con la navegación.
- Examina el código fuente en `lib/core/routes/` para una comprensión más profunda.
