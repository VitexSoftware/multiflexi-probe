# MultiFlexi Probe

Testing and debugging tool for MultiFlexi task launcher.

![MultiFlexi probe logo](multiflexi-probe.svg?raw=true)

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
- **Localization**: Supports English and Czech interface descriptions

## Configuration Schema

This application follows MultiFlexi Application Schema version 3.3.0 with:
- Localized application name and descriptions (English/Czech)
- Localized environment variable descriptions
- Schema-compliant configuration structure
- Optional Kubernetes metadata under `kubernetes.helm` and `kubernetes.artifacts`

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

## Configuration

The MultiFlexi Probe application configuration (`multiflexi/probe.multiflexi.app.json`) follows the MultiFlexi Application Schema version 3.3.0 with localization support for both English and Czech languages.

### Environment Variables

- `FILE_UPLOAD`: Path to test file (default: /etc/fstab)
- `PASSWORD`: Example secret field for testing
- `APP_DEBUG`: Enable debug output (true/false)
- `RESULT_FILE`: Output JSON file path (default: env_report.json)
- `FORCE_EXITCODE`: Force specific exit code (integer)
- `ZABBIX_KEY`: Zabbix item key name template

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

## Helm

The repository now includes a chart in `helm/` for Kubernetes deployment.

Render chart templates:
```bash
make helm-template
```

Lint chart:
```bash
make helm-lint
```

Install or upgrade chart:
```bash
make helm-install
```

it gives the following output:

```shell
helm upgrade --install multiflexi-probe helm/ --namespace multiflexi --create-namespace
Release "multiflexi-probe" does not exist. Installing it now.
NAME: multiflexi-probe
LAST DEPLOYED: Thu Apr  2 10:25:37 2026
NAMESPACE: multiflexi
STATUS: deployed
REVISION: 1
DESCRIPTION: Install complete
TEST SUITE: None
NOTES:
1. Check deployment status:
   kubectl get pods -n multiflexi -l app.kubernetes.io/instance=multiflexi-probe

2. Inspect environment variables resolved by chart:
   kubectl describe configmap multiflexi-probe-multiflexi-probe -n multiflexi

3. Run one-off probe command in the pod:
   kubectl exec -n multiflexi deploy/multiflexi-probe-multiflexi-probe -- multiflexi-probe /etc/fstab
```





## Development

### Build Package

```bash
make debs
```

### Validate JSON Schema

```bash
# Note: MultiFlexi CLI validation may have issues in some versions
# Try different validation approaches:

# Method 1: MultiFlexi CLI (if working)
multiflexi-cli application validate-json --file multiflexi/multiflexi_probe.multiflexi.app.json

# Method 2: JSON syntax validation
json_verify < multiflexi/multiflexi_probe.multiflexi.app.json

# Method 3: Using online validator with schema URL
# https://raw.githubusercontent.com/VitexSoftware/php-vitexsoftware-multiflexi-core/refs/heads/main/multiflexi.app.schema.json
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
