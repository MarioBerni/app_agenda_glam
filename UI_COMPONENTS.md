# Catálogo de Componentes UI: Agenda Glam

**Propósito**: Catálogo de componentes UI reutilizables para Agenda Glam. Referencia técnica para mantener consistencia de diseño y facilitar el desarrollo.

## Índice
1. [Estándares de Diseño](#estándares-de-diseño)
2. [Componentes Globales](#componentes-globales)
3. [Componentes de Autenticación](#componentes-de-autenticación)
4. [Patrones de Implementación](#patrones-de-implementación)

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

## Patrones de Implementación

### Selección de Tipo de Usuario
- Sin selección por defecto para forzar elección consciente
- Estilo visual consistente con feedback claro mediante colores e iconos

### Validación de Entrada
- **Teléfono**: Mínimo 8 dígitos, solo numéricos
- **Contraseña**: Longitud mínima, combinación de caracteres, indicador visual
- **Email**: Validación mediante expresiones regulares

### Animaciones
Definidas en `lib/core/animations/animation_presets.dart`:
- **Entrada**: Fade + slide, duración 600ms, curva easeOutCubic
- **Presión**: Scale down + brightness change, duración 200ms
- **Shimmer**: Efecto de brillo con loop infinito

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
