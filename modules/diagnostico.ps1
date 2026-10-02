# Display diagnostic header
Write-Host "=== DIAGNOSTICO RAPIDO ==="

Write-Host ""

# Get operating system information
$os = Get-CimInstance Win32_OperatingSystem

Write-Host "Sistema operacional: $($os.Caption)"


# Get total physical memory
$totalRam = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory

# Convert memory from bytes to gigabytes
$ramGB = [math]::Round($totalRam / 1GB, 2)

Write-Host "Memoria RAM: $ramGB GB"


# Calculate current RAM usage
$memory = Get-CimInstance Win32_OperatingSystem

$totalMemory = $memory.TotalVisibleMemorySize
$freeMemory = $memory.FreePhysicalMemory

$usedMemory = $totalMemory - $freeMemory
$ramUsage = [math]::Round(($usedMemory / $totalMemory) * 100, 2)
Write-Host "Uso da memoria: $ramUsage%"

if ($ramUsage -ge 80) {
    Write-Host "RAM: ATENCAO"
} else {
    Write-Host "RAM: NORMAL"
}

Write-Host ""


# Get current CPU usage
$cpu = Get-CimInstance Win32_Processor

$cpuUsage = $cpu.LoadPercentage
Write-Host "Uso da CPU: $cpuUsage%"

if ($cpuUsage -ge 80) {
    Write-Host "CPU: ATENCAO"
} else {
    Write-Host "CPU: NORMAL"
}

Write-Host ""


# Get disk information
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"

$totalDisk = [math]::Round($disk.Size / 1GB, 2)
$freeDisk = [math]::Round($disk.FreeSpace / 1GB, 2)
$usedDisk = [math]::Round($totalDisk - $freeDisk, 2)

Write-Host "Disco C: $usedDisk GB usados de $totalDisk GB"
Write-Host "Espaco livre: $freeDisk GB"

$freeDiskPercent = ($freeDisk / $totalDisk) * 100

if ($freeDiskPercent -le 15) {
    Write-Host "Disco: ATENCAO"
} else {
    Write-Host "Disco: NORMAL"
}

Write-Host ""


# Get the default network gateway
$gateway = (Get-NetIPConfiguration | Where-Object {
    $_.IPv4DefaultGateway
}).IPv4DefaultGateway.NextHop

Write-Host "Gateway: $gateway"

# Test connectivity to the default gateway
$gatewayTest = Test-Connection -ComputerName $gateway -Count 1 -Quiet

if ($gatewayTest) {
    Write-Host "Gateway: CONECTADO"
} else {
    Write-Host "Gateway: FALHA NA CONEXAO"
}


# Test Internet connectivity
$internetTest = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet

if ($internetTest) {
    Write-Host "Internet: CONECTADA"
} else {
    Write-Host "Internet: FALHA NA CONEXAO"
}

Write-Host ""


# Get important Windows services
$services = Get-Service -Name "wuauserv", "BITS", "Winmgmt"

foreach ($service in $services) {
    if ($service.Status -eq "Running") {
        Write-Host "$($service.DisplayName): FUNCIONANDO"
    } else {
        Write-Host "$($service.DisplayName): PARADO"
    }
}