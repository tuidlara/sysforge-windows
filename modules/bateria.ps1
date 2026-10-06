$bateria = Get-CimInstance Win32_Battery

if ($null -eq $bateria) {

    Write-Host "Nenhuma bateria foi detectada neste computador."

}
else {

    Write-Host "Bateria detectada."

    Write-Host ""

    Write-Host "Nome: $($bateria.Name)"

    Write-Host "Status: $($bateria.Status)"

    Write-Host "Carga: $($bateria.EstimatedChargeRemaining)%"

}