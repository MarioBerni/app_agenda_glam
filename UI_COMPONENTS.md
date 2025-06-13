# Catálogo de Componentes UI: Agenda Glam

**Propósito**: Catálogo de componentes UI reutilizables para Agenda Glam. Referencia técnica para mantener consistencia de diseño y facilitar el desarrollo.

## Índice
1. [Estándares de Diseño](#estándares-de-diseño)
2. [Lista de Componentes](#lista-de-componentes)
   - [Componentes Globales](#componentes-globales)
   - [Componentes de Bienvenida](#componentes-de-bienvenida)
   - [Componentes de Autenticación](#componentes-de-autenticación)
3. [Sistema de Navegación](#sistema-de-navegación)
4. [Patrones de Implementación](#patrones-de-implementación)

## Estándares de Diseño

### Espaciado y Estilos
- **Espaciado**: Encabezados (32px), elementos de formulario (16px estándar, 24px para separaciones mayores)
- **Estilos**: 
  - Tarjetas: No seleccionadas (negro semitransparente), seleccionadas (dorado semitransparente)
  - Botones: Fondo dorado (kAccentColor) con efecto shimmer
  - Campos: Fondo semitransparente con bordes redondeados

### Proporciones y Layout
- **Carruseles**: Tarjetas con viewportFraction de 0.75 y proporciones más cuadradas para imágenes
- **Scroll**: Uso de SingleChildScrollView para evitar problemas de desbordamiento
- **Modularidad**: Componentes de UI divididos en widgets pequeños y reutilizables

## Lista de Componentes

### Componentes Globales

Estos componentes pueden utilizarse en cualquier parte de la aplicación y están ubicados en `lib/core/widgets/`.  

| Componente | Ubicación | Descripción | Uso | 
|------------|-----------|-------------|-----|  
| **GlamScaffold** | `lib/core/widgets/glam_scaffold.dart` | Base unificada para todas las pantallas con fondo degradado y encabezado | `GlamScaffold(title: 'Mi Perfil', subtitle: 'Información personal', content: ProfileContent())` |
| **GlamGradientBackground** | `lib/core/widgets/glam_gradient_background.dart` | Fondo degradado con paleta de colores de la app | `GlamGradientBackground(primaryColor: kPrimaryColor, opacity: 0.9)` |
| **GlamDivider** | `lib/core/widgets/glam_divider.dart` | Separador visual con gradiente dorado | `GlamDivider(widthFactor: 0.8, primaryOpacity: 0.5, animate: true)` |
| **GlamTextField** | `lib/core/widgets/glam_text_field.dart` | Campo estilizado con validación y estado de error | `GlamTextField(controller: _emailCtrl, label: 'Email', prefixIcon: Icons.email)` |
| **GlamIconContainer** | `lib/core/widgets/glam_icon_container.dart` | Contenedor circular para iconos con estilo consistente | `GlamIconContainer(icon: Icons.content_cut_rounded, size: 90, enableShimmer: true)` |
| **GlamButton** | `lib/features/auth/presentation/widgets/glam_button.dart` | Botón estilizado con estados de carga y efectos visuales | `GlamButton(label: 'Continuar', onPressed: _handleSubmit, isLoading: _isLoading)` |
| **GlamLogo** | `lib/features/auth/presentation/widgets/glam_logo.dart` | Logo con animación opcional y tamaños predefinidos | `GlamLogo(size: GlamLogoSize.large, withAnimation: true)` |

### Componentes de Bienvenida

Componentes específicos para la página de bienvenida, ubicados en `lib/features/auth/presentation/widgets/welcome_components/`.  

| Componente | Ubicación | Descripción | Uso | 
|------------|-----------|-------------|-----|  
| **WelcomeHeader** | `lib/features/auth/presentation/widgets/welcome_components/welcome_header.dart` | Muestra logo y branding con efecto de brillo | `const WelcomeHeader()` |
| **WelcomeHeaderSection** | `lib/features/auth/presentation/widgets/welcome_components/welcome_header_section.dart` | Sección de título y subtítulo para la página de bienvenida (sin botón de retorno) | `const WelcomeHeaderSection()` |
| **AuthButtons** | `lib/features/auth/presentation/widgets/welcome_components/auth_buttons.dart` | Botones de inicio de sesión y registro con estados de carga | `AuthButtons(onLoginPressed: _handleLogin, isLoginLoading: _isLoginLoading, onRegisterPressed: _handleRegister, isRegisterLoading: _isRegisterLoading)` |
| **ExploreButton** | `lib/features/auth/presentation/widgets/welcome_components/explore_button.dart` | Botón para explorar sin cuenta con indicador de carga | `ExploreButton(onExplorePressed: _handleExplore, isLoading: _isExploreLoading)` |
| **FeaturedPartnersSection** | `lib/features/auth/presentation/widgets/welcome_components/featured_partners_section.dart` | Carrusel de socios destacados | `const FeaturedPartnersSection()` |
| **ActionCard** | `lib/features/auth/presentation/widgets/action_card.dart` | Tarjeta informativa con botones de acción | `ActionCard(parallaxController: _controller)` |

### Componentes de Autenticación

Componentes utilizados en las páginas de login, registro y recuperación de contraseña, ubicados en `lib/features/auth/presentation/widgets/`.  

| Componente | Ubicación | Descripción | Uso | 
|------------|-----------|-------------|-----|  
| **GlamPasswordField** | `lib/features/auth/presentation/widgets/glam_password_field.dart` | Campo estilizado para contraseñas con interruptor de visibilidad y validación | `GlamPasswordField(controller: _passwordCtrl, label: 'Contraseña', onChanged: _validatePassword)` |
| **TermsCheckbox** | `lib/features/auth/presentation/widgets/terms_checkbox.dart` | Checkbox para aceptar términos con texto clickeable | `TermsCheckbox(isAccepted: _termsAccepted, onChanged: (val) => setState(() => _termsAccepted = val), onTermsLinkTap: _showTerms)` |
| **GlamTermsDialog** | `lib/features/auth/presentation/widgets/glam_terms_dialog.dart` | Diálogo modal de términos y condiciones | `GlamTermsDialog.show(context, onAccept: _acceptTerms, onReject: _rejectTerms)` |
| **PasswordStrengthIndicator** | `lib/features/auth/presentation/widgets/password_strength_indicator.dart` | Indicador visual de fortaleza de contraseña | `PasswordStrengthIndicator(password: _password, showSuggestions: true)` |
| **LoginForm** | `lib/features/auth/presentation/widgets/login_form.dart` | Formulario completo de inicio de sesión | `LoginForm(onLogin: _handleLogin, isLoading: _isLoading)` |
| **RegisterForm** | `lib/features/auth/presentation/widgets/register_form.dart` | Formulario completo de registro | `RegisterForm(onRegister: _handleRegister, isLoading: _isLoading)` |
| **SocialLoginButtons** | `lib/features/auth/presentation/widgets/social_login_buttons.dart` | Botones de inicio de sesión social | `SocialLoginButtons(onGoogleLogin: _handleGoogleLogin, onAppleLogin: _handleAppleLogin)` |

### Animaciones y Efectos

Agenda Glam cuenta con un sistema de animaciones estandarizado para proporcionar una experiencia de usuario fluida y consistente.

| Animación | Ubicación | Descripción | Uso | 
|------------|-----------|-------------|-----|  
| **GlamAnimations.applyEntryEffect** | `lib/core/animations/animation_presets.dart` | Anima la entrada de widgets con fade + slide | `GlamAnimations.applyEntryEffect(myWidget, slideDistance: 0.25)` |
| **GlamAnimations.applyPressEffect** | `lib/core/animations/animation_presets.dart` | Efecto de presión (scale down + brillo) | `GlamAnimations.applyPressEffect(myButton)` |
| **GlamAnimations.applyShimmerEffect** | `lib/core/animations/animation_presets.dart` | Efecto de brillo con animación infinita | `GlamAnimations.applyShimmerEffect(myWidget, baseColor: kAccentColor)` |
| **FeaturedCarousel** | `lib/core/animations/carousel.dart` | Carrusel animado para destacados | `FeaturedCarousel(children: [widget1, widget2], autoScrollDuration: 5)` |

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

---

## Actualización del Catálogo de Componentes

Este catálogo es un documento vivo que debe actualizarse cuando se creen nuevos componentes reutilizables o se modifiquen los existentes. Para mantenerlo actualizado, sigue estas directrices:

### Cuándo actualizar este catálogo

1. **Al crear un nuevo componente reutilizable**: Añade inmediatamente la documentación siguiendo el formato establecido.
2. **Al modularizar componentes existentes**: Como hicimos con los componentes de la página de bienvenida.
3. **Al deprecar o eliminar componentes**: Marca claramente qué componentes ya no están en uso.
4. **Al mejorar la API de un componente**: Actualiza la documentación para reflejar los nuevos parámetros o comportamientos.

### Cómo documentar un nuevo componente

1. **Identifica la categoría adecuada** o crea una nueva si es necesario.
2. **Sigue el formato tabular establecido** con columnas para Componente, Ubicación, Descripción y Uso.
3. **Usa ejemplos de código concretos** que muestren casos de uso comunes.
4. **Menciona dependencias o relaciones** con otros componentes si existen.

### Buenas prácticas

- **Mantener ejemplos actualizados**: Asegurar que los ejemplos de uso reflejen la API actual.
- **Documentación completa pero concisa**: Incluir toda la información relevante sin extenderse innecesariamente.
- **Referencias cruzadas**: Vincular componentes relacionados entre sí mediante referencias internas.
- **Organizar por frecuencia de uso**: Los componentes más utilizados deben aparecer primero en sus respectivas secciones.

Recuerda que una buena documentación facilita la reutilización, reduce la duplicación de código y mantiene la coherencia visual de toda la aplicación.
