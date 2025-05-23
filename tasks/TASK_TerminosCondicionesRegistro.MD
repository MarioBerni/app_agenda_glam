# Tarea: Implementación de Términos y Condiciones en Registro

## Referencias
- **ARCHITECTURE.MD:** Sección 6.3 (Sistema de Navegación)
- **Tareas Relacionadas:** [TASK_FlujoAutenticacionUI.MD](./TASK_FlujoAutenticacionUI.MD)
- **Estado:** Completado (Pendiente de pruebas)

Este archivo detalla los pasos necesarios para implementar la visualización de Términos y Condiciones en el flujo de registro de "Agenda Glam", manteniendo la consistencia visual y experiencia premium de la aplicación.

## Objetivos:
- Implementar un enlace claro a Términos y Condiciones en la página de registro
- Crear una experiencia visual coherente para mostrar el contenido de los términos
- Integrar la aceptación de términos como requisito para completar el registro
- Mantener la simplicidad del flujo de registro sin interrupciones significativas

## Pasos:

### 1. Implementación del Link y Checkbox:
- [x] Crear componente `TermsCheckbox` con checkbox estilizado y texto clickeable
- [x] Integrar el componente en `RegisterPasswordStep` o el paso final de registro
- [x] Implementar validación que verifique la aceptación de términos antes del registro
- [x] Añadir mensaje de error si el usuario intenta registrarse sin aceptar

### 2. Crear Diálogo Modal para Términos y Condiciones:
- [x] Implementar `GlamTermsDialog` como componente reutilizable
- [x] Diseñar interfaz con:
  - [x] Encabezado con título "Términos y Condiciones"
  - [x] Área de contenido con scroll para el texto completo
  - [x] Botón de cierre y botón de "Aceptar"
  - [x] Fondo y estilo coherentes con el tema de la app
- [x] Añadir animación de deslizamiento desde abajo utilizando `SlideTransition` y `FadeTransition`

### 3. Contenido de los Términos y Condiciones:
- [x] Crear contenido temporal (placeholder) directamente en el componente
- [x] Implementar formato estructurado para el contenido
- [x] Añadir estilos para títulos, párrafos y listas

### 4. Integración con Registro:
- [x] Conectar el checkbox con el estado de aceptación de términos
- [x] Implementar apertura del diálogo al hacer clic en el enlace
- [x] Actualizar el estado del checkbox cuando el usuario acepta desde el diálogo
- [x] Verificar que el registro solo proceda si los términos han sido aceptados

## Criterios de Aceptación:
- El enlace debe ser claramente visible y distinguible
- El diálogo debe mantener la estética premium de la aplicación
- La aceptación de términos debe ser requisito para completar el registro
- La experiencia no debe interrumpir significativamente el flujo de registro
- El texto debe ser legible y el diálogo debe permitir scroll para contenido extenso

## Consideraciones Adicionales:
- Por el momento, se usará texto de relleno (placeholder) para los términos
- La funcionalidad frontend debe estar completa, aunque sin conexión a backend
- Todo el código debe seguir los principios de Clean Architecture del proyecto
- Mantener archivos por debajo de 300 líneas siguiendo la regla de oro del proyecto

## Detalles de Implementación:

### Diseño del Diálogo Modal:
- **Apariencia**: Fondo en degradado con colores kSurfaceColor
- **Bordes**: Sutiles bordes dorados (kAccentColor) para mantener la estética premium
- **Encabezado**: Título centrado con tipografía coherente con el tema
- **Contenido**: Área scrollable con formato de texto claro y bien estructurado
- **Botones**: Botón principal "Aceptar" con estilo GlamButton y botón secundario para cerrar

### Diseño del Checkbox:
- **Apariencia**: Checkbox personalizado con colores del tema (acento dorado)
- **Animación**: Efecto visual al seleccionar usando flutter_animate
- **Texto**: "He leído y acepto los" seguido de "Términos y Condiciones" en color kAccentColor y subrayado

### Integración en el Flujo:
- Ubicación en el paso final de registro, justo antes del botón de "Registrarme"
- El botón de registro debe permanecer deshabilitado hasta que se acepten los términos
- Al hacer clic en el enlace, el diálogo aparece con una animación suave
- Al aceptar desde el diálogo, el checkbox se marca automáticamente

## Progreso:
- [x] **Fase 1**: Componentes básicos - Checkbox y diálogo modal
- [x] **Fase 2**: Integración con el flujo de registro
- [x] **Fase 3**: Refinamiento visual y animaciones
- [x] **Fase 4**: Pruebas y ajustes finales

## Actualizaciones y Mejoras:
- **23/05/2025**: Implementación inicial de los componentes básicos y la integración con el flujo de registro
- **23/05/2025**: Se modificó el enlace en la pantalla inicial para abrir el diálogo de términos
- **23/05/2025**: Se rediseñó el diálogo utilizando `AlertDialog` para mejorar la compatibilidad
- **23/05/2025**: Se añadió animación de deslizamiento desde abajo para mejorar la experiencia de usuario
