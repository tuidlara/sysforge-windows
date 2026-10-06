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
elseif ($Reparo -eq "CHKDSK") {

    Write-Host "Verificando disco..."
    Write-Host ""

    chkdsk C:

    Write-Host ""
    Write-Host "Verificacao do disco concluida."
    Write-Host "Consulte o resultado acima para verificar se foram encontrados problemas."
}
elseif ($Reparo -eq "REPARAR_DISCO") {

    Write-Host "Reparando disco..."
    Write-Host ""

    chkdsk C: /f

    Write-Host ""
    Write-Host "O disco esta em uso pelo Windows."
    Write-Host "Para reparar, confirme o agendamento com S."
    Write-Host "O reparo sera executado no proximo reinicio."
}