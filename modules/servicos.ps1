Write-Host "=== SERVICOS DO WINDOWS ==="

Write-Host ""
Write-Host "=== REDE ==="

$services = Get-Service -Name "Dhcp", "Dnscache", "WlanSvc" -ErrorAction SilentlyContinue

foreach ($service in $services) {
    if ($service.Status -eq "Running") {
        Write-Host "$($service.DisplayName) - FUNCIONANDO"
    } else {
        Write-Host "$($service.DisplayName) - PARADO"
    }
}

Write-Host ""
Write-Host "=== IMPRESSAO ==="

$services = Get-Service -Name "Spooler" -ErrorAction SilentlyContinue

foreach ($service in $services) {
    if ($service.Status -eq "Running") {
        Write-Host "$($service.DisplayName) - FUNCIONANDO"
    } else {
        Write-Host "$($service.DisplayName) - PARADO"
    }
}

Write-Host ""
Write-Host "=== SEGURANCA ==="

$services = Get-Service -Name "WinDefend", "MpsSvc" -ErrorAction SilentlyContinue

foreach ($service in $services) {
    if ($service.Status -eq "Running") {
        Write-Host "$($service.DisplayName) - FUNCIONANDO"
    } else {
        Write-Host "$($service.DisplayName) - PARADO"
    }
}

Write-Host ""
Write-Host "=== ATUALIZACAO ==="

$services = Get-Service -Name "wuauserv", "BITS" -ErrorAction SilentlyContinue

foreach ($service in $services) {
    if ($service.Status -eq "Running") {
        Write-Host "$($service.DisplayName) - FUNCIONANDO"
    } else {
        Write-Host "$($service.DisplayName) - PARADO"
    }
}

Write-Host ""
Write-Host "=== GERENCIAMENTO DO WINDOWS ==="

$services = Get-Service -Name "Winmgmt" -ErrorAction SilentlyContinue

foreach ($service in $services) {
    if ($service.Status -eq "Running") {
        Write-Host "$($service.DisplayName) - FUNCIONANDO"
    } else {
        Write-Host "$($service.DisplayName) - PARADO"
    }
}