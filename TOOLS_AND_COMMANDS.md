# Herramientas y Comandos para Desarrollo: Agenda Glam

Este documento centraliza todos los comandos y herramientas útiles para el análisis, prueba, depuración y optimización del proyecto Agenda Glam. Está organizado por categorías funcionales para facilitar su consulta durante el desarrollo.

## 📋 Índice

- [Análisis de Código y Calidad](#análisis-de-código-y-calidad)
- [Rendimiento y Optimización](#rendimiento-y-optimización)
- [Testing y Cobertura](#testing-y-cobertura)
- [Integración Continua y Builds](#integración-continua-y-builds)
- [Depuración Avanzada](#depuración-avanzada)
- [Herramientas UI y Visualización](#herramientas-ui-y-visualización)

---

## Análisis de Código y Calidad

### Flutter Analyze

```bash
flutter analyze
```

**Objetivo**: Realizar análisis estático del código para identificar problemas potenciales.

**Resultado**: Reporte de errores, warnings y lints que incumplen las reglas definidas en `analysis_options.yaml`.

**Configuración previa**: 
- El archivo `analysis_options.yaml` debe estar configurado en la raíz del proyecto.
- Respeta las reglas de estilo definidas en la arquitectura del proyecto.

**Sugerencia de uso**: Ejecutar antes de cada commit para mantener la calidad del código.

### Dart Format

```bash
# Formatear todo el proyecto
dart format .

# Formatear un archivo específico
dart format lib/main.dart

# Verificar formato sin modificar archivos
dart format --output=none --set-exit-if-changed .
```

**Objetivo**: Formatear automáticamente el código según convenciones de Dart.

**Resultado**: Archivos con formato consistente. El último comando es útil para CI pues falla si hay archivos mal formateados.

**Configuración previa**: Ninguna específica, usa las reglas estándar de formato de Dart.

### Verificador de Tamaño de Archivos

```bash
# Para Windows (PowerShell)
Get-ChildItem -Recurse -Path lib -Filter "*.dart" | ForEach-Object { 
    $lineCount = (Get-Content $_.FullName | Measure-Object -Line).Lines
    if ($lineCount -gt 300) {
        Write-Output "$($_.FullName): $lineCount líneas"
    }
}

# Para entornos Linux/Mac
find lib -name "*.dart" | xargs wc -l | sort -nr
```

**Objetivo**: Identificar archivos Dart que exceden el límite de 300 líneas establecido en el proyecto.

**Resultado**: Lista de archivos con su número de líneas, ordenados por tamaño.

**Sugerencia de uso**: Ejecutar periódicamente para mantener los archivos dentro del límite establecido. Los archivos que excedan las 300 líneas deben ser refactorizados.

### Dependency Validator

```bash
# Instalar dependency validator
flutter pub global activate dependency_validator

# Verificar dependencias
flutter pub global run dependency_validator
```

**Objetivo**: Verificar inconsistencias en dependencias del proyecto.

**Resultado**: Identifica dependencias no utilizadas, dependencias faltantes en el pubspec, y referencias directas a paquetes transitivos.

**Configuración previa**: Requiere activar el paquete globalmente.

---

## Rendimiento y Optimización

### Flutter Run con Perfil

```bash
flutter run --profile
```

**Objetivo**: Ejecutar la aplicación en modo perfil, optimizado para análisis de rendimiento.

**Resultado**: La aplicación se ejecuta con optimizaciones cercanas a producción, pero mantiene capacidades de perfilado.

**Cuándo usar**: Para medir rendimiento real de la app mientras aún permite conectar herramientas de análisis como DevTools.

**Limitación**: Solo disponible para dispositivos físicos, no funciona en emuladores.

### Flutter Run en Modo Release

```bash
flutter run --release
```

**Objetivo**: Ejecutar la aplicación completamente optimizada como en producción.

**Resultado**: Aplicación con máximo rendimiento, sin instrumentación de debug/perfil.

**Cuándo usar**: Para pruebas finales de rendimiento y experiencia de usuario.

**Limitación**: No permite depuración ni análisis de rendimiento con herramientas externas.

### Flutter DevTools

```bash
# Activar DevTools (solo necesario una vez)
flutter pub global activate devtools

# Ejecutar DevTools de forma independiente
flutter pub global run devtools

# O ejecutar la app con DevTools
flutter run --debug
# Cuando la app esté ejecutando, presionar "d" en la consola para abrir DevTools
```

**Objetivo**: Proporcionar una suite completa de herramientas para análisis, depuración y optimización.

**Resultado**: Interfaz web con múltiples herramientas:
- **Inspector de Widgets**: Examinar y modificar el árbol de widgets
- **Timeline**: Analizar frames y detectar jank (tartamudeos)
- **Memory**: Monitorear y encontrar fugas de memoria
- **Performance**: Analizar uso de CPU y renderizado
- **Network**: Monitorear peticiones de red
- **Logging**: Ver y filtrar logs de la aplicación

**Configuración previa**: 
- La app debe estar en modo debug o profile
- Se puede integrar directamente con VS Code o Android Studio

**Guardar resultados**: En la pestaña Performance se pueden exportar perfiles en formato JSON para análisis posterior.

### Performance Overlay

```dart
// Agregar al MaterialApp en main.dart
MaterialApp(
  showPerformanceOverlay: true,
  // ...resto de configuración
);
```

**Objetivo**: Mostrar una visualización en tiempo real del rendimiento de la interfaz.

**Resultado**: Superposición en pantalla con dos gráficos:
1. UI Thread: Muestra el tiempo de construcción de widgets y layout
2. Raster Thread: Muestra el tiempo de renderizado (pintar en pantalla)

**Interpretación**: Barras que cruzan la línea central indican frames tardíos (jank).

**Cuándo usar**: Durante el desarrollo de animaciones complejas o cuando se sospecha de problemas de rendimiento UI.

### Flutter Trace Events

```bash
flutter run --trace-startup --profile
```

**Objetivo**: Medir el tiempo de inicio de la aplicación y trazar eventos clave.

**Resultado**: Registro de tiempos para eventos de inicialización como precalentamiento de VM, carga de recursos, etc.

---

## Testing y Cobertura

### Ejecutar Tests

```bash
# Ejecutar todos los tests
flutter test

# Ejecutar un archivo específico de test
flutter test test/features/auth/domain/usecases/login_user_test.dart

# Ejecutar todos los tests de un directorio
flutter test test/features/auth/
```

**Objetivo**: Verificar el correcto funcionamiento del código mediante pruebas automatizadas.

**Resultado**: Reporte de tests ejecutados, aprobados y fallidos.

**Estructura recomendada**: Organizar los tests siguiendo la misma estructura de carpetas del código, respetando la arquitectura por features.

### Tests con Cobertura

```bash
# Ejecutar tests con cobertura
flutter test --coverage

# Generar reporte HTML (requiere lcov)
genhtml coverage/lcov.info -o coverage/html

# Abrir reporte en navegador (Windows PowerShell)
Start-Process "coverage/html/index.html"
```

**Objetivo**: Medir qué porcentaje del código está cubierto por tests.

**Resultado**: 
- Archivo `lcov.info` con datos de cobertura
- Reporte HTML que muestra visualmente las líneas cubiertas y no cubiertas

**Configuración previa**: 
- Para generar el reporte HTML, instalar lcov:
  - Windows: a través de Chocolatey `choco install lcov`
  - Mac: `brew install lcov`
  - Linux: `sudo apt install lcov`

**Interpretación**: Buscar áreas con baja cobertura, especialmente en la capa de dominio (lógica de negocio).

### Golden Tests (Tests Visuales)

```bash
# Ejecutar solo golden tests
flutter test --tags=golden

# Actualizar archivos golden
flutter test --update-goldens
```

**Objetivo**: Verificar que los widgets se renderizan visualmente como se espera.

**Resultado**: Comparación píxel por píxel entre el renderizado actual y una imagen de referencia.

**Configuración previa**: 
- Crear archivos de test que generen imágenes golden
- Estructura recomendada: `test/features/auth/presentation/widgets/login_button_golden_test.dart`

---

## Integración Continua y Builds

### Analizar para CI

```bash
flutter analyze --no-fatal-infos --no-fatal-warnings
```

**Objetivo**: Analizar código pero evitar que warnings menores rompan la pipeline de CI.

**Resultado**: Reporte de errores y warnings, pero solo falla si hay errores graves.

### Construir APK para Android

```bash
# APK de desarrollo
flutter build apk --debug

# APK de release
flutter build apk --release

# APK split por ABI (más eficiente)
flutter build apk --split-per-abi --release
```

**Objetivo**: Generar archivos APK para distribución o testing en Android.

**Resultado**: 
- APK en `build/app/outputs/flutter-apk/`
- Con split-per-abi: APKs específicas para diferentes arquitecturas (arm64-v8a, armeabi-v7a, x86_64)

**Consideraciones**:
- El modo release requiere configurar signing en `android/app/build.gradle`
- APKs separadas por ABI son más pequeñas pero específicas para cada arquitectura

### Construir para iOS

```bash
# Build para iOS (requiere Mac)
flutter build ios --release

# Para TestFlight
flutter build ipa
```

**Objetivo**: Generar archivo IPA para distribución o testing en iOS.

**Resultado**: Archivo IPA en `build/ios/ipa/`.

**Configuración previa**: 
- Requiere Mac con Xcode
- Configurar signing en Xcode
- Para TestFlight, configurar versión en `pubspec.yaml`

### Construir para Web

```bash
flutter build web --release

# Para optimización web específica
flutter build web --web-renderer canvaskit --release
# Alternativas: --web-renderer html, --web-renderer auto
```

**Objetivo**: Generar versión web optimizada de la aplicación.

**Resultado**: Archivos web en `build/web/`.

**Renderers disponibles**:
- **html**: Menor tamaño inicial, mejor para conexiones lentas
- **canvaskit**: Mejor fidelidad visual y rendimiento, especialmente para animaciones complejas
- **auto**: El navegador decide basado en el dispositivo

---

## Depuración Avanzada

### Flutter Doctor

```bash
# Verificación básica
flutter doctor

# Verificación detallada
flutter doctor -v
```

**Objetivo**: Diagnosticar problemas en la instalación y configuración del entorno Flutter.

**Resultado**: Reporte detallado del estado de:
- Flutter SDK
- Android toolchain
- Xcode (en Mac)
- Chrome y herramientas web
- VS Code/Android Studio
- Dispositivos conectados

**Cuándo usar**: Al configurar un nuevo entorno o cuando hay problemas para ejecutar la aplicación.

### Flutter Clean y Reconstrucción

```bash
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

**Objetivo**: Resolver problemas relacionados con caché, generación de código y dependencias.

**Resultado**: Eliminación de archivos generados y reconstrucción limpia del proyecto.

**Cuándo usar**: 
- Después de cambios importantes en el código generado (freezed, json_serializable)
- Cuando aparecen errores extraños de compilación
- Al cambiar significativamente las dependencias

### Inspección de Dependencias

```bash
# Listar todas las dependencias
flutter pub deps

# Formato compacto
flutter pub deps --style=compact

# Solo dependencias de desarrollo
flutter pub deps --dev-dependencies
```

**Objetivo**: Visualizar el árbol de dependencias del proyecto.

**Resultado**: Lista jerárquica de todas las dependencias directas y transitivas.

**Cuándo usar**: Para entender conflictos de dependencias o analizar el tamaño de las mismas.

### Logs de Flutter

```bash
# En PowerShell
flutter logs

# Filtrar logs
flutter logs | Select-String "BLoC"
```

**Objetivo**: Ver los logs de la aplicación en tiempo real.

**Resultado**: Stream continuo de logs desde la aplicación en ejecución.

**Cuándo usar**: Durante desarrollo activo o debugging de problemas específicos.

---

## Herramientas UI y Visualización

### Flutter Stetho (Para Android con Chrome)

```yaml
# Añadir a pubspec.yaml
dependencies:
  flutter_stetho: ^0.6.0
```

```dart
// En main.dart antes de runApp
void main() {
  Stetho.initialize();
  runApp(MyApp());
}
```

**Objetivo**: Conectar la app Flutter a Chrome DevTools para inspección avanzada.

**Resultado**: Permite ver:
- Logs
- Base de datos SQLite
- Peticiones de red
- Jerarquía de vistas

**Configuración previa**:
1. Añadir dependencia en pubspec.yaml
2. Inicializar en main.dart
3. Conectar dispositivo Android
4. Abrir chrome://inspect en Chrome

**Limitación**: Solo funciona en Android.

### Flutter Performance Monitor

```yaml
# Añadir a pubspec.yaml
dependencies:
  flutter_performance_monitor: ^1.0.4
```

```dart
// Activar monitor en cualquier lugar de la app
PerformanceMonitor().start();
```

**Objetivo**: Mostrar estadísticas de rendimiento directamente en la app.

**Resultado**: Overlay visual con:
- FPS actual
- Uso de CPU
- Uso de memoria
- Tiempo de frame

**Cuándo usar**: Durante desarrollo para identificar problemas de rendimiento en tiempo real.

### Timeline Events Personalizados

```dart
import 'dart:developer' as developer;

void funcionCostosa() {
  developer.Timeline.startSync('Operación costosa');
  try {
    // Código a medir
  } finally {
    developer.Timeline.finishSync();
  }
}
```

**Objetivo**: Crear marcadores personalizados en la timeline de DevTools.

**Resultado**: Secciones identificables en la timeline de DevTools para análisis detallado.

**Visualización**: Los eventos aparecen en la pestaña Performance de DevTools.

### Inspección de Provider/BLoC

```yaml
# Añadir a pubspec.yaml (si usas provider)
dev_dependencies:
  provider_debugger: ^1.0.0
```

```dart
// Para BLoC, ya incluye su propia herramienta de debug
BlocOverrides.runZoned(
  () => runApp(MyApp()),
  blocObserver: AppBlocObserver(),
);
```

**Objetivo**: Facilitar la depuración de estados y cambios en Provider o BLoC.

**Resultado**: 
- Para Provider: Widget en pantalla mostrando estados actuales
- Para BLoC: Logs detallados de transiciones de estado a través de AppBlocObserver

**Configuración previa**:
- Provider: Añadir paquete provider_debugger
- BLoC: Implementar AppBlocObserver personalizado

**Recomendación**: En producción, desactivar estas herramientas de debug o configurarlas para que solo se activen en modo desarrollo.

---

Este documento será actualizado con nuevas herramientas y comandos a medida que el proyecto evolucione. Si encuentras una herramienta útil, por favor considera añadirla a esta lista.
