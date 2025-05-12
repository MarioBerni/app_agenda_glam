# Tarea: Flujo de Autenticación - UI

Este archivo detalla los pasos necesarios para implementar el flujo de autenticación de usuarios para la aplicación "Agenda Glam", enfocándose exclusivamente en la interfaz de usuario (UI). Esta implementación seguirá los principios de Clean Architecture y el enfoque de desarrollo Frontend establecido en el PLANNING.MD.

## Objetivos:

- Implementar un flujo de autenticación visualmente atractivo y funcional
- Aplicar el tema oscuro masculino definido en la configuración inicial
- Mantener la separación de responsabilidades según Clean Architecture
- Utilizar widgets reutilizables para consistencia visual

## Pasos:

### 1. Estructura de Carpetas (Feature Auth):

- [X] Crear la estructura de carpetas para el feature de autenticación según Clean Architecture:
  - [X] `lib/features/auth/`
    - [X] `presentation/`
      - [X] `pages/` (Welcome, Login, Register)
      - [X] `widgets/` (Componentes específicos de autenticación)
      - [X] `bloc/` o `cubit/` (Estado de autenticación)
    - [X] `domain/`
      - [X] `entities/` (User, UserCredentials)
      - [X] `repositories/` (Interfaces para IAuthRepository)
      - [X] `usecases/` (Login, Register, etc.)
    - [X] `data/`
      - [X] `models/` (UserModel, CredentialsModel, etc.)
      - [X] `repositories/` (Implementaciones como AuthRepository)
      - [X] `datasources/` (MockAuthDataSource inicialmente)

### 2. Implementación de la UI:

- [X] Crear página de bienvenida/selector (WelcomePage):
  - [X] Diseñar pantalla con logo de Agenda Glam
  - [X] Añadir animación simple de entrada (opcional)
  - [X] Implementar botones para "Iniciar Sesión" y "Registrarse"
  - [X] Aplicar tema oscuro conforme a app_theme.dart

- [X] Crear página de Inicio de Sesión (LoginPage):
  - [X] Implementar campos de entrada:
    - [X] Email (con validación de formato)
    - [X] Contraseña (con opción de mostrar/ocultar)
  - [X] Botón de "Iniciar Sesión" (con estado de carga)
  - [X] Enlace a "Olvidé mi contraseña" (solo UI)
  - [X] Enlace para navegar a Registro
  - [X] Implementar validación de formulario

- [X] Crear página de Registro (RegisterPage):
  - [X] Implementar campos necesarios:
    - [X] Nombre completo
    - [X] Email (con validación)
    - [X] Contraseña (con requisitos visibles)
    - [X] Confirmar Contraseña (con validación de coincidencia)
  - [X] Botón de "Registrarse" (con estado de carga)
  - [X] Enlace para volver a Inicio de Sesión
  - [X] Implementar validación de formulario

- [X] Crear página de Recuperación de Contraseña (ForgotPasswordPage):
  - [X] Campo de Email
  - [X] Botón para enviar solicitud
  - [X] Pantalla de confirmación de envío

### 3. Gestión de Estado (BLoC/Cubit):

- [X] Implementar AuthCubit para gestionar estado de autenticación:
  - [X] Definir estados (AuthInitial, AuthLoading, Authenticated, Unauthenticated, AuthError)
  - [X] Implementar métodos (login, register, logout)
  - [X] Utilizar datos mock inicialmente (sin Firebase)

- [X] Conectar UI con Cubit:
  - [X] Implementar BlocProvider en páginas de autenticación
  - [X] Usar BlocBuilder/BlocListener para responder a cambios de estado
  - [X] Manejar estados de carga y error en UI

### 4. Navegación:

- [X] Actualizar el router (GoRouter) para incluir rutas de autenticación:
  - [X] Definir rutas para Welcome, Login, Register, ForgotPassword
  - [X] Implementar redirecciones basadas en estado de autenticación

### 5. Validación y UX:

- [X] Implementar validación de formularios:
  - [X] Crear validaciones para reglas comunes
  - [X] Mostrar errores inline en los campos
  - [X] Deshabilitar botones cuando el formulario es inválido

- [X] Mejorar experiencia de usuario:
  - [X] Añadir transiciones/animaciones entre páginas
  - [X] Implementar auto-focus y navegación por teclado
  - [X] Manejar visibilidad del teclado virtual apropiadamente

### 6. Widgets Reutilizables:

- [X] Crear widgets personalizados:
  - [X] GlamTextField (campo de texto estilizado)
  - [X] GlamPasswordField (campo con icono toggle para visibilidad)
  - [X] GlamButton (botón con estados: normal, loading, disabled)
  - [X] GlamLogo (logo de la app con tamaños configurables)

## Consideraciones Adicionales:

- Asegurar que todos los textos sean claros y consistentes
- Implementar feedback visual para acciones del usuario
- Mantener la estética masculina y profesional conforme al tema oscuro
- Recordar que esta fase se centra en el frontend, por lo que todas las operaciones de autenticación serán simuladas
- Mantener archivos por debajo de 300 líneas siguiendo la regla de oro del proyecto

## Resultado Esperado:

Un flujo de autenticación visual y funcional con datos mock, que siga los principios de Clean Architecture y presente una interfaz elegante conforme al diseño establecido. El usuario podrá navegar entre las diferentes pantallas del flujo de autenticación y ver cómo responde la interfaz a interacciones, aunque sin persistencia real de datos en esta etapa.
