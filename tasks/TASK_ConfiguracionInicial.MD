# Tarea: Configuración Inicial del Proyecto

Este archivo detalla los pasos necesarios para configurar la estructura base, dependencias y configuraciones iniciales del proyecto Flutter "Agenda Glam".

## Pasos:

1.  **Inicialización del Proyecto Flutter:**
    - [ ] Ejecutar `flutter create .` en la raíz del proyecto para generar la estructura estándar.
    - [ ] Revisar y limpiar archivos iniciales si es necesario (ej. eliminar comentarios excesivos en `main.dart`).

2.  **Control de Versiones (Git):**
    - [ ] Asegurar que existe un archivo `.gitignore` adecuado para Flutter (generado por `flutter create`).
    - [ ] Inicializar el repositorio Git (`git init`) si no existe.
    - [ ] Realizar el primer commit con la estructura inicial del proyecto.

3.  **Estructura de Carpetas (Clean Architecture):**
    - [ ] Crear `lib/core`
        - [ ] Crear `lib/core/theme` (Para ThemeData y estilos)
        - [ ] Crear `lib/core/di` (Para configuración de Inyección de Dependencias - GetIt)
        - [ ] Crear `lib/core/config` (Para constantes, configuraciones globales)
        - [ ] Crear `lib/core/routes` (Para gestión de rutas/navegación)
        - [ ] Crear `lib/core/utils` (Para helpers y utilidades comunes)
        - [ ] Crear `lib/core/error` (Para manejo de errores, Failures, Exceptions)
        - [ ] Crear `lib/core/usecases` (Para la clase base UseCase)
        - [ ] Crear `lib/core/widgets` (Para widgets reutilizables comunes a toda la app)
        - [ ] Crear `lib/core/network` (Para configuración base de red, si se usará más adelante)
    - [ ] Crear `lib/features` (Contendrá los módulos de funcionalidades)
        - *Inicialmente vacío*
    - [ ] Crear `test/core` (Para pruebas unitarias/widget de `lib/core`)
    - [ ] Crear `test/features` (Para pruebas unitarias/widget de `lib/features`)

4.  **Gestión de Dependencias (`pubspec.yaml`):**
    - [ ] Añadir dependencias principales:
        - [ ] `flutter_bloc` (Para BLoC/Cubit)
        - [ ] `freezed_annotation` (Para modelos y estados inmutables)
        - [ ] `get_it` (Para Inyección de Dependencias)
        - [ ] `equatable` (Para comparación de objetos, útil con BLoC/estados)
        - [ ] (Opcional) Añadir `go_router` o similar para navegación avanzada.
    - [ ] Añadir dependencias de desarrollo (`dev_dependencies`):
        - [ ] `build_runner` (Para generación de código)
        - [ ] `freezed` (Generador para `freezed_annotation`)
        - [ ] `bloc_test` (Para probar BLoCs/Cubits)
        - [ ] `mocktail` o `mockito` (Para mocking en pruebas)
        - [ ] `flutter_lints` (o linter preferido) para análisis estático.
    - [ ] Ejecutar `flutter pub get` para descargar las dependencias.

5.  **Configuración de Generación de Código (`build_runner`):**
    - [ ] Asegurarse de que `build_runner` y `freezed` están en `dev_dependencies`.
    - [ ] (Opcional) Crear un script o alias para ejecutar `flutter pub run build_runner build --delete-conflicting-outputs`.

6.  **Configuración `main.dart`:**
    - [ ] Limpiar el `main.dart` generado por defecto.
    - [ ] Configurar la inicialización básica (ej. `WidgetsFlutterBinding.ensureInitialized()`).
    - [ ] Configurar la inicialización de GetIt (Service Locator).
    - [ ] Crear y usar un widget `App` raíz (ej. `MaterialApp` o `CupertinoApp`).
    - [ ] Aplicar el `ThemeData` definido.
    - [ ] Configurar el sistema de rutas inicial (si se usa `go_router` o similar).

7.  **Definición del Tema (`AppTheme`):**
    - [ ] Crear `lib/core/theme/app_theme.dart`.
    - [ ] Definir la paleta de colores principal (azul marino, dorado, grises, etc.) según `PLANNING.MD`.
    - [ ] Definir la tipografía (fuentes, tamaños, pesos).
    - [ ] Crear el `ThemeData` (modo oscuro) con los colores y tipografía.
    - [ ] Definir estilos específicos para widgets comunes (AppBar, Button, Card, TextField, etc.).

8.  **Configuración de Inyección de Dependencias (`GetIt`):**
    - [ ] Crear `lib/core/di/injection_container.dart`.
    - [ ] Crear una función `init()` para registrar las dependencias (inicialmente puede estar vacía o registrar singletons básicos).
    - [ ] Llamar a `init()` desde `main.dart` antes de `runApp()`.

9.  **Configuración del Linter:**
    - [ ] Crear o configurar el archivo `analysis_options.yaml`.
    - [ ] Incluir `flutter_lints` o las reglas de linter deseadas.
    - [ ] Ejecutar `flutter analyze` y corregir warnings/errores iniciales.

10. **Revisión Final:**
    - [ ] Asegurar que el proyecto compila y corre sin errores en un emulador/dispositivo.
    - [ ] Verificar que todas las subtareas anteriores están marcadas como completadas.
    - [ ] Actualizar este archivo `TASK_ConfiguracionInicial.MD` marcando este paso final.
