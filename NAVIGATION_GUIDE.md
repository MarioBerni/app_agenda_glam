# Guía de Navegación: Agenda Glam

**Propósito**: Esta guía explica el sistema de navegación de Agenda Glam, con enfoque en las transiciones circulares y patrones de implementación. Proporciona instrucciones paso a paso para implementar correctamente la navegación entre pantallas.

## Índice
1. [Introducción al Sistema de Navegación](#introducción-al-sistema-de-navegación)
2. [Componentes Clave](#componentes-clave)
3. [Implementación Paso a Paso](#implementación-paso-a-paso)
4. [Patrones y Casos de Uso](#patrones-y-casos-de-uso)
5. [Solución de Problemas](#solución-de-problemas)

## Introducción al Sistema de Navegación

Agenda Glam utiliza un sistema de navegación personalizado basado en `go_router` con transiciones circulares para proporcionar una experiencia de usuario fluida, coherente y visualmente atractiva. El sistema está diseñado con tres capas:

1. **Capa Base**: Utiliza `go_router` como framework de navegación declarativa
2. **Capa de Personalización**: Implementa `CirclePageRoute` para transiciones circulares
3. **Capa de Abstracción**: Proporciona `CircleNavigation` como punto centralizado para todas las navegaciones

Este enfoque por capas permite:
- **Coherencia visual** en toda la aplicación
- **Simplificación del código** de navegación para los desarrolladores
- **Mantenibilidad mejorada** al centralizar la lógica de navegación

## Componentes Clave

### CirclePageRoute

`CirclePageRoute` es una implementación personalizada de `PageRouteBuilder` que crea una transición circular expandiéndose desde un punto específico.

```dart
// lib/core/routes/circle_page_route.dart
class CirclePageRoute extends PageRouteBuilder {
  final Widget page;
  final Alignment alignment;
  final Color circleColor;

  CirclePageRoute({
    required this.page,
    required this.alignment,
    this.circleColor = Colors.black,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Implementación de la transición circular
            return _buildTransition(context, animation, child, alignment, circleColor);
          },
          transitionDuration: const Duration(milliseconds: 1100),
        );
        
  // Resto de la implementación...
}
```

### CircleNavigation

`CircleNavigation` es una clase utilitaria que proporciona métodos estáticos para todas las navegaciones comunes en la aplicación.

```dart
// lib/core/routes/circle_navigation.dart
class CircleNavigation {
  // Navegación hacia adelante (bottomLeft)
  static void goToLogin(BuildContext context) {
    context.pushCircle(const LoginPage());
  }
  
  static void goToRegister(BuildContext context) {
    context.pushCircle(const RegisterPage());
  }
  
  static void goToPhoneRegister(BuildContext context) {
    context.pushCircle(const PhoneRegisterPage());
  }
  
  // Nota: La navegación a ExplorePage desde WelcomePage ha sido eliminada
  // debido a la integración de elementos de exploración en la página de bienvenida
  
  // Navegación hacia atrás (bottomRight)
  static void goToWelcome(BuildContext context) {
    context.popCircle(const WelcomePage());
  }
  
  static void goBackToRegister(BuildContext context) {
    context.popCircle(const RegisterPage());
  }
  
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
