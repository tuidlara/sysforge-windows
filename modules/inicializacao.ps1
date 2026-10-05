Write-Host "=== PROGRAMAS DE INICIALIZACAO ==="

Write-Host ""

$startup = Get-CimInstance Win32_StartupCommand |
    Sort-Object Name

foreach ($item in $startup) {
    Write-Host "Nome: $($item.Name)"
    Write-Host "Comando: $($item.Command)"
    Write-Host "Origem: $($item.Location)"
    Write-Host ""
}