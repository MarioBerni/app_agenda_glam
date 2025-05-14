# Tarea: Refinamiento de Diseño del Flujo de Autenticación

Este archivo detalla las tareas necesarias para refinar y mejorar el diseño visual del flujo de autenticación en "Agenda Glam", asegurando una experiencia de usuario premium y consistente con la identidad de marca.

## Objetivos:

- Crear una experiencia visual distintiva y memorable para el proceso de autenticación
- Implementar animaciones y transiciones fluidas entre pantallas
- Reforzar la identidad masculina y elegante de la marca
- Mejorar la usabilidad y accesibilidad de los formularios
- Asegurar consistencia visual en todos los dispositivos

## Bibliotecas Seleccionadas:

- [X] **Configuración de Dependencias en pubspec.yaml:**
  - [X] flutter_animate: ^4.2.0 (o última versión) - Animaciones fluidas y efectos visuales
  - [X] flutter_svg: ^2.0.7 (o última versión) - Manejo de iconos vectoriales
  - [X] video_player: ^2.7.2 (o última versión) - Reproducción de videos de fondo
  - [X] go_router_plus: ^4.1.1 (última compatible con go_router 6.5.9) - Transiciones de página

## Pantallas a Refinar:

### 1. Pantalla de Bienvenida/Splash:

- [X] **Diseño de Logo y Animación:**
  - [X] Crear animación de entrada para el logo (fade-in, escalado suave)
  - [X] Implementar transición elegante hacia la pantalla de selector (bienvenida)
  - [X] Añadir efecto de brillo periódico usando flutter_animate

- [X] **Fondo Visual:**
  - [X] Diseñar un fondo que combine degradados de la paleta azul (kPrimaryColor → kBackgroundColor)
  - [X] Añadir elementos visuales abstractos relacionados con la estética masculina (formas geométricas minimalistas)
  - [X] Implementar efecto parallax sutil para movimiento del fondo
  - [X] **Implementar video de fondo con degradado** ✨ **NUEVO:**
    - [X] Crear componente GlamVideoBackground reutilizable
    - [X] Integrar reproducción automática de video con efecto degradado
    - [X] Optimizar rendimiento (sin audio, manejo adecuado del ciclo de vida)
    - [X] Mantener compatibilidad con el efecto parallax existente

### 2. Pantalla de Selección (Bienvenida):

- [X] **Layout Premium:**
  - [X] Diseñar encabezado con logo de la app y eslogan breve
  - [X] Crear elementos visuales representativos del servicio
  - [X] Implementar botones principales con efectos visuales al pulsar

- [X] **Animaciones de Transición:**
  - [X] Diseñar animaciones de hero para transiciones a Login/Registro
  - [X] Implementar animaciones de estado para botones (hover, pressed)
  - [X] Añadir micro-interacciones para mejorar sensación de respuesta

### 3. Pantalla de Inicio de Sesión:

- [X] **Estructura Visual Mejorada con flutter_animate:** ✅ **COMPLETADO**
  - [X] Diseñar encabezado con animación sutil de retorno a la pantalla anterior
  - [X] Implementar campos de texto con iconos personalizados y efectos de foco
  - [X] Crear botón de inicio de sesión con secuencia de animaciones usando flutter_animate
  - [X] Añadir opción "Recordarme" con interruptor estilizado

- [X] **Elementos Visuales Adicionales:**
  - [X] Diseñar separador elegante para sección de "O iniciar sesión con"
  - [X] Crear botones de redes sociales con estilo coherente
  - [ ] Implementar indicadores visuales animados de fortaleza de contraseña ← **PENDIENTE**
  - [X] Añadir animaciones para estados de interacción

### 4. Pantalla de Registro: ← **PRÓXIMA TAREA PRIORITARIA**

- [ ] **Experiencia de Formulario Mejorada:**
  - [ ] Diseñar indicador de progreso de pasos con transiciones fluidas
  - [ ] Implementar validación visual en tiempo real para cada campo usando flutter_animate
  - [ ] Crear secuencias de animación para transiciones entre campos de formulario
  - [ ] Diseñar visualización clara y animada de requisitos de contraseña

- [ ] **Elementos Visuales de Apoyo:**
  - [ ] Añadir tooltips informativos con aparición/desaparición animada
  - [ ] Implementar efectos de check animados para campos completados exitosamente
  - [ ] Crear pantalla de éxito con animación celebratoria al finalizar usando efectos de partículas
  - [ ] Diseñar iconos SVG minimalistas para acompañar cada paso del proceso

### 5. Pantalla de Recuperación de Contraseña:

- [ ] **Refinamiento Visual con Animaciones:**
  - [ ] Diseñar icono SVG representativo del proceso de recuperación
  - [ ] Implementar animación tipo "envío de correo" usando flutter_animate
  - [ ] Crear pantalla de confirmación con efecto de aparición gradual
  - [ ] Añadir contador visual animado para límites de intentos

## Elementos Transversales:

### 1. Animaciones y Transiciones con flutter_animate:

- [X] **Sistema de Animaciones:**
  - [X] Añadir flutter_animate como biblioteca principal de animaciones
  - [X] Crear un archivo `lib/core/animations/animation_presets.dart` con animaciones predefinidas
  - [X] Implementar extensiones de animación reutilizables para widgets comunes
  - [X] Corrección de errores de tipo usando el método `.custom()` para las animaciones de escala

### 2. Transiciones de Página Mejoradas:

- [ ] **Integración con Go Router:**
  - [X] Añadir go_router_plus como dependencia en pubspec.yaml
  - [ ] Configurar go_router_plus para transiciones personalizadas entre pantallas
  - [ ] Crear transiciones específicas para cada tipo de navegación (push, pop, etc.)
  - [ ] Asegurar que las transiciones sean consistentes con la identidad visual

### 3. Sistema de Iconos SVG:

- [X] **Implementación de flutter_svg:**
  - [X] Organizar estructura de carpetas para iconos SVG en `assets/icons/`
  - [ ] Crear widget wrapper `GlamIcon` para uso consistente de SVGs ← **PENDIENTE**
  - [ ] Implementar cacheo y optimización de rendimiento para iconos

### 4. Adaptabilidad y Responsividad:

- [ ] **Ajustes para Dispositivos:**
  - [ ] Crear sistema de constraints responsive usando MediaQuery
  - [ ] Implementar ajustes específicos para orientación landscape
  - [ ] Asegurar que las animaciones se escalen correctamente en diferentes dispositivos

### 5. Accesibilidad Visual:

- [ ] **Mejoras de Accesibilidad:**
  - [ ] Verificar contrastes de color para elementos de texto e interactivos
  - [ ] Implementar tamaños de toque adecuados (mínimo 48x48)
  - [ ] Asegurar que las animaciones no interfieran con la accesibilidad

### 6. Consistencia y Sistematización:

- [ ] **Sistema de Diseño:**
  - [ ] Documentar componentes visuales reutilizables en `/lib/core/style_guide.md`
  - [X] Crear widgets base personalizados con soporte para animaciones
  - [ ] Implementar theme extension para elementos visuales personalizados

## Consideraciones Técnicas y Ejemplos de Implementación:

### Solución implementada para animaciones:

Hemos implementado un enfoque robusto utilizando el método `.custom()` para evitar errores de tipos en las animaciones de escala:

```dart
// Botones con efecto de presión usando custom
widget.animate(target: isPressed ? 1 : 0)
  .custom(
    duration: GlamAnimations.shortDuration,
    curve: Curves.easeInOut,
    builder: (context, value, child) => Transform.scale(
      scale: isPressed ? (1.0 - 0.05 * value) : (0.95 + 0.05 * value),
      child: child,
    ),
  );

// Animación de entrada con fade, slide y scale combinados
widget.animate()
  .fade(duration: duration ?? GlamAnimations.defaultDuration)
  .slide(
    begin: const Offset(0, 0.1),
    end: Offset.zero,
  )
  .custom(
    builder: (context, value, child) => Transform.scale(
      scale: 0.95 + 0.05 * value,
      child: child,
    ),
  );
```

### Ejemplo de transiciones con go_router_plus:
```dart
// En tu configuración de router
GoRouter(
  routes: [...],
  pageBuilder: (context, state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Transición personalizada que encaja con la estética de Agenda Glam
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeOutQuad).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.04),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeOutQuad)).animate(animation),
            child: child,
          ),
        );
      },
    );
  },
);
```

- Mantener la consistencia con las constantes de tema definidas en `app_theme_constants.dart`
- Recordar que los archivos no deben superar las 300 líneas
- Asegurar que todas las animaciones sean eficientes para evitar problemas de rendimiento

## Resultado Esperado:

Un flujo de autenticación visualmente impactante, con transiciones fluidas y coherentes, que refuerce la identidad premium y masculina de Agenda Glam, diferenciándola de otras aplicaciones similares del mercado y proporcionando una experiencia de usuario satisfactoria desde el primer contacto con la aplicación.
