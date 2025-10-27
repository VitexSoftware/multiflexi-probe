# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

MultiFlexi Probe is a diagnostic tool for testing and validating the MultiFlexi task execution environment. It's a standalone bash script that reports environment variables, file access, and container mount information. The probe was extracted from the main MultiFlexi repository in October 2025 (see MIGRATION.md).

## Architecture

**Core Components:**
- `multiflexi-probe`: Bash script executable that captures and reports environment state
- `multiflexi/multiflexi_probe.multiflexi.app.json`: MultiFlexi application definition conforming to the schema at https://raw.githubusercontent.com/VitexSoftware/php-vitexsoftware-multiflexi-core/refs/heads/main/multiflexi.app.schema.json
- `multiflexi/probe.multiflexi.credential-type.json`: Credential type definition for probe authentication
- `Containerfile`: OCI image definition (debian:stable-slim + bash + jq)

**Key Behavior:**
- Accepts file path as command-line argument
- Outputs all environment variables as JSON (to stdout and optionally to `$RESULT_FILE`)
- Tests file upload functionality by checking if provided file exists
- Supports forced exit codes via `$FORCE_EXITCODE` for error handling testing
- Displays container mount information from `/proc/self/mountinfo`

**Dependencies:**
- Runtime: bash, jq
- Debian package pre-dependencies: multiflexi-web, multiflexi-common
- Installation tool: multiflexi-json2app (requires version 2.2.0+)

## Common Commands

### Build and Package
```bash
make debs                # Build Debian package
make dimage              # Build OCI image (single-arch)
make dimagex             # Build multi-arch OCI image (arm/v7, arm64/v8, amd64)
```

### Validation
```bash
make validate            # Validate JSON schema compliance
multiflexi-cli application validate-json --json multiflexi/multiflexi_probe.multiflexi.app.json
```

### Testing
```bash
make test                # Run probe locally with /etc/fstab
./multiflexi-probe /path/to/file  # Test with specific file
```

### Installation
```bash
make install             # Install to MultiFlexi via multiflexi-json2app
```

### Docker/Podman
```bash
docker run vitexsoftware/multiflexi-probe
podman build -f Containerfile . -t docker.io/vitexsoftware/multiflexi-probe
```

### Clean
```bash
make clean               # Remove build artifacts
```

## JSON Schema Compliance

**Critical**: All `*.app.json` files in the `multiflexi/` directory MUST conform to the schema. After editing any JSON file, validate with:

```bash
multiflexi-cli application validate-json --json multiflexi/[filename].app.json
```

The schema is versioned and should match the `"multiflexi"` field value in the app.json (currently "2.0.0").

## Credential Requirements

The probe's app.json declares it requires these credential types (for comprehensive testing):
- Probe (defined in probe.multiflexi.credential-type.json)
- mServer
- SQLServer
- RaiffeisenBank
- Office365
- FioBank
- AbraFlexi
- EnvFile
- VaultWarden
- Csas

## Environment Variables

Key environment variables the probe recognizes:
- `FILE_UPLOAD`: Path to test file (default: /etc/fstab)
- `PASSWORD`: Example secret field for testing
- `APP_DEBUG`: Enable debug output (true/false)
- `RESULT_FILE`: Output JSON file path (default: env_report.json)
- `FORCE_EXITCODE`: Force specific exit code (integer) - used to test error handling
- `ZABBIX_KEY`: Zabbix item key name

## Container Image

The OCI image is minimal (debian:stable-slim + bash + jq) and published to `docker.io/vitexsoftware/multiflexi-probe`. Multi-architecture builds support ARM and AMD64 platforms.
