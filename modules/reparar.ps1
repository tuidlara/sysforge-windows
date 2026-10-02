param (
    [string]$Reparo
)

Write-Host "=== REPARAR WINDOWS ==="

Write-Host ""

if ($Reparo -eq "SFC") {

    Write-Host "Iniciando verificacao dos arquivos do sistema..."
    Write-Host ""

    sfc /scannow

    Write-Host ""

    if ($LASTEXITCODE -eq 0) {
        Write-Host "SFC: REPARO CONCLUIDO COM SUCESSO"
    } else {
        Write-Host "SFC: O WINDOWS REPORTOU PROBLEMAS NO REPARO"
    }

}
elseif ($Reparo -eq "DISM") {

    Write-Host "Iniciando reparo da imagem do Windows..."
    Write-Host ""

    DISM /Online /Cleanup-Image /RestoreHealth

    Write-Host ""

    if ($LASTEXITCODE -eq 0) {
        Write-Host "DISM: REPARO CONCLUIDO COM SUCESSO"
    } else {
        Write-Host "DISM: O WINDOWS REPORTOU PROBLEMAS NO REPARO"
    }

}
else {

    Write-Host "Reparo invalido."
}