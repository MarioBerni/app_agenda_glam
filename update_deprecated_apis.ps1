# Script para actualizar APIs deprecadas de Flutter
# Este script reemplaza llamadas a métodos y propiedades deprecadas con las alternativas modernas recomendadas

# Establecer la codificación para manejar correctamente caracteres especiales
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "Iniciando actualización de APIs deprecadas..." -ForegroundColor Cyan

# Directorio raíz del proyecto
$projectRoot = "C:\Users\59898\OneDrive\2025\app_agenda_glam"

# Obtener todos los archivos .dart del proyecto
$dartFiles = Get-ChildItem -Path $projectRoot -Filter "*.dart" -Recurse -File

Write-Host "Encontrados $($dartFiles.Count) archivos Dart para procesar." -ForegroundColor Yellow

# Contadores para seguimiento
$filesUpdated = 0
$totalReplacements = 0

foreach ($file in $dartFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    $originalContent = $content
    $replacementsInFile = 0
    
    # 1. Reemplazar withOpacity por withValues
    # Buscamos patrones como: color.withOpacity(0.5) y los reemplazamos por color.withValues(alpha: 0.5)
    $pattern = '\.withOpacity\(([^)]+)\)'
    $replacement = '.withValues(alpha: $1)'
    $newContent = $content -replace $pattern, $replacement
    
    if ($newContent -ne $content) {
        $content = $newContent
        $replacementsInFile++
    }
    
    # 2. Reemplazar colorScheme.onBackground por colorScheme.onSurface
    $pattern = '\.colorScheme\.onBackground'
    $replacement = '.colorScheme.onSurface'
    $newContent = $content -replace $pattern, $replacement
    
    if ($newContent -ne $content) {
        $content = $newContent
        $replacementsInFile++
    }
    
    # 3. Reemplazar .red, .green, .blue por .r, .g, .b
    $patterns = @(
        @{Pattern = '\.red\b'; Replacement = '.r'},
        @{Pattern = '\.green\b'; Replacement = '.g'},
        @{Pattern = '\.blue\b'; Replacement = '.b'}
    )
    
    foreach ($p in $patterns) {
        $newContent = $content -replace $p.Pattern, $p.Replacement
        if ($newContent -ne $content) {
            $content = $newContent
            $replacementsInFile++
        }
    }
    
    # Si hubo cambios, actualizar el archivo
    if ($content -ne $originalContent) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        $filesUpdated++
        $totalReplacements += $replacementsInFile
        Write-Host "✅ Actualizado: $($file.FullName) ($replacementsInFile reemplazos)" -ForegroundColor Green
    }
}

Write-Host "`nResumen de la actualización:" -ForegroundColor Cyan
Write-Host "- Archivos procesados: $($dartFiles.Count)" -ForegroundColor White
Write-Host "- Archivos actualizados: $filesUpdated" -ForegroundColor Green
Write-Host "- Total de reemplazos: $totalReplacements" -ForegroundColor Green
Write-Host "`nProceso completado. Ejecute 'flutter analyze' para verificar los resultados." -ForegroundColor Cyan
