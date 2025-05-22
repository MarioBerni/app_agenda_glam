# Tarea: Mejora del Flujo de Registro con Google (Frontend)

## Referencias
- **ARCHITECTURE.MD:** Sección 3.1 (Capa de Presentación), Sección 6.1 (Sistema de Gestión de Estado)
- **Tareas Relacionadas:** [TASK_FlujoAutenticacionUI.MD](./TASK_FlujoAutenticacionUI.MD), [TASK_DiseñoAutenticacionUI.MD](./TASK_DiseñoAutenticacionUI.MD)
- **Estado:** Pendiente

Este archivo detalla los pasos necesarios para mejorar el flujo de registro con Google en la aplicación "Agenda Glam", enfocándose exclusivamente en la implementación frontend. El objetivo es asegurar la captura de toda la información necesaria del usuario (teléfono y tipo de usuario) mientras se mantiene una experiencia fluida y coherente. Esta implementación seguirá los principios visuales y de experiencia de usuario establecidos en el [PLANNING.MD](../PLANNING.MD).

## Objetivos:

- Implementar una interfaz de usuario para el registro con Google que capture toda la información necesaria
- Crear una experiencia de usuario fluida y sin fricciones
- Asegurar la coherencia visual con el resto de la aplicación
- Simular la funcionalidad de registro con Google (sin implementación backend real)
- Optimizar el proceso para reducir el abandono durante el registro

## Pasos:

### 1. Crear Pantalla de Información Adicional Post-Google:

- [ ] Crear nueva pantalla `GoogleRegisterAdditionalInfoPage`:
  - [ ] Diseñar interfaz para solicitar información adicional post-autenticación Google
  - [ ] Implementar selección de tipo de usuario (Cliente/Propietario/Empleado)
  - [ ] Añadir campo para número de teléfono con validación
  - [ ] Incluir botón para completar el registro
  - [ ] Mantener coherencia visual con el resto del flujo de autenticación
  - [ ] Aplicar animaciones consistentes con el sistema GlamAnimations

### 2. Modificar Flujo de Registro con Google:

- [ ] Actualizar método `_handleGoogleRegister` en `RegisterPage`:
  - [ ] Mantener la simulación de autenticación con Google
  - [ ] Modificar navegación para dirigir a `GoogleRegisterAdditionalInfoPage` en lugar de Home
  - [ ] Pasar información obtenida de Google (nombre, email) a la nueva pantalla
  - [ ] Manejar correctamente los estados de carga

- [ ] Implementar lógica para completar registro en `GoogleRegisterAdditionalInfoPage`:
  - [ ] Crear método para validar y procesar la información adicional
  - [ ] Integrar con AuthCubit para el registro final
  - [ ] Implementar navegación a Home después del registro exitoso
  - [ ] Manejar casos de error apropiadamente

### 3. Simular el Sistema de Gestión de Estado:

- [ ] Modificar `AuthCubit` para simular el registro con Google:
  - [ ] Crear método para simular registro con Google + información adicional
  - [ ] Actualizar estados para reflejar el nuevo flujo visual
  - [ ] Mantener compatibilidad con el flujo de registro tradicional simulado

### 4. Implementar Validaciones y UX:

- [ ] Crear validaciones específicas para la información adicional:
  - [ ] Validación de número de teléfono (formato, longitud)
  - [ ] Validación de selección de tipo de usuario
  - [ ] Feedback visual inmediato

- [ ] Mejorar experiencia de usuario:
  - [ ] Añadir indicación clara de progreso en el flujo
  - [ ] Implementar transiciones fluidas entre pantallas
  - [ ] Optimizar para uso con teclado virtual
  - [ ] Añadir opción para cancelar y volver al inicio

### 5. Optimización de la Experiencia Visual:

- [ ] Optimizar rendimiento y experiencia visual:
  - [ ] Asegurar transiciones fluidas entre pantallas
  - [ ] Minimizar reconstrucciones innecesarias de widgets
  - [ ] Verificar comportamiento responsivo en diferentes tamaños de pantalla
  - [ ] Optimizar animaciones para mantener 60fps

### 6. Refactorización y Documentación:

- [ ] Refactorizar código para mantener archivos bajo 300 líneas:
  - [ ] Extraer componentes reutilizables si es necesario
  - [ ] Mantener separación clara de responsabilidades

- [ ] Actualizar documentación:
  - [ ] Documentar el nuevo flujo en comentarios de código
  - [ ] Actualizar UI_COMPONENTS.md si se crean nuevos componentes
  - [ ] Añadir instrucciones para implementación real con Firebase Auth

## Consideraciones Adicionales:

- Mantener todos los textos claros y consistentes con el resto de la aplicación
- Asegurar que la pantalla de información adicional mantenga la estética masculina y profesional
- Crear componentes modulares que faciliten la futura integración con sistemas reales
- Asegurar que todos los archivos mantienen menos de 300 líneas siguiendo la regla de oro del proyecto
- Documentar claramente el flujo visual para facilitar la futura implementación backend

## Detalles Técnicos:

### Archivos Principales a Modificar (Frontend):

1. **Crear Nuevos Archivos:**
   - `lib/features/auth/presentation/pages/google_register_additional_info_page.dart`
   - `lib/features/auth/presentation/widgets/google_register_info_form.dart` (opcional, para modularidad)

2. **Modificar Archivos Existentes:**
   - `lib/features/auth/presentation/pages/register_page.dart`
   - `lib/features/auth/presentation/widgets/register_content.dart`
   - `lib/features/auth/presentation/cubit/auth_cubit.dart` (solo para simulación)

### Flujo de Usuario Final (Frontend):

1. Usuario selecciona "Registrarse con Google" en la pantalla de registro
2. Se muestra animación de carga simulando proceso de autenticación con Google
3. Usuario es dirigido a pantalla de información adicional
4. Usuario completa tipo de usuario y número de teléfono
5. Usuario finaliza registro y es dirigido a la pantalla principal (simulado)
6. En caso de cancelación, usuario puede volver a la pantalla anterior

Este documento proporciona una guía completa para implementar la interfaz de usuario del flujo de registro con Google mejorado, centrándose exclusivamente en los aspectos visuales y de experiencia de usuario, sin implementación de pruebas ni integración backend real.
