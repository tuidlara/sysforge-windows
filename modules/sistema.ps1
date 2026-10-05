Write-Host "=== INFORMACOES DO SISTEMA ==="

Write-Host ""

$os = Get-CimInstance Win32_OperatingSystem

Write-Host "Computador: $env:COMPUTERNAME"
Write-Host "Sistema operacional: $($os.Caption)"
Write-Host "Versao: $($os.Version)"
Write-Host "Arquitetura: $($os.OSArchitecture)"

Write-Host ""

$cpu = Get-CimInstance Win32_Processor

Write-Host "Processador: $($cpu.Name)"
Write-Host "Nucleos: $($cpu.NumberOfCores)"
Write-Host "Threads: $($cpu.NumberOfLogicalProcessors)"

Write-Host ""

$computer = Get-CimInstance Win32_ComputerSystem

$ramGB = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)

Write-Host "Memoria RAM: $ramGB GB"

Write-Host ""

$gpu = Get-CimInstance Win32_VideoController

foreach ($item in $gpu) {
    Write-Host "GPU: $($item.Name)"
}

Write-Host ""

$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

$totalDisk = [math]::Round($disk.Size / 1GB, 2)
$freeDisk = [math]::Round($disk.FreeSpace / 1GB, 2)
$usedDisk = [math]::Round($totalDisk - $freeDisk, 2)

Write-Host "Disco C:"
Write-Host "Total: $totalDisk GB"
Write-Host "Usado: $usedDisk GB"
Write-Host "Livre: $freeDisk GB"

Write-Host ""

Write-Host "=== FIM DAS INFORMACOES ==="