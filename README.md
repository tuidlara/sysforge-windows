# SysForge

SysForge is a lightweight Windows diagnostic and maintenance toolkit built with **Batch and PowerShell**.

It provides a simple menu-driven interface for checking system health, diagnosing network issues, performing Windows repairs, and generating diagnostic reports.

## Features

- Quick system diagnostics
- Network diagnostics
- Network repair tools
- Windows repair tools
- SFC
- DISM
- CHKDSK
- Basic system cleanup
- System information
- Process and performance monitoring
- Startup program diagnostics
- Windows services diagnostics
- Battery diagnostics
- Diagnostic report generation

## Requirements

- Windows 10 or later
- PowerShell
- Administrator privileges

## Usage

Clone the repository and run `SysForge.bat`.

SysForge automatically requests administrator privileges when required.

## Project Structure

```text
SysForge/
├── modules/
│   ├── bateria.ps1
│   ├── desempenho.ps1
│   ├── diagnostico.ps1
│   ├── inicializacao.ps1
│   ├── limpeza.ps1
│   ├── rede.ps1
│   ├── relatorio.ps1
│   ├── reparar-rede.ps1
│   ├── reparar.ps1
│   ├── servicos.ps1
│   └── sistema.ps1
├── relatorios/
├── .gitignore
├── README.md
└── SysForge.bat
```

## Architecture

SysForge uses **Batch as the user interface and navigation layer**, while **PowerShell handles diagnostics and system operations**.

```text
SysForge.bat
     ↓
PowerShell modules
     ↓
Windows commands and APIs
     ↓
Diagnostic or maintenance result
```

## Safety

Some operations can modify Windows configuration or require a system restart, such as network resets, CHKDSK repairs, SFC, and DISM.

Use repair operations carefully and review the displayed information before proceeding.
