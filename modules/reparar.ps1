Write-Host "=== REPARAR WINDOWS ==="

Write-Host ""
Write-Host "Iniciando verificacao dos arquivos do sistema..."
Write-Host ""

sfc /scannow

Write-Host ""

if ($LASTEXITCODE -eq 0) {
    Write-Host "SFC: REPARO CONCLUIDO COM SUCESSO"
} else {
    Write-Host "SFC: O WINDOWS REPORTOU PROBLEMAS NO REPARO"
}

Write-Host ""