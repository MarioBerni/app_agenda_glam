# Catálogo de Componentes UI: Agenda Glam

**Propósito**: Este documento cataloga y describe los componentes de interfaz de usuario reutilizables disponibles en el proyecto Agenda Glam. Sirve como referencia visual y técnica para mantener la consistencia de diseño y facilitar el desarrollo de nuevas pantallas.

## Índice

1. [Estándares de Diseño](#estándares-de-diseño)
   - [Espaciado Estándar](#espaciado-estándar)
   - [Estilos Visuales](#estilos-visuales)
2. [Componentes Principales](#componentes-principales)
   - [Componentes Globales](#componentes-globales)
   - [Componentes de Autenticación](#componentes-de-autenticación)
3. [Patrones de Implementación](#patrones-de-implementación)
   - [Selección de Tipo de Usuario](#selección-de-tipo-de-usuario)
   - [Validación de Entrada](#validación-de-entrada)
4. [Mejores Prácticas](#mejores-prácticas)

---

## Estándares de Diseño

### Espaciado Estándar

Para mantener una coherencia visual en toda la aplicación, se han establecido los siguientes estándares de espaciado:

- **Espaciado después del encabezado unificado**: 32px en todas las páginas de autenticación
- **Espaciado entre elementos de formulario**: 16px estándar, 24px para separaciones mayores
- **Espaciado interno de tarjetas**: padding vertical de 16px, horizontal según contexto

Este espaciado consistente mejora la experiencia visual y facilita el mantenimiento del código.

### Estilos Visuales

Los componentes siguen estos patrones de estilo estandarizados:

- **Tarjetas seleccionables**: Fondo negro semitransparente (alpha 0.3) cuando no están seleccionadas, fondo dorado semitransparente (kAccentColor con alpha 0.15) cuando están seleccionadas
- **Botones de acción**: Fondo amarillo dorado (kAccentColor) con efecto shimmer
- **Campos de texto**: Fondo semitransparente con bordes redondeados y efectos de foco

---

## Componentes Principales

### Organización de Componentes

- **Componentes Globales**: `lib/core/widgets/` - Utilizables en toda la aplicación
- **Componentes de Feature**: `lib/features/<feature>/presentation/widgets/` - Específicos para cada funcionalidad

### Componentes Globales

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

### UserTypeSelector

**Ubicación**: `lib/features/auth/presentation/widgets/user_type_selector.dart`

**Descripción**: Componente que permite al usuario seleccionar su rol en el sistema (Propietario, Empleado o Cliente) mediante botones con iconos y texto. Muestra visualmente la opción seleccionada con cambio de color y borde.

**Propiedades clave**:
- `selectedType`: Tipo de usuario actualmente seleccionado.
- `onTypeSelected`: Función llamada cuando se selecciona un tipo de usuario.
- `types`: Lista de tipos de usuario disponibles (por defecto: Propietario, Empleado, Cliente).

**Ejemplo de uso**:
```dart
UserTypeSelector(
  selectedType: _userType,
  onTypeSelected: (type) {
    setState(() {
      _userType = type;
    });
  },
)
```

### GoogleRegisterInfoForm

**Ubicación**: `lib/features/auth/presentation/widgets/google_register_info_form.dart`

**Descripción**: Formulario especializado para recopilar información adicional después de la autenticación con Google. Solicita el tipo de usuario y número de teléfono, proporcionando validación en tiempo real y feedback visual.

**Propiedades clave**:
- `userName`: Nombre del usuario obtenido de Google.
- `userEmail`: Email del usuario obtenido de Google.
- `phoneController`: Controlador para el campo de teléfono con validación en tiempo real.
- `onSubmit`: Función que se ejecuta al enviar el formulario, recibe tipo de usuario y teléfono.
- `isLoading`: Indica si el formulario está en estado de carga.
- `isPhoneValid`: Indicador de validez del teléfono en tiempo real.
- `onCancel`: Función para cancelar el proceso y volver a la pantalla anterior.

**Ejemplo de uso**:
```dart
GoogleRegisterInfoForm(
  userName: "Mario Berni",
  userEmail: "mario.berni@gmail.com",
  phoneController: _phoneController,
  isPhoneValid: _isPhoneValid,
  phoneError: _phoneError,
  isLoading: _isLoading,
  onSubmit: (userType, phone) {
    // Procesar la información adicional
  },
  onCancel: () => CircleNavigation.goToWelcome(context),
)
```

---

## Patrones de Implementación

### Selección de Tipo de Usuario

**Descripción**: Implementación estandarizada para la selección del rol del usuario (Propietario, Empleado, Cliente).

**Características clave**:
- Sin selección por defecto para forzar una elección consciente del usuario
- Estilo visual consistente en todas las páginas (fondo negro semitransparente para opciones no seleccionadas)
- Retroalimentación visual clara mediante colores e iconos

**Implementación simplificada**:
```dart
UserTypeSelector(
  selectedUserType: userType,  // Tipo null inicialmente (sin selección por defecto)
  onUserTypeSelected: updateUserType,
)
```

### Validación de Entrada

**Descripción**: Sistema unificado de validación para todos los campos de entrada, con retroalimentación visual inmediata.

**Reglas estándar**:
- **Teléfono**: Mínimo 8 dígitos, solo caracteres numéricos
- **Contraseña**: Longitud mínima, combinación de caracteres, indicador visual de fortaleza
- **Email**: Formato válido mediante expresiones regulares
  keyboardType: TextInputType.phone,
  validator: RegisterValidator.validatePhone,
  errorText: phoneError,
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
