# Estructura del Proyecto: Agenda Glam

**Propósito**: Este documento muestra la estructura completa de archivos y directorios del proyecto Agenda Glam. Sirve como mapa de navegación para desarrolladores y como referencia para entender la organización física del código.

## 🗂️ Árbol de Directorios

```
Directory structure:
└── marioberni-app_agenda_glam/
    ├── README.md
    ├── analysis_options.yaml
    ├── ARCHITECTURE.MD
    ├── NAVIGATION_GUIDE.md
    ├── PLANNING.MD
    ├── pubspec.lock
    ├── pubspec.yaml
    ├── STRUCTURE.md
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
    │   │   │   ├── animation_presets.dart
    │   │   │   └── glam_animations.dart
    │   │   ├── di/
    │   │   │   └── service_locator.dart
    │   │   ├── routes/
    │   │   │   ├── app_page_transitions.dart
    │   │   │   ├── app_router.dart
    │   │   │   ├── bubble_page_route.dart
    │   │   │   ├── circle_navigation.dart
    │   │   │   ├── circle_page_route.dart
    │   │   │   └── routes/
    │   │   │       ├── app_routes.dart
    │   │   │       ├── auth_routes.dart
    │   │   │       ├── main_routes.dart
    │   │   │       ├── splash_route.dart
    │   │   │       └── transitions_helpers.dart
    │   │   ├── theme/
    │   │   │   ├── app_theme.dart
    │   │   │   ├── app_theme_constants.dart
    │   │   │   └── colors.dart
    │   │   ├── utils/
    │   │   │   ├── color_extensions.dart
    │   │   │   ├── color_utils.dart
    │   │   │   └── responsive_utils.dart
    │   │   └── widgets/
    │   │       ├── glam_bottom_navigation_bar.dart
    │   │       ├── glam_divider.dart
    │   │       ├── glam_gradient_background.dart
    │   │       ├── glam_icon_container.dart
    │   │       ├── glam_scaffold.dart
    │   │       ├── glam_text_field.dart
    │   │       ├── glam_ui.dart
    │   │       └── main_scaffold.dart
    │   └── features/
    │       ├── auth/
    │       │   ├── data/
    │       │   │   ├── datasources/
    │       │   │   │   └── auth_mock_datasource.dart
    │       │   │   ├── models/
    │       │   │   │   └── user_model.dart
    │       │   │   └── repositories/
    │       │   │       └── auth_repository_impl.dart
    │       │   ├── domain/
    │       │   │   ├── entities/
    │       │   │   │   ├── credentials.dart
    │       │   │   │   └── user.dart
    │       │   │   ├── repositories/
    │       │   │   │   └── auth_repository.dart
    │       │   │   └── validators/
    │       │   │       ├── recovery_validator.dart
    │       │   │       └── register_validator.dart
    │       │   └── presentation/
    │       │       ├── bloc/
    │       │       │   ├── auth_cubit.dart
    │       │       │   └── auth_state.dart
    │       │       ├── controllers/
    │       │       │   ├── google_register_controller.dart
    │       │       │   ├── recovery_controller.dart
    │       │       │   ├── register_controller.dart
    │       │       │   └── register_google_handler.dart
    │       │       ├── helpers/
    │       │       │   ├── verification_service.dart
    │       │       │   └── verification_timer_helper.dart
    │       │       ├── pages/
    │       │       │   ├── google_register_additional_info_page.dart
    │       │       │   ├── login_page.dart
    │       │       │   ├── phone_register_additional_info_page.dart
    │       │       │   ├── phone_register_page.dart
    │       │       │   ├── phone_verification_page.dart
    │       │       │   ├── recovery_page.dart
    │       │       │   ├── register_page.dart
    │       │       │   ├── sms_code_verification_page.dart
    │       │       │   ├── welcome_page.dart
    │       │       │   ├── welcome_page_refactored.dart
    │       │       │   └── welcome_page_updated.dart
    │       │       └── widgets/
    │       │           ├── action_buttons_widget.dart
    │       │           ├── action_card.dart
    │       │           ├── featured_partners_section.dart
    │       │           ├── glam_button.dart
    │       │           ├── glam_google_button.dart
    │       │           ├── glam_logo.dart
    │       │           ├── glam_password_field.dart
    │       │           ├── glam_scissors_icon.dart
    │       │           ├── glam_terms_dialog.dart
    │       │           ├── glam_text_field.dart
    │       │           ├── glam_video_background.dart
    │       │           ├── google_register_header_widget.dart
    │       │           ├── google_register_info_form.dart
    │       │           ├── login_form.dart
    │       │           ├── login_header.dart
    │       │           ├── password_strength_indicator.dart
    │       │           ├── phone_input_widget.dart
    │       │           ├── popular_services_section.dart
    │       │           ├── recovery_confirmation.dart
    │       │           ├── recovery_content.dart
    │       │           ├── recovery_header.dart
    │       │           ├── register_auth_method_step.dart
    │       │           ├── register_content.dart
    │       │           ├── register_footer.dart
    │       │           ├── register_header.dart
    │       │           ├── register_password_step.dart
    │       │           ├── register_personal_info_step.dart
    │       │           ├── register_step_indicator.dart
    │       │           ├── terms_checkbox.dart
    │       │           ├── user_type_selector_widget.dart
    │       │           ├── verification_code_input_widget.dart
    │       │           ├── welcome_header.dart
    │       │           └── welcome_components/
    │       │               ├── featured_partners_section.dart
    │       │               ├── parallax_background.dart
    │       │               ├── welcome_actions.dart
    │       │               └── welcome_header.dart
    │       ├── benefits/
    │       │   └── presentation/
    │       │       └── pages/
    │       │           └── benefits_page.dart
    │       ├── explore/
    │       │   ├── domain/
    │       │   │   └── models/
    │       │   │       ├── service.dart
    │       │   │       ├── service_category.dart
    │       │   │       └── service_item.dart
    │       │   └── presentation/
    │       │       ├── cubit/
    │       │       │   ├── explore_cubit.dart
    │       │       │   └── explore_state.dart
    │       │       ├── pages/
    │       │       │   └── explore_page.dart
    │       │       └── widgets/
    │       │           ├── category_filter.dart
    │       │           ├── service_card.dart
    │       │           └── service_list.dart
    │       ├── partners/
    │       │   ├── data/
    │       │   │   └── models/
    │       │   │       └── partner_data.dart
    │       │   ├── domain/
    │       │   │   └── entities/
    │       │   │       └── partner.dart
    │       │   └── presentation/
    │       │       └── widgets/
    │       │           └── partners_carousel.dart
    │       └── profile/
    │           └── presentation/
    │               └── pages/
    │                   └── profile_page.dart
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
    │   ├── TASK_ActualizacionAPIColor.MD
    │   ├── TASK_CarouselYExploraciónSinRegistro.MD
    │   ├── TASK_ConfiguracionInicial.MD
    │   ├── TASK_DiseñoAutenticacionUI.MD
    │   ├── TASK_FlujoAutenticacionUI.MD
    │   ├── TASK_ImplementacionBarraNavegacionInferior.MD
    │   ├── TASK_OptimizacionComponentesVisuales.MD
    │   ├── TASK_RegistroGoogleMejorado.MD
    │   └── TASK_TerminosCondicionesRegistro.MD
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

