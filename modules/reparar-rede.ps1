param (
    [string]$Reparo
)

Write-Host "=== REPARAR REDE ==="

Write-Host ""

if ($Reparo -eq "flushdns") {

    Write-Host "Limpando cache DNS..."

    ipconfig /flushdns
}
elseif ($Reparo -eq "renewip") {

    Write-Host "Verificando configuracao de IP..."
    Write-Host ""

    $dhcp = Get-NetIPInterface -AddressFamily IPv4 |
        Where-Object {
            $_.ConnectionState -eq "Connected" -and
            $_.InterfaceAlias -notlike "Loopback*"
        }

    if ($dhcp.Dhcp -contains "Enabled") {

        Write-Host "DHCP habilitado."
        Write-Host "Renovando endereco IP..."
        Write-Host ""

        ipconfig /release
        ipconfig /renew

    }
    else {

        Write-Host "O adaptador utiliza um endereco IP manual."
        Write-Host "Renovacao de IP nao se aplica."
    }
}
elseif ($Reparo -eq "winsock") {

    Write-Host "Resetando Winsock..."

    netsh winsock reset

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Reset do Winsock concluido."
        Write-Host "Reinicie o computador para aplicar completamente."
    }
    else {
        Write-Host "Falha ao resetar o Winsock."
    }
}

elseif ($Reparo -eq "tcpip") {

    Write-Host "Resetando TCP/IP..."
    Write-Host ""

    netsh int ip reset

    Write-Host "Reset do TCP/IP executado."
    Write-Host "Algumas configuracoes podem exigir a reinicializacao do computador."
    Write-Host "Se o problema de rede persistir, reinicie o computador."
}