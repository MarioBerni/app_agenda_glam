# Guía de Componentes UI: Agenda Glam

Esta documentación proporciona una descripción detallada de los componentes UI reutilizables disponibles en el proyecto Agenda Glam. Utiliza esta guía como referencia para mantener la consistencia visual y funcional en toda la aplicación.

## Índice

1. [Estructura y Organización](#estructura-y-organización)
2. [Componentes Globales](#componentes-globales)
   - [GlamScaffold](#glamscaffold)
   - [GlamGradientBackground](#glamgradientbackground)
   - [GlamDivider](#glamdivider)
   - [GlamTextField](#glamtextfield)
   - [GlamIconContainer](#glamiconcontainer)
3. [Componentes de Autenticación](#componentes-de-autenticación)
   - [GlamButton](#glambutton)
   - [GlamLogo](#glamlogo)
   - [GlamPasswordField](#glampasswordfield)
   - [GlamVideoBackground](#glamvideobackground)
   - [PasswordStrengthIndicator](#passwordstrengthindicator)
4. [Patrones de Animación](#patrones-de-animación)
5. [Mejores Prácticas](#mejores-prácticas)

---

## Estructura y Organización

Los componentes UI de Agenda Glam están organizados siguiendo estos principios:

1. **Componentes Globales**: Ubicados en `lib/core/widgets/`, son utilizables en toda la aplicación.
2. **Componentes de Feature**: Ubicados en `lib/features/<feature>/presentation/widgets/`, específicos para cada funcionalidad.

Esta estructura refleja la arquitectura modular del proyecto y facilita la reutilización de código.

---

## Componentes Globales

### GlamScaffold

**Ubicación**: `lib/core/widgets/glam_scaffold.dart`

**Descripción**: Scaffold base unificado para todas las pantallas de la aplicación. Proporciona una estructura visual consistente con fondo degradado, encabezado con título/subtítulo, y soporte para contenido personalizado.

**Propiedades clave**:
- `title`: Título principal de la pantalla.
- `subtitle`: Subtítulo descriptivo opcional.
- `content`: Contenido principal que se mostrará con el encabezado estándar.
- `directContent`: Contenido directo sin el encabezado estándar (no puede usarse simultáneamente con `content`).
- `showBackButton`: Controla la visibilidad del botón de retroceso.
- `primaryColor`: Color primario para el fondo degradado.
- `backgroundIntensity`: Intensidad del efecto de fondo (0.0-1.0).
- `resizeToAvoidBottomInset`: Controla si el scaffold se redimensiona al aparecer el teclado.

**Ejemplo de uso**:
```dart
// Con encabezado estándar
GlamScaffold(
  title: 'Mi Perfil',
  subtitle: 'Gestiona tu información personal',
  content: ProfileContent(),
)

// Con contenido personalizado
GlamScaffold(
  directContent: CustomLoginScreen(),
  resizeToAvoidBottomInset: true,
)
```

### GlamGradientBackground

**Ubicación**: `lib/core/widgets/glam_gradient_background.dart`

**Descripción**: Proporciona un fondo degradado consistente con la paleta de colores de la aplicación. Utilizado por GlamScaffold para generar el fondo visual de todas las pantallas.

**Propiedades clave**:
- `primaryColor`: Color base para el degradado.
- `opacity`: Opacidad/intensidad del degradado (0.0-1.0).
- `animateGradient`: Habilita animación sutil del degradado.

**Ejemplo de uso**:
```dart
Stack(
  children: [
    GlamGradientBackground(
      primaryColor: kPrimaryColorDark,
      opacity: 0.7,
    ),
    // Otros widgets sobre el fondo...
  ],
)
```

### GlamDivider

**Ubicación**: `lib/core/widgets/glam_divider.dart`

**Descripción**: Separador visual con gradiente dorado, usado para delimitar secciones de contenido.

**Propiedades clave**:
- `thickness`: Grosor del divisor.
- `indent`: Sangría desde el inicio.
- `endIndent`: Sangría desde el final.

**Ejemplo de uso**:
```dart
Column(
  children: [
    HeaderSection(),
    GlamDivider(),
    ContentSection(),
  ],
)
```

### GlamTextField

**Ubicación**: `lib/core/widgets/glam_text_field.dart`

**Descripción**: Campo de texto estilizado con etiqueta flotante, soporte para validación y estado de error. Proporciona una experiencia de entrada de texto consistente en toda la aplicación.

**Propiedades clave**:
- `controller`: Controlador de texto.
- `label`: Etiqueta del campo.
- `prefixIcon`: Icono previo al texto.
- `isPassword`: Determina si el campo debe ocultar el texto.
- `validator`: Función de validación.
- `errorText`: Texto de error directo.
- `onChanged`: Función llamada cuando cambia el texto.

**Ejemplo de uso**:
```dart
GlamTextField(
  controller: emailController,
  label: 'Correo electrónico',
  prefixIcon: Icons.email,
  keyboardType: TextInputType.emailAddress,
  validator: (value) {
    if (!value!.contains('@')) return 'Email inválido';
    return null;
  },
  onChanged: (value) => print('Valor actual: $value'),
)
```

### GlamIconContainer

**Ubicación**: `lib/core/widgets/glam_icon_container.dart`

**Descripción**: Contenedor circular para iconos con estilo visual consistente. Útil para botones de acción, indicadores o elementos decorativos.

**Propiedades clave**:
- `icon`: El icono a mostrar.
- `size`: Tamaño del contenedor.
- `color`: Color principal del contenedor.
- `onTap`: Función llamada al tocar.

**Ejemplo de uso**:
```dart
GlamIconContainer(
  icon: Icons.add,
  size: 48,
  onTap: () => handleAddAction(),
)
```

---

## Componentes de Autenticación

### GlamButton

**Ubicación**: `lib/features/auth/presentation/widgets/glam_button.dart`

**Descripción**: Botón personalizado con múltiples estados (normal, carga, deshabilitado) y efectos visuales (hover, presión, shimmer). Soporta modo primario (fondo dorado) y secundario (outline).

**Propiedades clave**:
- `text`: Texto del botón.
- `onPressed`: Acción a ejecutar.
- `isLoading`: Muestra indicador de carga.
- `isFullWidth`: Extiende el botón al ancho completo.
- `isSecondary`: Aplica estilo secundario (outline).
- `icon`: Icono opcional junto al texto.
- `withShimmer`: Activa efecto de brillo animado.

**Ejemplo de uso**:
```dart
GlamButton(
  text: 'Iniciar Sesión',
  onPressed: () => loginUser(),
  isLoading: isAuthenticating,
  icon: Icons.login,
)

GlamButton(
  text: 'Cancelar',
  onPressed: () => cancelAction(),
  isSecondary: true,
)
```

### GlamLogo

**Ubicación**: `lib/features/auth/presentation/widgets/glam_logo.dart`

**Descripción**: Componente para mostrar el logo de Agenda Glam con animación opcional. Proporciona diferentes tamaños predefinidos.

**Propiedades clave**:
- `size`: Tamaño del logo (small, medium, large).
- `withAnimation`: Activa animación de entrada.

**Ejemplo de uso**:
```dart
GlamLogo(
  size: LogoSize.medium,
  withAnimation: true,
)
```

### GlamPasswordField

**Ubicación**: `lib/features/auth/presentation/widgets/glam_password_field.dart`

**Descripción**: Campo especializado para contraseñas con validación de fortaleza e indicador visual.

**Propiedades clave**:
- `controller`: Controlador de texto.
- `label`: Etiqueta del campo.
- `onChanged`: Función llamada cuando cambia el texto.
- `validator`: Función de validación.
- `showStrengthIndicator`: Muestra el indicador de fortaleza.

**Ejemplo de uso**:
```dart
GlamPasswordField(
  controller: passwordController,
  label: 'Contraseña',
  showStrengthIndicator: true,
  validator: (value) => validatePassword(value),
)
```

### GlamVideoBackground

**Ubicación**: `lib/features/auth/presentation/widgets/glam_video_background.dart`

**Descripción**: Reproduce un video en loop como fondo con efecto de degradado. Mejora la experiencia visual en pantallas de bienvenida y login.

**Propiedades clave**:
- `videoAsset`: Ruta al video.
- `opacity`: Opacidad del video.
- `overlayColor`: Color de superposición.

**Ejemplo de uso**:
```dart
Stack(
  children: [
    GlamVideoBackground(
      videoAsset: 'assets/videos/background.mp4',
      opacity: 0.6,
    ),
    // Contenido sobre el video...
  ],
)
```

### PasswordStrengthIndicator

**Ubicación**: `lib/features/auth/presentation/widgets/password_strength_indicator.dart`

**Descripción**: Indicador visual que muestra la fortaleza de una contraseña con barras de color y texto descriptivo.

**Propiedades clave**:
- `password`: La contraseña a evaluar.
- `showText`: Muestra texto descriptivo.

**Ejemplo de uso**:
```dart
Column(
  children: [
    GlamPasswordField(
      controller: passwordController,
      label: 'Contraseña',
    ),
    PasswordStrengthIndicator(
      password: passwordController.text,
      showText: true,
    ),
  ],
)
```

---

## Patrones de Animación

### Animaciones de Componentes

Los componentes utilizan patrones de animación consistentes definidos en `lib/core/animations/animation_presets.dart`. Las principales animaciones incluyen:

1. **Entrada (Entry)**: Aparición con fade y ligero desplazamiento.
2. **Pulso (Pulse)**: Efecto de pulso para llamar la atención.
3. **Shimmer**: Efecto de brillo que se desplaza por un componente.

Ejemplo de uso de animaciones:
```dart
// Aplicar animación de entrada
myWidget.glamEntry(
  duration: GlamAnimations.defaultDuration,
  delay: Duration(milliseconds: 200),
)

// Aplicar animación de pulso
myWidget.glamPulse()
```

### Sistema de Transiciones Circulares

**Ubicación**: `lib/core/routes/circle_page_route.dart` y `lib/core/routes/circle_navigation.dart`

**Descripción**: Sistema centralizado de transiciones de página que crea un efecto visual de círculo expandiéndose para revelar la nueva pantalla. El sistema usa una dirección contextual para mejorar la orientación del usuario: el círculo se expande desde abajo a la izquierda al avanzar y desde abajo a la derecha al retroceder.

**Componentes clave**:

1. **CirclePageRoute**: Implementa la transición personalizada con animación y clipper circular.
   - Propiedades: `page` (widget a mostrar), `alignment` (punto desde donde se expande)
   - Duración: 1200ms para una transición visualmente apreciable

2. **CircleNavigation**: Clase utilitaria que centraliza todas las navegaciones de la aplicación.
   - Métodos: `goToLogin()`, `goToRegister()`, `goToWelcome()`, etc.
   - Determina automáticamente si usar expansión desde bottomLeft (avanzar) o bottomRight (retroceder)

**Ejemplo de uso**:
```dart
// Navegación hacia adelante (expandir desde bottomLeft)
CircleNavigation.goToLogin(context);

// Navegación hacia atrás (expandir desde bottomRight)
CircleNavigation.goToWelcome(context);
```

---

## Mejores Prácticas

1. **Evitar Duplicación**: Si un componente UI se repite en múltiples features, considere moverlo a `core/widgets/`.

2. **Nomenclatura Consistente**: 
   - Prefijo `Glam` para componentes base.
   - Nombres descriptivos sobre el propósito (ej: `PasswordStrengthIndicator`).

3. **Documentación Completa**:
   - Siempre incluir comentarios `///` para documentar clases y propiedades.
   - Proporcionar ejemplos de uso en la documentación.

4. **Composición sobre Herencia**:
   - Preferir componer widgets pequeños para crear componentes más complejos.
   - Facilita la testabilidad y mantenimiento.

5. **Límite de Tamaño**:
   - Adherirse al límite de 300 líneas por archivo.
   - Refactorizar componentes grandes en sub-componentes.

6. **Consistencia Visual**:
   - Utilizar constantes de tema desde `app_theme_constants.dart`.
   - Mantener coherencia en espaciados, radios y sombras.
