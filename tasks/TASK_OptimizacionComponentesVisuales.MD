# Tarea: Optimización de Componentes Visuales

## Referencias
- **ARCHITECTURE.MD:** Sección 6.4 (Sistema de Tema), Sección 4.2 (Límite de Tamaño de Archivos)
- **Tareas Relacionadas:** [TASK_DiseñoAutenticacionUI.MD](./TASK_DiseñoAutenticacionUI.MD)
- **Estado:** Completado Parcialmente

Este archivo detalla las tareas necesarias para optimizar y centralizar los componentes visuales de "Agenda Glam", enfocándose en eliminar duplicaciones, mejorar la reutilización y mantener una coherencia visual a través de toda la aplicación.

## Objetivos:

- ✅ Centralizar componentes visuales comunes para facilitar su mantenimiento
- ✅ Eliminar código duplicado y componentes redundantes
- ✅ Mejorar la coherencia visual entre todas las pantallas
- ✅ Optimizar el rendimiento visual de la aplicación

## Pasos:

### 1. Centralización de Fondos de Pantalla:

- [X] **Análisis de Redundancias:**
  - [X] Identificar múltiples implementaciones de fondos en la aplicación
  - [X] Documentar diferencias y similitudes entre implementaciones
  - [X] Determinar la mejor estrategia de unificación

- [X] **Implementación de Solución Centralizada:**
  - [X] Crear componente `GlamGradientBackground` en `core/widgets`
  - [X] Implementar parámetros flexibles pero con valores predeterminados coherentes
  - [X] Centralizar la lógica de degradados sin formas geométricas obsoletas

- [X] **Migración de Componentes Existentes:**
  - [X] Actualizar `GlamScaffold` para usar el nuevo componente centralizado
  - [X] Migrar páginas que usaban directamente `GlamBackground`
  - [X] Actualizar scaffolds específicos (register_scaffold, recovery_scaffold)
  - [X] Añadir TODOs para futura eliminación de componentes redundantes

- [X] **Limpieza de Código Obsoleto:** ✅ **COMPLETADO**
  - [X] Marcar clase `GlamBackground` como obsoleta con anotación `@deprecated`
  - [X] Eliminar `GeometricPatternPainter` y otras implementaciones antiguas
  - [X] Actualizar cualquier referencia restante al componente obsoleto

### 2. Unificación de Scaffolds: ⏰ **EN PROGRESO**

- [X] **Análisis de Scaffolds Específicos:**
  - [X] Comparar funcionalidades entre `RegisterScaffold`, `RecoveryScaffold` y `GlamScaffold`
  - [X] Identificar cualquier funcionalidad única en scaffolds específicos
  - [X] Determinar estrategia de migración completa

- [X] **Mejora de GlamScaffold para Unificación:**
  - [X] Actualizar `GlamScaffold` para soportar todos los casos de uso necesarios
  - [X] Implementar soporte para contenido directo sin encabezado (vía `directContent`)
  - [X] Añadir control para comportamiento del teclado (`resizeToAvoidBottomInset`)
  
- [X] **Eliminación Gradual de Scaffolds Específicos:** ✅ **COMPLETADO**
  - [X] Marcar `RegisterScaffold` y `RecoveryScaffold` como `@deprecated`
  - [X] Migrar cualquier uso restante a `GlamScaffold`
  - [X] Eliminar completamente los componentes obsoletos

### 3. Optimización de Componentes Compartidos: ⏰ **PARCIALMENTE COMPLETADO**

- [X] **Documentación Mejorada de Componentes Centralizados:**
  - [X] Mejorar la documentación de `GlamScaffold` con ejemplos de uso
  - [X] Clarificar las diferentes formas de usar componentes compartidos
  - [X] Documentar opciones de personalización disponibles

- [X] **Sistema de Transiciones Circulares:** ✅ **COMPLETADO**
  - [X] Crear `CirclePageRoute` para implementar transiciones con efecto circular
  - [X] Implementar `CircleNavigation` como utilidad centralizada de navegación
  - [X] Integrar transiciones circulares en el sistema de rutas existente
  - [X] Ajustar la duración de transición a 1200ms para mejor apreciación visual

- [ ] **Revisión de Widgets Adicionales:** ⏰ **PENDIENTE**
  - [ ] Analizar widgets en `core/widgets` y `features/*/widgets`
  - [ ] Identificar componentes similares o con funcionalidad duplicada
  - [ ] Crear plan de centralización para widgets comunes

- [ ] **Implementación de Biblioteca de Componentes:**
  - [ ] Refactorizar componentes duplicados en versiones centralizadas
  - [ ] Documentar API y casos de uso para cada componente
  - [ ] Crear demos o ejemplos de uso para referencia

## Consideraciones Técnicas:

### Patrón de Centralización Implementado:

Hemos establecido un patrón de centralización para los componentes visuales compartidos:

1. **Ubicación Estratégica:**
   - Componentes globales en `core/widgets/`
   - Componentes específicos de feature en `features/*/widgets/`

2. **Principios de Diseño:**
   - Parámetros con valores predeterminados sensatos
   - Configuración flexible pero con coherencia visual por defecto
   - Documentación clara de la intención y uso de cada componente

3. **Estrategia de Transición:**
   - Identificación de código redundante
   - Migración gradual a componentes centralizados
   - Marcado claro de código obsoleto con TODOs y anotaciones `@deprecated`
   - Eliminación eventual de código duplicado

## Resultado Esperado:

Un sistema de componentes visuales coherente, mantenible y eficiente, con:

1. **Fondos Unificados:**
   - Un único componente responsable de los fondos de pantalla
   - Coherencia visual entre pantallas
   - Eliminación de código duplicado

2. **Scaffolds Estándar:**
   - Una implementación unificada de scaffold para todas las pantallas
   - Configuración flexible para casos específicos
   - Reducción del tamaño total de código

3. **Biblioteca de Componentes:**
   - Conjunto coherente de widgets reutilizables
   - Documentación clara de uso
   - Fácil mantenimiento y extensión

## Próximos Pasos:

1. Completar la limpieza de código obsoleto
2. Migrar todas las pantallas a usar exclusivamente `GlamScaffold`
3. Documentar la nueva arquitectura de componentes en ARCHITECTURE.MD
