Write-Host "=== PROCESSOS E DESEMPENHO ==="

Write-Host ""

$processes = Get-Process

Write-Host "Processos ativos: $($processes.Count)"

Write-Host ""

$topMemory = $processes |
    Sort-Object WorkingSet64 -Descending |
    Select-Object -First 5

Write-Host "=== MAIOR USO DE MEMORIA ==="

foreach ($process in $topMemory) {
    $memoryMB = [math]::Round($process.WorkingSet64 / 1MB, 2)

    Write-Host "$($process.ProcessName) - Memoria: $memoryMB MB"
}

Write-Host ""
Write-Host "=== MAIOR USO ACUMULADO DE CPU ==="

$topCpu = $processes |
    Where-Object { $null -ne $_.CPU } |
    Sort-Object CPU -Descending |
    Select-Object -First 5

foreach ($process in $topCpu) {
    $cpuSeconds = [math]::Round($process.CPU, 2)

    Write-Host "$($process.ProcessName) - CPU acumulada: $cpuSeconds s"
}