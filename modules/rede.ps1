Write-Host "=== DIAGNOSTICO DE REDE ==="

Write-Host ""

# Get network adapter information
$adapter = Get-NetAdapter | Where-Object {
    $_.Status -eq "Up"
}

foreach ($item in $adapter) {
    Write-Host "Adaptador: $($item.Name)"
    Write-Host "Status: $($item.Status)"
}


# Get IPv4 addresses from active adapters
foreach ($item in $adapter) {
    $ip = Get-NetIPAddress -InterfaceIndex $item.ifIndex -AddressFamily IPv4 |
        Where-Object {
            $_.IPAddress -notlike "169.254.*"
        }

    Write-Host "IP: $($ip.IPAddress)"
}

$gateway = $null

foreach ($item in $adapter) {
    $config = Get-NetIPConfiguration -InterfaceIndex $item.ifIndex

    if ($config.IPv4DefaultGateway) {
        $gateway = $config.IPv4DefaultGateway.NextHop
        Write-Host "Gateway: $gateway"
    }
}

foreach ($item in $adapter) {
    $dns = Get-DnsClientServerAddress -InterfaceIndex $item.ifIndex -AddressFamily IPv4

    if ($dns.ServerAddresses) {
        Write-Host "DNS: $($dns.ServerAddresses -join ', ')"
    }
}

# Test DNS resolution
$dnsTest = Resolve-DnsName "google.com" -ErrorAction SilentlyContinue

if ($dnsTest) {
    Write-Host "DNS: FUNCIONANDO"
} else {
    Write-Host "DNS: FALHA NA RESOLUCAO"
}

$latency = Test-Connection -ComputerName $gateway -Count 4 -ErrorAction SilentlyContinue

if ($latency) {
    $average = ($latency | Measure-Object -Property ResponseTime -Average).Average
    $average = [math]::Round($average, 2)

    Write-Host "Latencia media: $average ms"

    if ($average -le 50) {
        Write-Host "Latencia: NORMAL"
    } elseif ($average -le 100) {
        Write-Host "Latencia: ATENCAO"
    } else {
        Write-Host "Latencia: ALTA"
    }
} else {
    Write-Host "Latencia: FALHA"
}