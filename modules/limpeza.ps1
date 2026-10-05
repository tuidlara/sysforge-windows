Write-Host "=== LIMPEZA BASICA ==="

Write-Host ""

Write-Host "Limpando arquivos temporarios do usuario..."
Write-Host ""

$tempPath = $env:TEMP

$tempFilesBefore = @(Get-ChildItem -Path $tempPath -Force -ErrorAction SilentlyContinue)

$removedTemp = 0
$ignoredTemp = 0

foreach ($item in $tempFilesBefore) {
    try {
        Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
        $removedTemp++
    }
    catch {
        $ignoredTemp++
    }
}

Write-Host "Itens encontrados: $($tempFilesBefore.Count)"
Write-Host "Itens removidos: $removedTemp"
Write-Host "Itens ignorados: $ignoredTemp"

Write-Host ""

Write-Host "Limpando arquivos temporarios do Windows..."
Write-Host ""

$windowsTemp = "C:\Windows\Temp"

$windowsTempBefore = @(Get-ChildItem -Path $windowsTemp -Force -ErrorAction SilentlyContinue)

$removedWindowsTemp = 0
$ignoredWindowsTemp = 0

foreach ($item in $windowsTempBefore) {
    try {
        Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction Stop
        $removedWindowsTemp++
    }
    catch {
        $ignoredWindowsTemp++
    }
}

Write-Host "Itens encontrados: $($windowsTempBefore.Count)"
Write-Host "Itens removidos: $removedWindowsTemp"
Write-Host "Itens ignorados: $ignoredWindowsTemp"

Write-Host ""

Write-Host "Limpando cache de miniaturas..."
Write-Host ""

$thumbnailCache = "$env:LOCALAPPDATA\Microsoft\Windows\Explorer"

$thumbnailFilesBefore = @(
    Get-ChildItem -Path $thumbnailCache -Filter "thumbcache_*.db" -Force -ErrorAction SilentlyContinue
)

$removedThumbnail = 0
$ignoredThumbnail = 0

foreach ($item in $thumbnailFilesBefore) {
    try {
        Remove-Item -Path $item.FullName -Force -ErrorAction Stop
        $removedThumbnail++
    }
    catch {
        $ignoredThumbnail++
    }
}

Write-Host "Arquivos encontrados: $($thumbnailFilesBefore.Count)"
Write-Host "Arquivos removidos: $removedThumbnail"
Write-Host "Arquivos ignorados: $ignoredThumbnail"

Write-Host ""
Write-Host "=== LIMPEZA FINALIZADA ==="