# Estructura y Arquitectura del Proyecto: Agenda Glam

## 1. Introducción

### 1.1. Propósito de este Documento
Este documento describe la arquitectura de software, la estructura del proyecto y las directrices de desarrollo para la aplicación "Agenda Glam". Su objetivo es servir como guía central para todos los desarrolladores, asegurando una comprensión común, la coherencia en el desarrollo y la mantenibilidad del código a lo largo del ciclo de vida del proyecto.

### 1.2. Visión General de Agenda Glam
Agenda Glam es una plataforma diseñada para la gestión de servicios de estética dirigidos al público masculino en Uruguay. Busca simplificar la reserva de citas para los clientes y ofrecer herramientas de gestión robustas para los proveedores de servicios.

## 2. Principios Fundamentales de Desarrollo

El proyecto Agenda Glam se adhiere a los siguientes principios clave:

* **Arquitectura Limpia (Clean Architecture):** Separación estricta de responsabilidades entre las capas de Presentación, Dominio y Datos.
* **Estructura Modular (Feature-First):** El código se organiza por funcionalidades, donde cada módulo encapsula sus propios componentes de presentación, dominio y datos.
* **Limitación del Tamaño de Archivos:** Los archivos de código fuente (Dart) no deben exceder las **300 líneas** para promover la cohesión y la legibilidad.
* **Documentación Continua:** La documentación y los comentarios se escriben a medida que se desarrolla el código.
* **Inmutabilidad:** Se prefiere el uso de objetos inmutables, especialmente para modelos de datos y estados (ej., usando `freezed`).
* **Testabilidad:** El código se escribe de manera que sea fácilmente testeable, facilitando la creación de pruebas unitarias, de widgets y de integración.

## 3. Arquitectura del Proyecto: Arquitectura Limpia

Agenda Glam implementa los principios de la Arquitectura Limpia para lograr un sistema desacoplado, testeable y mantenible. La arquitectura se divide en tres capas principales:

![Diagrama de Arquitectura Limpia](https://placehold.co/600x400/001B4D/FFFFFF?text=Diagrama+Arquitectura+Limpia)
*Representación conceptual de las capas. El diagrama específico del proyecto se encuentra en "Estructura Proyecto.pdf", página 2.*

### 3.1. Capa de Presentación (Presentation Layer)
* **Responsabilidades:**
    * Mostrar la interfaz de usuario (UI) y manejar la interacción del usuario.
    * Contener los Widgets, Pages/Screens.
    * Gestionar el estado de la UI utilizando el patrón BLoC/Cubit.
    * Manejar la navegación entre pantallas (Routing).
* **Patrón de Componentes Modulares:**
    * **Pages:** Contenedores principales que solo manejan la composición y estado.
    * **Componentes Especializados:** Widgets modulares con responsabilidad única.
    * **Scaffolds:** Proporcionan la estructura básica de la UI (Consistente en todas las pantallas).
    * **Controllers:** Manejan la lógica de control de flujo separada de la UI.
* **Componentes Típicos:** Widgets de Flutter, Pages, Cubits/BLoCs, Controllers, y la configuración de rutas.
* **Dependencias:** Depende de la Capa de Dominio (a través de interfaces y casos de uso). No conoce los detalles de la Capa de Datos.

### 3.2. Capa de Dominio (Domain Layer)
* **Responsabilidades:**
    * Contener la lógica de negocio central y las reglas de la aplicación.
    * Ser independiente de cualquier framework o detalle de implementación externa (UI, base de datos).
* **Componentes Típicos:**
    * **Entidades (Entities):** Objetos de negocio que representan los conceptos fundamentales (ej. `User`, `Appointment`).
    * **Casos de Uso (Use Cases):** Encapsulan operaciones específicas de la lógica de negocio (ej. `LoginUserUseCase`, `ScheduleAppointmentUseCase`).
    * **Interfaces de Repositorio (Repository Interfaces):** Definen los contratos (abstracciones) para las operaciones de datos que la capa de dominio necesita, sin conocer cómo se implementarán.
* **Dependencias:** No depende de ninguna otra capa. Es el núcleo de la aplicación.

### 3.3. Capa de Datos (Data Layer)
* **Responsabilidades:**
    * Implementar las interfaces de repositorio definidas en la Capa de Dominio.
    * Gestionar la obtención, almacenamiento y envío de datos desde/hacia fuentes externas (APIs, bases de datos locales, Firebase).
    * Mapear entre modelos de datos específicos de la fuente y las entidades del dominio.
* **Componentes Típicos:**
    * **Implementaciones de Repositorio (Repository Implementations):** Clases concretas que implementan las interfaces de repositorio (ej. `AuthRepositoryImpl`).
    * **Fuentes de Datos (Data Sources):** Clases responsables de interactuar directamente con las fuentes de datos (ej. `AuthFirebaseDataSource`, `AuthMockDataSource`).
    * **Modelos (Models):** Objetos de transferencia de datos (DTOs) específicos de las fuentes de datos (ej. `UserModel` que puede tener anotaciones para JSON o Firebase).
* **Dependencias:** Depende de la Capa de Dominio (para implementar sus interfaces). Puede depender de bibliotecas externas (ej. `firebase_auth`, `http`).

## 4. Organización del Código y Estructura

### 4.1. Estructura Orientada a Funcionalidades (Feature-First)
El código se organiza agrupando todos los artefactos relacionados con una funcionalidad específica (feature) en un mismo módulo. Por ejemplo, una funcionalidad "autenticación" (`auth`) contendrá sus propias carpetas de `presentation`, `domain` y `data`.

```
lib/
├── core/                    # Funcionalidad transversal y compartida
│   ├── theme/
│   ├── di/
│   ├── routes/
│   ├── widgets/             # Widgets reutilizables comunes
│   ├── utils/
│   ├── error/
│   ├── usecases/            # Casos de uso base (si aplica)
│   └── config/
│
├── features/                # Módulos de funcionalidades específicas
│   └── auth/                # Ejemplo: Funcionalidad de Autenticación
│       ├── data/
│       │   ├── datasources/ # Fuentes de datos (remota, local, mock)
│       │   ├── models/      # Modelos de datos específicos de la capa de datos
│       │   └── repositories/# Implementaciones de repositorios
│       ├── domain/
│       │   ├── entities/    # Entidades de negocio
│       │   ├── repositories/# Interfaces de repositorios
│       │   └── usecases/    # Casos de uso específicos de la funcionalidad
│       └── presentation/
│           ├── bloc/        # BLoCs o Cubits
│           ├── pages/       # Pantallas/Vistas principales
│           └── widgets/     # Widgets específicos de la funcionalidad
│   └── other_feature/       # Otra funcionalidad
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart                # Punto de entrada de la aplicación
```
*Diagrama conceptual. La estructura detallada se encuentra en "Estructura Proyecto.pdf", página 3 y "Development Guide", página 20.*

### 4.2. Límite de Tamaño de Archivos y Modularización
Todos los archivos Dart deben mantenerse por debajo de las **300 líneas**. Si un archivo se acerca a este límite, debe ser refactorizado en componentes más pequeños con responsabilidades más enfocadas.

#### 4.2.1 Estrategias de Modularización

Se aplican los siguientes patrones y estrategias para mantener los archivos por debajo del límite:

* **Componentes de Responsabilidad Única:** Cada widget debe tener una responsabilidad clara y única.
* **Separación MVC en Presentación:** 
  * **Modelo (M):** Entidades y validadores en la capa de dominio.
  * **Vista (V):** Widgets específicos en `presentation/widgets/`.
  * **Controlador (C):** Clases controller en `presentation/controllers/`.
* **Jerarquía de Componentes:**
  * **Contenedores:** Pages que componen otros componentes (ej: `RegisterPage`).
  * **Componentes de Presentación:** Widgets visuales puros (ej: `RegisterHeader`).
  * **Componentes Funcionales:** Widgets con lógica interna (ej: `PasswordStrengthIndicator`).
  * **Scaffolds Reutilizables:** Estructuras base comunes (ej: `RegisterScaffold`).

## 5. Pila Tecnológica Principal

* **Framework Frontend:** Flutter
* **Lenguaje de Programación:** Dart
* **Backend y Base de Datos (Planificado):** Firebase (Authentication, Cloud Firestore, Storage, Cloud Functions)
* **Gestión de Estado:** BLoC / Cubit (`flutter_bloc`)
* **Inyección de Dependencias:** `get_it`
* **Navegación/Rutas:** `go_router`
* **Modelos Inmutables:** `freezed`, `equatable`
* **Animaciones UI:** `flutter_animate`
* **Manejo de Media:** `video_player`, `cached_network_image`
* **Linting:** `flutter_lints`

## 6. Sistemas Clave del Proyecto

### 6.1. Sistema de Gestión de Estado (BLoC/Cubit)
* **Propósito:** Manejar el estado de la UI de forma reactiva y separada de la lógica de presentación.
* **Componentes:**
    * **Cubit/BLoC:** Contiene la lógica de negocio de la presentación y emite estados.
    * **State:** Clase inmutable (usualmente generada con `freezed`) que representa el estado de la UI en un momento dado (ej. `AuthInitial`, `AuthLoading`, `AuthAuthenticated`, `AuthError`).
    * **Event (para BLoC):** Representa acciones del usuario o eventos del sistema que el BLoC procesará.
* **Uso:**
    * Los Cubits/BLoCs se proveen a través de `BlocProvider` en el árbol de widgets.
    * La UI escucha los cambios de estado mediante `BlocBuilder`, `BlocListener` o `BlocConsumer` y se reconstruye/reacciona acordemente.
    * Los Cubits interactúan con los Casos de Uso de la capa de Dominio.
* **Flujo (Ejemplo Login con Cubit):**
    1.  UI (LoginPage) invoca un método en `AuthCubit` (ej. `authCubit.login(email, password)`).
    2.  `AuthCubit` emite `AuthState.loading()`.
    3.  `AuthCubit` llama al `LoginUseCase` correspondiente.
    4.  `LoginUseCase` interactúa con `AuthRepository` (interfaz).
    5.  `AuthRepositoryImpl` (Data Layer) realiza la operación (ej. llamada a `AuthMockDataSource`).
    6.  El resultado vuelve al `AuthCubit`.
    7.  `AuthCubit` emite `AuthState.authenticated(user)` o `AuthState.error(message)`.
    8.  La UI reacciona al nuevo estado.
* **Observación:** Se utiliza un `AppBlocObserver` para registrar transiciones y errores de BLoC/Cubit durante el desarrollo.

### 6.2. Sistema de Inyección de Dependencias (GetIt)
* **Propósito:** Desacoplar componentes y facilitar la gestión de sus dependencias y las pruebas.
* **Configuración:**
    * Se utiliza una instancia global de `GetIt`: `final sl = GetIt.instance;`.
    * Se inicializan las dependencias al inicio de la aplicación (`main.dart`) mediante una función `initializeDependencies()`.
* **Tipos de Registro:**
    * `sl.registerLazySingleton<Type>(() => Implementation())`: Una única instancia creada la primera vez que se solicita. Usado para repositorios, fuentes de datos.
    * `sl.registerFactory<Type>(() => Implementation())`: Una nueva instancia creada cada vez que se solicita. Usado para Cubits/BLoCs.
* **Resolución:** Las dependencias se resuelven usando `sl<Type>()`. Comúnmente se inyectan en los constructores.
* **Integración:**
    * En `main.dart`, `BlocProvider` utiliza `sl<AuthCubit>()` para crear instancias de Cubits.

### 6.3. Sistema de Rutas (go_router)
* **Propósito:** Gestionar la navegación entre pantallas de forma declarativa y tipada.
* **Configuración:**
    * Las rutas se definen en `AppRouter` (ej. `lib/core/routes/app_router.dart`).
    * Se definen constantes para los nombres de las rutas (ej. `AppRouter.login`, `AppRouter.home`).
    * Se crea una instancia de `GoRouter` con la lista de `GoRoute`.
* **Integración:** La instancia de `GoRouter` se pasa a `MaterialApp.router` en `main.dart`.
* **Navegación:** Se utiliza `context.go(AppRouter.routeName)` o `context.push(AppRouter.routeName)`.

### 6.4. Sistema de Tema (Theme System)
* **Propósito:** Asegurar una apariencia visual consistente en toda la aplicación.
* **Arquitectura:**
    * `app_theme_constants.dart`: Define constantes para colores (paleta azul oscuro y dorados), espaciados, tamaños de fuente, radios de borde, elevaciones y duraciones de animación.
    * `app_theme.dart`: Define la clase `AppTheme` con una propiedad estática `appTheme` que crea y configura el objeto `ThemeData` utilizando las constantes.
* **Paleta de Colores Principal:**
    * Primarios (Azules): `kPrimaryColor` (#00296B), `kBackgroundColor` (#001B4D), `kSurfaceColor` (#002C76).
    * Acentos (Dorados): `kAccentColor` (#FDC500).
    * Texto: `kTextColor` (#FFFFFF), `kSecondaryTextColor` (#B0BAC5).
    * Error: `kErrorColor` (#CF6679).
* **Tipografía:** Se definen estilos de texto consistentes (Display, Headline, Body, Label) en `TextTheme`.
* **Estilos de Componentes:** Se personalizan los temas para `ElevatedButton`, `TextButton`, `OutlinedButton`, `InputDecorationTheme`, `CardTheme`, `DialogTheme`, etc.
* **Uso:**
    * El `ThemeData` se aplica globalmente en `MaterialApp.theme`.
    * Los widgets acceden a las propiedades del tema mediante `Theme.of(context)`.
    * Se pueden usar las constantes directamente (ej. `kSpaceM`) para espaciados y tamaños.

### 6.5. Sistema de Animación
* **Propósito:** Proveer animaciones consistentes y elegantes.
* **Base:** Construido sobre `flutter_animate`.
* **Componentes:**
    * `animation_presets.dart`:
        * **Constantes de Animación:** Duraciones (`defaultDuration`, `shortDuration`) y curvas (`defaultCurve`).
        * **Presets de Animación (`GlamAnimations`):** Métodos estáticos como `applyEntryEffect`, `applyButtonPressEffect`, `applyShimmerEffect`.
        * **Extensiones de Widget:** Métodos de extensión sobre `Widget` para aplicar animaciones de forma fluida.

## 7. Flujo de Desarrollo de Nuevas Funcionalidades

1.  **Planificación:** Definir la funcionalidad en un archivo `TASK_nombre_tarea.MD`.
2.  **Dominio:**
    * Definir Entidades necesarias.
    * Definir Interfaces de Repositorio.
    * Crear Casos de Uso.
3.  **Datos:**
    * Crear Modelos (si son diferentes de las entidades).
    * Implementar Fuentes de Datos (inicialmente mocks, luego Firebase).
    * Implementar los Repositorios.
4.  **Presentación:**
    * Crear States para el Cubit/BLoC.
    * Implementar el Cubit/BLoC, conectándolo a los Casos de Uso.
    * Desarrollar Pages y Widgets, utilizando el tema y los componentes reutilizables.
    * Conectar la UI al Cubit/BLoC para mostrar datos y manejar interacciones.
5.  **Inyección de Dependencias:** Registrar los nuevos repositorios, fuentes de datos y Cubits/BLoCs en `service_locator.dart`.
6.  **Rutas:** Añadir nuevas rutas en `app_router.dart` si es necesario.
7.  **Pruebas:** Escribir pruebas unitarias, de widgets y de integración.
8.  **Documentación:** Actualizar comentarios y documentación relevante.

## 8. Directrices de Codificación Esenciales

* **Nomenclatura:**
    * Clases, Enums, Extensiones, Typedefs: `UpperCamelCase` (ej. `AuthRepository`, `UserEntity`).
    * Variables, Campos, Métodos, Funciones, Parámetros: `lowerCamelCase` (ej. `userName`, `fetchUserData()`).
    * Archivos y Carpetas: `snake_case` (ej. `auth_repository.dart`, `user_entity.dart`).
* **Documentación y Comentarios:**
    * `///` para documentación de APIs públicas (clases, métodos, funciones). Incluir descripción, parámetros y valores de retorno.
    * `//` para comentarios en línea explicando lógica compleja.
* **Formato y Linting:**
    * Utilizar `dart format` para mantener un formato consistente.
    * Asegurar que `flutter analyze` pase sin errores ni warnings, siguiendo las reglas de `flutter_lints`.
* **Inmutabilidad:** Usar `final` para propiedades que no cambian después de la inicialización. Preferir `const` para constructores y variables cuando sea posible. Utilizar `freezed` para estados y modelos de datos.
* **Manejo de Errores:** Utilizar `try-catch` y reflejar errores en los estados del Cubit/BLoC para informar a la UI.

## 9. Evolución del Documento

| Fecha       | Versión | Cambios                           | Autor       |
|-------------|---------|-----------------------------------|-------------|
| 14-05-2025  | 1.0     | Versión inicial del documento     | Mario Berni |

## 10. Conclusión

Seguir la arquitectura, estructura y directrices definidas en este documento es crucial para el desarrollo exitoso, la colaboración efectiva y la mantenibilidad a largo plazo del proyecto Agenda Glam. Se espera que todos los desarrolladores se familiaricen con estos principios y los apliquen consistentemente.

---

**Próximos Pasos Sugeridos:**
* Revisar este documento con el equipo.
* Utilizarlo como referencia constante durante el desarrollo.
* Actualizarlo a medida que el proyecto evolucione, si es necesario.
