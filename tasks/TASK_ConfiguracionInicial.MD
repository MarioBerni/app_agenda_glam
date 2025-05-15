# Tarea: Configuración Inicial del Proyecto

## Referencias
- **ARCHITECTURE.MD:** Sección 4 (Organización del Código y Estructura), Sección 5 (Pila Tecnológica Principal)
- **Estado:** Completada

Este archivo detalla los pasos necesarios para configurar la estructura base, dependencias y configuraciones iniciales del proyecto Flutter "Agenda Glam". Esta tarea establece los fundamentos descritos en el [PLANNING.MD](../PLANNING.MD).

## Pasos:

1.  **Inicialización del Proyecto Flutter:**
    - [X] Ejecutar `flutter create .` en la raíz del proyecto para generar la estructura estándar.
    - [X] Revisar y limpiar archivos iniciales si es necesario (ej. eliminar comentarios excesivos en `main.dart`).

2.  **Control de Versiones (Git):**
    - [X] Asegurar que existe un archivo `.gitignore` adecuado para Flutter (generado por `flutter create`).
    - [X] Inicializar el repositorio Git (`git init`) si no existe.
    - [X] Realizar el primer commit con la estructura inicial del proyecto.

3.  **Estructura de Carpetas (Clean Architecture):**
    - [X] Crear `lib/core`
        - [X] Crear `lib/core/theme` (Para ThemeData y estilos)
        - [X] Crear `lib/core/di` (Para configuración de Inyección de Dependencias - GetIt)
        - [X] Crear `lib/core/config` (Para constantes, configuraciones globales)
        - [X] Crear `lib/core/routes` (Para gestión de rutas/navegación)
        - [X] Crear `lib/core/utils` (Para helpers y utilidades comunes)
        - [X] Crear `lib/core/error` (Para manejo de errores, Failures, Exceptions)
        - [X] Crear `lib/core/usecases` (Para la clase base UseCase)
        - [X] Crear `lib/core/widgets` (Para widgets reutilizables comunes a toda la app)
        - [X] Crear `lib/core/network` (Para configuración base de red, si se usará más adelante)
    - [X] Crear `lib/features` (Contendrá los módulos de funcionalidades)
        - *Inicialmente vacío*

4.  **Gestión de Dependencias (`pubspec.yaml`):**
    - [X] Añadir dependencias principales:
        - [X] `flutter_bloc` (Para BLoC/Cubit)
        - [X] `freezed_annotation` (Para modelos y estados inmutables)
        - [X] `get_it` (Para Inyección de Dependencias)
        - [X] `equatable` (Para comparación de objetos, útil con BLoC/estados)
        - [X] `go_router` (Para navegación avanzada y declarativa)
        - [X] `flutter_svg` (Para manejo de imágenes vectoriales e iconos)
        - [X] `intl` (Para formateo de fechas y horas, esencial para una app de agendamiento)
        - [X] `cached_network_image` (Para carga eficiente de imágenes con caché)
    - [X] Añadir dependencias de desarrollo (`dev_dependencies`):
        - [X] `build_runner` (Para generación de código)
        - [X] `freezed` (Generador para `freezed_annotation`)
        - [X] `flutter_lints` (o linter preferido) para análisis estático.
    - [X] Ejecutar `flutter pub get` para descargar las dependencias.

5.  **Configuración de Generación de Código (`build_runner`):**
    - [X] Asegurarse de que `build_runner` y `freezed` están en `dev_dependencies`.
    - [X] (Opcional) Crear un script o alias para ejecutar `flutter pub run build_runner build --delete-conflicting-outputs`.

6.  **Configuración `main.dart`:**
    - [X] Limpiar el `main.dart` generado por defecto.
    - [X] Configurar la inicialización básica (ej. `WidgetsFlutterBinding.ensureInitialized()`).
    - [X] Configurar la inicialización de GetIt (Service Locator).
    - [X] Crear y usar un widget `App` raíz (ej. `MaterialApp` o `CupertinoApp`).
    - [X] Aplicar el `ThemeData` definido.
    - [X] Configurar el sistema de rutas inicial (si se usa `go_router` o similar).
    - [X] Configurar BlocObserver para depuración en modo desarrollo.
    - [X] Implementar estructura básica de navegación con go_router.
    - [X] Añadir pantalla inicial o splash screen básico.

7.  **Definición del Tema (`AppTheme`):**
    - [X] Crear `lib/core/theme/app_theme.dart`.
    - [X] Definir la paleta de colores principal (azul marino, dorado, grises, etc.) según `PLANNING.MD`.
    - [X] Definir la tipografía (fuentes, tamaños, pesos).
    - [X] Crear el `ThemeData` (modo oscuro) con los colores y tipografía.
    - [X] Definir estilos específicos para widgets comunes (AppBar, Button, Card, TextField, etc.).
    - [X] Implementar el tema proporcionado con todas las configuraciones detalladas (colores con opacidad, estilos de componentes, etc.).
    - [X] Añadir archivo separado para constantes de tema (`lib/core/theme/app_theme_constants.dart`).

8.  **Configuración de Inyección de Dependencias (`GetIt`):**
    - [X] Crear `lib/core/di/injection_container.dart` (o `service_locator.dart`).
    - [X] Crear la función `init()` (o `initializeDependencies()`) para inicializar GetIt.
    - [X] Llamar a `init()` en `main.dart` antes de `runApp()`.

9.  **Configuración del Linter:**
    - [X] Crear o configurar el archivo `analysis_options.yaml`.
    - [X] Activar `flutter_lints` o un conjunto de reglas preferido.
    - [X] (Opcional) Añadir reglas personalizadas.

10. **Commit Final de Configuración:**
    - [X] Verificar que toda la estructura de carpetas sigue las directrices de Clean Architecture.
    - [X] Asegurar que el archivo `.gitignore` incluye todos los archivos generados relevantes.
    - [X] Añadir todos los cambios (`git add .`).
    - [X] Realizar un commit (`git commit -m "feat: configure project base structure, dependencies, theme, DI, and linter"`).
    - [X] Subir cambios al repositorio remoto (`git push`).

11. **Configuración de Assets y Recursos:**
    - [X] Crear carpeta `assets/` en la raíz del proyecto.
    - [X] Crear subcarpetas para organizar los recursos:
        - [X] `assets/images/` (Para imágenes bitmap)
        - [X] `assets/icons/` (Para iconos SVG)
        - [X] `assets/fonts/` (Para tipografías personalizadas si se requieren)
    - [X] Configurar `pubspec.yaml` para incluir las carpetas de assets:
        ```yaml
        flutter:
          assets:
            - assets/images/
            - assets/icons/
        ```
    - [X] Preparar estructura para recursos visuales (se añadirán en etapas posteriores).

**Resultado Esperado:**
