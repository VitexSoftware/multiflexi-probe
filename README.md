# MultiFlexi Probe

Testing and debugging tool for MultiFlexi task launcher.

## Description

MultiFlexi Probe is a diagnostic application designed to test and validate the MultiFlexi task execution environment. It provides comprehensive information about:

- Command-line arguments
- Environment variables
- File system access
- Container mount information
- Output capture (stdout/stderr)

## Features

- **Environment Testing**: Displays all environment variables in JSON format
- **File Upload Testing**: Validates file path parameters
- **Output Control**: Configurable exit codes for testing error handling
- **Result Export**: Saves environment data to JSON file
- **Container Ready**: Available as OCI image for containerized execution

## Installation

### From Debian Package

```bash
sudo apt install multiflexi-probe
```

### From Source

```bash
make install
```

## Usage

```bash
multiflexi-probe [file-path]
```

### Environment Variables

- `FILE_UPLOAD`: Path to test file (default: /etc/fstab)
- `PASSWORD`: Example secret field
- `APP_DEBUG`: Enable debug output (true/false)
- `RESULT_FILE`: Output JSON file path (default: env_report.json)
- `FORCE_EXITCODE`: Force specific exit code (integer)
- `ZABBIX_KEY`: Zabbix item key name

## Configuration

The probe requires several credential types for comprehensive testing:
- Probe
- mServer
- SQLServer
- RaiffeisenBank
- Office365
- FioBank
- AbraFlexi
- EnvFile
- VaultWarden
- CSAS

## Docker/Podman

Build image:
```bash
make dimage
```

Build multi-architecture image:
```bash
make dimagex
```

Run container:
```bash
docker run vitexsoftware/multiflexi-probe
```

## Development

### Build Package

```bash
make debs
```

### Validate JSON Schema

```bash
make validate
```

### Test Locally

```bash
make test
```

## Author

Vítězslav Dvořák <info@vitexsoftware.cz>

## License

GPL-2.0-or-later

## Homepage

https://github.com/VitexSoftware/MultiFlexi
