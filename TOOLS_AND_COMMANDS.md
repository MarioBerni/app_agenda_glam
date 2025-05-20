# Comandos Esenciales: Agenda Glam

Los comandos más importantes para el desarrollo diario de Agenda Glam.

---

## Desarrollo Diario

```bash
# Obtener/actualizar dependencias
flutter pub get
flutter pub upgrade

# Analizar y formatear código
flutter analyze
dart format .

# Regenerar código
flutter pub run build_runner build --delete-conflicting-outputs

# Ejecutar aplicación
flutter run
```

## Testing y Verificación

```bash
# Ejecutar tests
flutter test

# Verificar archivos >300 líneas
Get-ChildItem -Recurse -Path lib -Filter "*.dart" | ForEach-Object { 
    $lineCount = (Get-Content $_.FullName | Measure-Object -Line).Lines
    if ($lineCount -gt 300) {
        Write-Output "$($_.FullName): $lineCount líneas"
    }
}
```

## Builds

```bash
# APK de release
flutter build apk --release

# Web optimizada
flutter build web --release
```

## Mantenimiento

```bash
# Actualizar Flutter
flutter upgrade

# Verificar configuración
flutter doctor

# Verificar versión
flutter --version

# Limpiar proyecto
flutter clean
```

---

Referencia concisa para el desarrollo diario de Agenda Glam.
