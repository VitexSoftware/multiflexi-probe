# Migration Notes

## Project History

This project was originally part of the [MultiFlexi](https://github.com/VitexSoftware/MultiFlexi) repository and has been extracted into its own standalone project.

## What Was Moved

The following components were extracted from the MultiFlexi project:

### Source Files
- `tests/multiflexi-probe` → `multiflexi-probe` (executable script)
- `tests/multiflexi_probe.multiflexi.app.json` → `multiflexi/multiflexi_probe.multiflexi.app.json`
- `tests/probe.multiflexi.credential-type.json` → `multiflexi/probe.multiflexi.credential-type.json`
- `multiflexi-probe.svg` → `multiflexi-probe.svg`
- `Containerfile.probe` → `Containerfile`

### Debian Packaging
- `debian/multiflexi-probe.install`
- `debian/multiflexi-probe.postinst`
- `debian/multiflexi-probe.prerm`
- Package definition from `debian/control`

### Build Configuration
- Makefile targets (`probeapp`, `probeimage`, `probeimagex`, `instprobe`)

## Changes Made

1. **Project Structure**: Created standalone project structure with its own:
   - `composer.json`
   - `Makefile`
   - `README.md`
   - `.gitignore`
   - Complete Debian packaging

2. **Path Updates**: Updated Containerfile to reference correct file paths

3. **Documentation**: Added comprehensive README with usage examples

4. **Version Control**: Initialized new git repository

## Dependencies

The probe still depends on MultiFlexi infrastructure:
- `multiflexi-web` (pre-dependency)
- `multiflexi-common` (pre-dependency)
- `multiflexi-json2app` command (for installation)

## Installation After Migration

From the old MultiFlexi repository, the probe package will no longer be built. Users should install from this new repository:

```bash
cd ~/Projects/Multi/multiflexi-probe
make debs
sudo dpkg -i ../multiflexi-probe_*.deb
```

Or build and push the container:

```bash
make dimage
# or for multi-arch:
make dimagex
```

## Original Repository

The probe was originally maintained at:
- Repository: https://github.com/VitexSoftware/MultiFlexi
- Location: `tests/multiflexi-probe`, `tests/*.json`, `Containerfile.probe`
- Debian package: Part of main `debian/control`

## Date of Migration

October 26, 2025
