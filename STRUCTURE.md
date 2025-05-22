# Estructura del Proyecto: Agenda Glam

**Propósito**: Este documento muestra la estructura completa de archivos y directorios del proyecto Agenda Glam. Sirve como mapa de navegación para desarrolladores y como referencia para entender la organización física del código.

## 🗂️ Árbol de Directorios

```
Directory structure:
└── marioberni-app_agenda_glam/
    ├── README.md                      # Introducción y punto de entrada al proyecto
    ├── analysis_options.yaml         # Configuración de análisis y linting
    ├── ARCHITECTURE.MD               # Arquitectura técnica detallada
    ├── PLANNING.MD                   # Visión y planificación general
    ├── STRUCTURE.md                  # Este archivo - Estructura del proyecto
    ├── pubspec.lock                  # Versiones bloqueadas de dependencias
    ├── pubspec.yaml                  # Definición de dependencias y metadatos
    ├── TESTING.MD
    ├── TOOLS_AND_COMMANDS.md
    ├── UI_COMPONENTS.md
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
    │   │   │   ├── app_router.dart
    │   │   │   ├── bubble_page_route.dart
    │   │   │   ├── circle_navigation.dart
    │   │   │   └── circle_page_route.dart
    │   │   ├── theme/
    │   │   │   ├── app_theme.dart
    │   │   │   └── app_theme_constants.dart
    │   │   ├── utils/
    │   │   │   ├── color_extensions.dart
    │   │   │   └── responsive_utils.dart
    │   │   └── widgets/
    │   │       ├── glam_divider.dart
    │   │       ├── glam_gradient_background.dart
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
    │                   ├── register_content.dart
    │                   ├── register_footer.dart
    │                   ├── register_header.dart
    │                   ├── register_password_step.dart
    │                   ├── register_personal_info_step.dart
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
    │   ├── TASK_FlujoAutenticacionUI.MD
    │   └── TASK_OptimizacionComponentesVisuales.MD
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