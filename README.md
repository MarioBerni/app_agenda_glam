# Agenda Glam

Aplicación móvil para la gestión de servicios de estética dirigidos al público masculino en Uruguay. Desarrollada con Flutter siguiendo los principios de Clean Architecture.

## 📋 Documentación del Proyecto

### Documentos Principales

| Documento | Descripción |
|-----------|-------------|
| [**PLANNING.MD**](./PLANNING.MD) | Visión general, alcance, público objetivo, funcionalidades clave y directrices de desarrollo del proyecto. Documento de referencia principal para entender el propósito y enfoque global. |
| [**ARCHITECTURE.MD**](./ARCHITECTURE.MD) | Arquitectura técnica detallada, estructura del proyecto, patrones de diseño, y sistemas clave (BLoC/Cubit, GetIt, Routing). Guía de referencia para decisiones de implementación. |

### Tareas y Progreso

Las tareas específicas se documentan en la carpeta `/tasks/` con archivos `TASK_nombre_tarea.MD`. Cada archivo detalla los objetivos, pasos, consideraciones y progreso de una funcionalidad o módulo específico.

| Tarea Completada | Descripción |
|------------------|-------------|
| [**TASK_ConfiguracionInicial.MD**](./tasks/TASK_ConfiguracionInicial.MD) | Configuración base del proyecto, dependencias, estructura de carpetas y tema. |
| [**TASK_DiseñoAutenticacionUI.MD**](./tasks/TASK_DiseñoAutenticacionUI.MD) | Refinamiento visual del flujo de autenticación, animaciones y experiencia de usuario. |
| [**TASK_FlujoAutenticacionUI.MD**](./tasks/TASK_FlujoAutenticacionUI.MD) | Implementación de pantallas y lógica UI para el proceso de autenticación. |

## 🗂️ Estructura del Proyecto

```
Directory structure:
└── marioberni-app_agenda_glam/
    ├── README.md
    ├── analysis_options.yaml
    ├── ARCHITECTURE.MD
    ├── PLANNING.MD
    ├── pubspec.lock
    ├── pubspec.yaml
    ├── TOOLS_AND_COMMANDS.md
    ├── update_deprecated_apis.ps1
    ├── .metadata
    ├── .windsurfrules
    ├── android/
    │   ├── build.gradle.kts
    │   ├── gradle.properties
    │   ├── settings.gradle.kts
    │   ├── .gitignore
    │   ├── app/
    │   │   ├── build.gradle.kts
    │   │   └── src/
    │   │       ├── debug/
    │   │       │   └── AndroidManifest.xml
    │   │       ├── main/
    │   │       │   ├── AndroidManifest.xml
    │   │       │   ├── kotlin/
    │   │       │   │   └── com/
    │   │       │   │       └── example/
    │   │       │   │           └── app_agenda_glam/
    │   │       │   │               └── MainActivity.kt
    │   │       │   └── res/
    │   │       │       ├── drawable/
    │   │       │       │   └── launch_background.xml
    │   │       │       ├── drawable-v21/
    │   │       │       │   └── launch_background.xml
    │   │       │       ├── mipmap-hdpi/
    │   │       │       ├── mipmap-mdpi/
    │   │       │       ├── mipmap-xhdpi/
    │   │       │       ├── mipmap-xxhdpi/
    │   │       │       ├── mipmap-xxxhdpi/
    │   │       │       ├── values/
    │   │       │       │   └── styles.xml
    │   │       │       └── values-night/
    │   │       │           └── styles.xml
    │   │       └── profile/
    │   │           └── AndroidManifest.xml
    │   └── gradle/
    │       └── wrapper/
    │           └── gradle-wrapper.properties
    ├── assets/
    │   ├── images/
    │   │   └── auth/
    │   └── videos/
    ├── ios/
    │   ├── .gitignore
    │   ├── Flutter/
    │   │   ├── AppFrameworkInfo.plist
    │   │   ├── Debug.xcconfig
    │   │   └── Release.xcconfig
    │   ├── Runner/
    │   │   ├── AppDelegate.swift
    │   │   ├── Info.plist
    │   │   ├── Runner-Bridging-Header.h
    │   │   ├── Assets.xcassets/
    │   │   │   ├── AppIcon.appiconset/
    │   │   │   │   └── Contents.json
    │   │   │   └── LaunchImage.imageset/
    │   │   │       ├── README.md
    │   │   │       └── Contents.json
    │   │   └── Base.lproj/
    │   │       ├── LaunchScreen.storyboard
    │   │       └── Main.storyboard
    │   ├── Runner.xcodeproj/
    │   │   ├── project.pbxproj
    │   │   ├── project.xcworkspace/
    │   │   │   ├── contents.xcworkspacedata
    │   │   │   └── xcshareddata/
    │   │   │       ├── IDEWorkspaceChecks.plist
    │   │   │       └── WorkspaceSettings.xcsettings
    │   │   └── xcshareddata/
    │   │       └── xcschemes/
    │   │           └── Runner.xcscheme
    │   ├── Runner.xcworkspace/
    │   │   ├── contents.xcworkspacedata
    │   │   └── xcshareddata/
    │   │       ├── IDEWorkspaceChecks.plist
    │   │       └── WorkspaceSettings.xcsettings
    │   └── RunnerTests/
    │       └── RunnerTests.swift
    ├── lib/
    │   ├── main.dart
    │   ├── core/
    │   │   ├── animations/
    │   │   │   └── animation_presets.dart
    │   │   ├── di/
    │   │   │   └── service_locator.dart
    │   │   ├── routes/
    │   │   │   ├── app_page_transitions.dart
    │   │   │   └── app_router.dart
    │   │   ├── theme/
    │   │   │   ├── app_theme.dart
    │   │   │   └── app_theme_constants.dart
    │   │   ├── utils/
    │   │   │   └── color_extensions.dart
    │   │   └── widgets/
    │   │       ├── glam_divider.dart
    │   │       ├── glam_icon_container.dart
    │   │       ├── glam_scaffold.dart
    │   │       ├── glam_text_field.dart
    │   │       └── glam_ui.dart
    │   └── features/
    │       └── auth/
    │           ├── data/
    │           │   ├── datasources/
    │           │   │   └── auth_mock_datasource.dart
    │           │   ├── models/
    │           │   │   └── user_model.dart
    │           │   └── repositories/
    │           │       └── auth_repository_impl.dart
    │           ├── domain/
    │           │   ├── entities/
    │           │   │   ├── credentials.dart
    │           │   │   └── user.dart
    │           │   ├── repositories/
    │           │   │   └── auth_repository.dart
    │           │   └── validators/
    │           │       ├── recovery_validator.dart
    │           │       └── register_validator.dart
    │           └── presentation/
    │               ├── bloc/
    │               │   ├── auth_cubit.dart
    │               │   └── auth_state.dart
    │               ├── controllers/
    │               │   ├── recovery_controller.dart
    │               │   └── register_controller.dart
    │               ├── pages/
    │               │   ├── login_page.dart
    │               │   ├── recovery_page.dart
    │               │   ├── register_page.dart
    │               │   └── welcome_page.dart
    │               └── widgets/
    │                   ├── glam_background.dart
    │                   ├── glam_button.dart
    │                   ├── glam_logo.dart
    │                   ├── glam_password_field.dart
    │                   ├── glam_scissors_icon.dart
    │                   ├── glam_text_field.dart
    │                   ├── glam_video_background.dart
    │                   ├── login_form.dart
    │                   ├── login_header.dart
    │                   ├── password_strength_indicator.dart
    │                   ├── recovery_confirmation.dart
    │                   ├── recovery_content.dart
    │                   ├── recovery_header.dart
    │                   ├── recovery_scaffold.dart
    │                   ├── register_content.dart
    │                   ├── register_footer.dart
    │                   ├── register_header.dart
    │                   ├── register_password_step.dart
    │                   ├── register_personal_info_step.dart
    │                   ├── register_scaffold.dart
    │                   └── register_step_indicator.dart
    ├── linux/
    │   ├── CMakeLists.txt
    │   ├── .gitignore
    │   ├── flutter/
    │   │   ├── CMakeLists.txt
    │   │   ├── generated_plugin_registrant.cc
    │   │   ├── generated_plugin_registrant.h
    │   │   └── generated_plugins.cmake
    │   └── runner/
    │       ├── CMakeLists.txt
    │       ├── main.cc
    │       ├── my_application.cc
    │       └── my_application.h
    ├── macos/
    │   ├── .gitignore
    │   ├── Flutter/
    │   │   ├── Flutter-Debug.xcconfig
    │   │   ├── Flutter-Release.xcconfig
    │   │   └── GeneratedPluginRegistrant.swift
    │   ├── Runner/
    │   │   ├── AppDelegate.swift
    │   │   ├── DebugProfile.entitlements
    │   │   ├── Info.plist
    │   │   ├── MainFlutterWindow.swift
    │   │   ├── Release.entitlements
    │   │   ├── Assets.xcassets/
    │   │   │   └── AppIcon.appiconset/
    │   │   │       └── Contents.json
    │   │   ├── Base.lproj/
    │   │   │   └── MainMenu.xib
    │   │   └── Configs/
    │   │       ├── AppInfo.xcconfig
    │   │       ├── Debug.xcconfig
    │   │       ├── Release.xcconfig
    │   │       └── Warnings.xcconfig
    │   ├── Runner.xcodeproj/
    │   │   ├── project.pbxproj
    │   │   ├── project.xcworkspace/
    │   │   │   └── xcshareddata/
    │   │   │       └── IDEWorkspaceChecks.plist
    │   │   └── xcshareddata/
    │   │       └── xcschemes/
    │   │           └── Runner.xcscheme
    │   ├── Runner.xcworkspace/
    │   │   ├── contents.xcworkspacedata
    │   │   └── xcshareddata/
    │   │       └── IDEWorkspaceChecks.plist
    │   └── RunnerTests/
    │       └── RunnerTests.swift
    ├── tasks/
    │   ├── TASK_ConfiguracionInicial.MD
    │   ├── TASK_DiseñoAutenticacionUI.MD
    │   └── TASK_FlujoAutenticacionUI.MD
    ├── web/
    │   ├── index.html
    │   ├── manifest.json
    │   └── icons/
    └── windows/
        ├── CMakeLists.txt
        ├── .gitignore
        ├── flutter/
        │   ├── CMakeLists.txt
        │   ├── generated_plugin_registrant.cc
        │   ├── generated_plugin_registrant.h
        │   └── generated_plugins.cmake
        └── runner/
            ├── CMakeLists.txt
            ├── flutter_window.cpp
            ├── flutter_window.h
            ├── main.cpp
            ├── resource.h
            ├── runner.exe.manifest
            ├── Runner.rc
            ├── utils.cpp
            ├── utils.h
            ├── win32_window.cpp
            ├── win32_window.h
            └── resources/

```

## 🚀 Comenzando con el Desarrollo

### Prerequisitos

- Flutter SDK (última versión estable)
- Dart SDK (compatible con la versión de Flutter)
- Editor recomendado: VS Code o Android Studio

### Instalación

1. Clona este repositorio
2. Ejecuta `flutter pub get` para instalar dependencias
3. Consulta los documentos PLANNING.MD y ARCHITECTURE.MD para familiarizarte con el proyecto

### Flujo de Desarrollo

1. Consulta el archivo `PLANNING.MD` para entender la visión general del proyecto
2. Revisa `ARCHITECTURE.MD` para comprender los principios técnicos y patrones a seguir
3. Para trabajar en una tarea específica:
   - Consulta el archivo TASK correspondiente en la carpeta `/tasks/`
   - Sigue los pasos detallados en ese documento
   - Actualiza el estado de las subtareas a medida que avanzas

## 📝 Convenciones para Nuevas Tareas

Al crear un nuevo archivo TASK para una funcionalidad, utiliza la siguiente estructura:

```markdown
# Tarea: [Nombre de la Tarea]

## Referencias
- **ARCHITECTURE.MD:** Sección X.X (Componente Relevante)
- **Tareas Relacionadas:** TASK_OtraTarea.MD
- **Estado:** [Pendiente/En Progreso/Completada]

## Objetivos
[...]

## Pasos
[...]

## Consideraciones
[...]
```

## 📚 Directrices Clave

- Los archivos de código (Dart) no deben exceder las **300 líneas**
- Seguir los principios de Clean Architecture
- Organización por features (módulos funcionales)
- Usar BLoC/Cubit para gestión de estado
- Desarrollo frontend con datos mock (primera fase)
- UI masculina elegante con tema oscuro
