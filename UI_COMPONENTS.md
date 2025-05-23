# Catálogo de Componentes UI: Agenda Glam

**Propósito**: Catálogo de componentes UI reutilizables para Agenda Glam. Referencia técnica para mantener consistencia de diseño y facilitar el desarrollo.

## Índice
1. [Estándares de Diseño](#estándares-de-diseño)
2. [Componentes Globales](#componentes-globales)
3. [Componentes de Autenticación](#componentes-de-autenticación)
4. [Sistema de Navegación](#sistema-de-navegación)
5. [Patrones de Implementación](#patrones-de-implementación)

## Estándares de Diseño

### Espaciado y Estilos
- **Espaciado**: Encabezados (32px), elementos de formulario (16px estándar, 24px para separaciones mayores)
- **Estilos**: 
  - Tarjetas: No seleccionadas (negro semitransparente), seleccionadas (dorado semitransparente)
  - Botones: Fondo dorado (kAccentColor) con efecto shimmer
  - Campos: Fondo semitransparente con bordes redondeados

## Componentes Globales
Ubicados en `lib/core/widgets/`

### GlamScaffold
**Ubicación**: `glam_scaffold.dart`  
**Descripción**: Base unificada para todas las pantallas con fondo degradado y encabezado.  
**Props**: `title`, `subtitle`, `content`/`directContent`, `showBackButton`, `primaryColor`, `backgroundIntensity`

```dart
GlamScaffold(
  title: 'Mi Perfil',
  subtitle: 'Gestiona tu información personal',
  content: ProfileContent(),
)
```

### GlamGradientBackground
**Ubicación**: `glam_gradient_background.dart`  
**Descripción**: Fondo degradado con paleta de colores de la app.  
**Props**: `primaryColor`, `opacity`, `animateGradient`

### GlamDivider
**Ubicación**: `glam_divider.dart`  
**Descripción**: Separador visual con gradiente dorado.  
**Props**: `thickness`, `indent`, `endIndent`

### GlamTextField
**Ubicación**: `glam_text_field.dart`  
**Descripción**: Campo estilizado con validación y estado de error.  
**Props**: `controller`, `label`, `prefixIcon`, `isPassword`, `validator`, `errorText`, `onChanged`

### GlamIconContainer
**Ubicación**: `glam_icon_container.dart`  
**Descripción**: Contenedor circular para iconos con estilo visual consistente.  
**Props**: `icon`, `size`, `color`, `onTap`

## Componentes de Autenticación
Ubicados en `lib/features/auth/presentation/widgets/`

### GlamButton
**Ubicación**: `glam_button.dart`  
**Descripción**: Botón personalizado con múltiples estados y efectos.  
**Props**: `text`, `onPressed`, `isLoading`, `isFullWidth`, `isSecondary`, `icon`, `withShimmer`

### GlamLogo
**Ubicación**: `glam_logo.dart`  
**Descripción**: Logo con animación opcional y tamaños predefinidos.  
**Props**: `size` (small, medium, large), `withAnimation`

### GlamPasswordField
**Ubicación**: `glam_password_field.dart`  
**Descripción**: Campo para contraseñas con validación de fortaleza.  
**Props**: `controller`, `label`, `onChanged`, `validator`, `showStrengthIndicator`

### GlamVideoBackground
**Ubicación**: `glam_video_background.dart`  
**Descripción**: Video en loop como fondo con efecto de degradado.  
**Props**: `videoAsset`, `opacity`, `overlayColor`

### PasswordStrengthIndicator
**Ubicación**: `password_strength_indicator.dart`  
**Descripción**: Indicador visual de fortaleza de contraseña.  
**Props**: `password`, `showText`

### UserTypeSelector
**Ubicación**: `user_type_selector.dart`  
**Descripción**: Selector de rol (Propietario, Empleado, Cliente) con feedback visual.  
**Props**: `selectedType`, `onTypeSelected`, `types`

### GoogleRegisterInfoForm
**Ubicación**: `google_register_info_form.dart`  
**Descripción**: Formulario para información adicional tras autenticación con Google.  
**Props**: `userName`, `userEmail`, `phoneController`, `onSubmit`, `isLoading`, `isPhoneValid`, `onCancel`

### TermsCheckbox
**Ubicación**: `terms_checkbox.dart`  
**Descripción**: Checkbox estilizado para aceptar términos y condiciones con texto clickeable.  
**Props**: `isAccepted`, `onChanged`, `onTermsLinkTap`, `errorText`

### GlamTermsDialog
**Ubicación**: `glam_terms_dialog.dart`  
**Descripción**: Diálogo modal que muestra los términos y condiciones con animación de deslizamiento.  
**Props**: `onAccept`, `onClose`  
**Métodos Estáticos**: `show(BuildContext context)` - Muestra el diálogo con animación

## Patrones de Implementación

### Selección de Tipo de Usuario
- Sin selección por defecto para forzar elección consciente
- Estilo visual consistente con feedback claro mediante colores e iconos

### Términos y Condiciones
- Accesibles desde múltiples puntos de la aplicación (pantalla inicial y paso final de registro)
- Diálogo con animación de deslizamiento desde abajo para una experiencia visual fluida
- Validación explícita mediante checkbox para asegurar conformidad legal

### Validación de Entrada
- **Teléfono**: Mínimo 8 dígitos, solo numéricos
- **Contraseña**: Longitud mínima, combinación de caracteres, indicador visual
- **Términos**: Validación obligatoria con mensaje de error si no se aceptan
- **Email**: Validación mediante expresiones regulares

### Animaciones
Definidas en `lib/core/animations/animation_presets.dart`:
- **Entrada**: Fade + slide, duración 600ms, curva easeOutCubic
- **Presión**: Scale down + brightness change, duración 200ms
- **Shimmer**: Efecto de brillo con loop infinito

## Sistema de Navegación

Agenda Glam implementa un sistema de navegación personalizado con transiciones circulares para proporcionar una experiencia de usuario fluida y elegante.

### CirclePageRoute
**Ubicación**: `lib/core/routes/circle_page_route.dart`  
**Descripción**: Ruta personalizada que crea un efecto de círculo expandéndose para las transiciones.  
**Props**: `page`, `circleColor`, `alignment`

### CircleNavigation
**Ubicación**: `lib/core/routes/circle_navigation.dart`  
**Descripción**: Clase utilitaria que centraliza la navegación con transiciones circulares.  
**Métodos principales**:
- `goToWelcome`: Navega hacia atrás a la página de bienvenida (desde bottomRight)
- `goToLogin`: Navega hacia adelante a la página de inicio de sesión (desde bottomLeft)
- `goToRegister`: Navega hacia adelante a la página de registro (desde bottomLeft)
- `goToPhoneRegister`: Navega hacia adelante a la página de registro con teléfono (desde bottomLeft)
- `goBackToRegister`: Navega hacia atrás a la página de registro (desde bottomRight)
- `goBackFromGoogleAdditionalInfo`: Navega hacia atrás desde la página de información adicional de Google (desde bottomRight)
- `goBackFromPhoneAdditionalInfo`: Navega hacia atrás desde la página de información adicional de teléfono (desde bottomRight)

### Patrones de Navegación

- **Navegación hacia adelante**: El círculo se expande desde la esquina inferior izquierda (bottomLeft)
- **Navegación hacia atrás**: El círculo se expande desde la esquina inferior derecha (bottomRight)
- **Duración de transición**: 1100ms para una experiencia visual óptima

**Ejemplo de uso**:
```dart
// Navegación hacia adelante
CircleNavigation.goToLogin(context);

// Navegación hacia atrás
CircleNavigation.goToWelcome(context);

// Extensiones de contexto (alternativa)
context.pushCircle(const LoginPage()); // Hacia adelante
context.popCircle(const WelcomePage()); // Hacia atrás
```

### Mejores Prácticas
1. Mantener coherencia visual con la paleta definida
2. Preferir componentes pequeños sobre widgets monolíticos
3. Considerar accesibilidad (tamaños mínimos 48px)
4. Proporcionar feedback visual claro del estado actual

Para información detallada, consultar:
- `ARCHITECTURE.MD` - Sección 3.1 (Capa de Presentación)
- `PLANNING.MD` - Sección 3 (Diseño General y Tema)

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

7. **Navegación Consistente**:
   - Usar siempre `CircleNavigation` para transiciones entre páginas.
   - Mantener la dirección correcta de las animaciones: bottomLeft para avanzar, bottomRight para retroceder.
   - Evitar el uso directo de `Navigator.push()` o `Navigator.pop()` para mantener la experiencia visual coherente.
