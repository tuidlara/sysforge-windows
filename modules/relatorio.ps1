$data = Get-Date

$projectPath = Split-Path -Parent $PSScriptRoot
$reportPath = Join-Path $projectPath "relatorios"

if (-not (Test-Path $reportPath)) {
    New-Item -Path $reportPath -ItemType Directory | Out-Null
}

$fileName = "SysForge_Report_$($data.ToString('yyyy-MM-dd_HHmmss')).txt"

$filePath = Join-Path $reportPath $fileName

$report = @()

$report += "=== RELATORIO SYSFORGE ==="
$report += "Data e hora da coleta: $data"
$report += ""

$os = Get-CimInstance Win32_OperatingSystem

$report += "Computador: $env:COMPUTERNAME"
$report += "Sistema operacional: $($os.Caption)"
$report += "Versao: $($os.Version)"
$report += "Arquitetura: $($os.OSArchitecture)"
$report += ""

$cpu = Get-CimInstance Win32_Processor

$report += "Processador: $($cpu.Name)"
$report += "Nucleos: $($cpu.NumberOfCores)"
$report += "Threads: $($cpu.NumberOfLogicalProcessors)"
$report += ""

$computer = Get-CimInstance Win32_ComputerSystem

$ramGB = [math]::Round($computer.TotalPhysicalMemory / 1GB, 2)

$report += "Memoria RAM: $ramGB GB"
$report += ""

$gpu = Get-CimInstance Win32_VideoController

foreach ($item in $gpu) {
    $report += "GPU: $($item.Name)"
}

$report += ""

$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

$totalDisk = [math]::Round($disk.Size / 1GB, 2)
$freeDisk = [math]::Round($disk.FreeSpace / 1GB, 2)
$usedDisk = [math]::Round($totalDisk - $freeDisk, 2)

$report += "Disco C:"
$report += "Total: $totalDisk GB"
$report += "Usado: $usedDisk GB"
$report += "Livre: $freeDisk GB"
$report += ""

$totalMemory = $os.TotalVisibleMemorySize
$freeMemory = $os.FreePhysicalMemory
$usedMemory = $totalMemory - $freeMemory

$ramUsage = [math]::Round(($usedMemory / $totalMemory) * 100, 2)

$report += "Uso da memoria: $ramUsage%"
$report += ""

$report += "Uso da CPU: $($cpu.LoadPercentage)%"
$report += ""

$processes = Get-Process

$report += "Processos ativos: $($processes.Count)"
$report += ""

$report += "=== REDE ==="

$adapter = Get-NetAdapter | Where-Object {
    $_.Status -eq "Up"
}

foreach ($item in $adapter) {

    $report += "Adaptador: $($item.Name)"

    $ip = Get-NetIPAddress -InterfaceIndex $item.ifIndex -AddressFamily IPv4 |
        Where-Object {
            $_.IPAddress -notlike "169.254.*"
        }

    $report += "IP: $($ip.IPAddress)"
}

$gateway = $null

foreach ($item in $adapter) {

    $config = Get-NetIPConfiguration -InterfaceIndex $item.ifIndex

    if ($config.IPv4DefaultGateway) {
        $gateway = $config.IPv4DefaultGateway.NextHop
        $report += "Gateway: $gateway"
    }
}

foreach ($item in $adapter) {

    $dns = Get-DnsClientServerAddress -InterfaceIndex $item.ifIndex -AddressFamily IPv4

    if ($dns.ServerAddresses) {
        $report += "DNS: $($dns.ServerAddresses -join ', ')"
    }
}

$dnsTest = Resolve-DnsName "google.com" -ErrorAction SilentlyContinue

if ($dnsTest) {
    $report += "DNS: FUNCIONANDO"
} else {
    $report += "DNS: FALHA NA RESOLUCAO"
}

$latency = Test-Connection -ComputerName $gateway -Count 4 -ErrorAction SilentlyContinue

if ($latency) {

    $average = ($latency | Measure-Object -Property ResponseTime -Average).Average
    $average = [math]::Round($average, 2)

    $report += "Latencia media: $average ms"

} else {

    $report += "Latencia: FALHA"
}

$report += ""
$report += "=== SERVICOS DO WINDOWS ==="

$services = Get-Service -Name "Dhcp", "Dnscache", "WlanSvc" -ErrorAction SilentlyContinue

foreach ($service in $services) {

    if ($service.Status -eq "Running") {
        $report += "$($service.DisplayName) - FUNCIONANDO"
    } else {
        $report += "$($service.DisplayName) - PARADO"
    }
}

$report += ""
$report += "=== IMPRESSAO ==="

$services = Get-Service -Name "Spooler" -ErrorAction SilentlyContinue

foreach ($service in $services) {

    if ($service.Status -eq "Running") {
        $report += "$($service.DisplayName) - FUNCIONANDO"
    } else {
        $report += "$($service.DisplayName) - PARADO"
    }
}

$report += ""
$report += "=== SEGURANCA ==="

$services = Get-Service -Name "WinDefend", "MpsSvc" -ErrorAction SilentlyContinue

foreach ($service in $services) {

    if ($service.Status -eq "Running") {
        $report += "$($service.DisplayName) - FUNCIONANDO"
    } else {
        $report += "$($service.DisplayName) - PARADO"
    }
}

$report += ""
$report += "=== ATUALIZACAO ==="

$services = Get-Service -Name "wuauserv", "BITS" -ErrorAction SilentlyContinue

foreach ($service in $services) {

    if ($service.Status -eq "Running") {
        $report += "$($service.DisplayName) - FUNCIONANDO"
    } else {
        $report += "$($service.DisplayName) - PARADO"
    }
}

$report += ""
$report += "=== GERENCIAMENTO DO WINDOWS ==="

$services = Get-Service -Name "Winmgmt" -ErrorAction SilentlyContinue

foreach ($service in $services) {

    if ($service.Status -eq "Running") {
        $report += "$($service.DisplayName) - FUNCIONANDO"
    } else {
        $report += "$($service.DisplayName) - PARADO"
    }
}

$report | Out-File -FilePath $filePath -Encoding UTF8

$report | Write-Host

Write-Host ""
Write-Host "Relatorio salvo em: $filePath"