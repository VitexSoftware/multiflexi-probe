# GitHub Copilot Instructions for MultiFlexi Probe

## Project Overview

This is the **MultiFlexi Probe** project - a task launcher testing tool designed to work within the MultiFlexi ecosystem. The probe is used for testing and validating MultiFlexi application configurations and environments.

## Project Structure

- **Root**: Contains configuration files, build scripts, and documentation
- **debian/**: Debian packaging files for distribution
- **multiflexi/**: MultiFlexi application configuration files
- **vendor/**: PHP dependencies managed by Composer

## Key Technologies

- **Language**: PHP
- **Package Manager**: Composer
- **Build System**: Make
- **Containerization**: Podman/Docker (using Containerfile)
- **Testing**: PHPUnit
- **Packaging**: Debian packages

## Code Conventions

### PHP
- Follow PSR-12 coding standards
- Use proper namespacing
- Include appropriate PHPDoc comments
- Prefer explicit type declarations where possible

### Configuration
- Use JSON format for MultiFlexi configurations
- Follow the MultiFlexi schema version 3.0.0
- Environment variables should be UPPERCASE with underscores
- Use descriptive names for configuration keys

### File Organization
- Keep source code organized by functionality
- Place tests in appropriate test directories
- Maintain clear separation between configuration and code

## MultiFlexi Specific Guidelines

### Application Configuration (`*.app.json` files)
- All files `*.app.json` must conform to the schema available at: https://raw.githubusercontent.com/VitexSoftware/php-vitexsoftware-multiflexi-core/refs/heads/main/multiflexi.app.schema.json
- All files `*.credential-type.json` must conform to the schema available at: https://raw.githubusercontent.com/VitexSoftware/php-vitexsoftware-multiflexi-core/refs/heads/main/multiflexi.credential-type.schema.json
- Always use schema version 3.0.0
- Use `cmdparamsTemplate` with `${VARIABLE}` syntax for placeholders
- Environment variables must follow the pattern `^[A-Z0-9_]+$`
- Required fields: `$schema`, `name`, `description`, `executable`, `environment`
- Use localized strings where appropriate

### Validation
Please ensure any changes to `*.app.json` files are validated. The MultiFlexi CLI validation command may not be available in all versions:

```bash
# Try MultiFlexi CLI validation (if available)
multiflexi-cli application validate-json --file multiflexi/[filename].app.json

# Alternative: Use online JSON schema validator or tools like ajv-cli
# Install ajv-cli: npm install -g ajv-cli
# Validate: ajv validate -s schema.json -d multiflexi/[filename].app.json

# Alternative: Manual JSON syntax check
json_verify < multiflexi/[filename].app.json
```

**Note**: The MultiFlexi CLI validation may have issues in some versions. Ensure the JSON is syntactically valid and follows the schema structure manually if validation tools are not working.

### Environment Variables
- **Types**: string, file-path, email, url, integer, float, bool, password, set, text
- **Categories**: API, Database, Behavior, Security, Other
- Include meaningful descriptions and default values
- Mark required variables appropriately

## Build and Testing

- Use `make` for build operations
- Run tests with `composer test` or `vendor/bin/phpunit`
- Build containers using the Containerfile
- Package for Debian using files in `debian/` directory

## Documentation

- Keep README.md updated with current functionality
- Document configuration options thoroughly
- Include examples in documentation
- Maintain changelog for releases

## Common Patterns

### Error Handling
- Use appropriate exit codes
- Log errors meaningfully
- Handle file operations safely

### Configuration Loading
- Validate configuration before use
- Provide sensible defaults
- Support environment variable overrides

### Testing
- Write unit tests for core functionality
- Test configuration validation
- Include integration tests where appropriate

## Dependencies

- Maintain minimal dependency footprint
- Keep Composer dependencies up to date
- Document any system requirements
- Use semantic versioning for releases

## Security Considerations

- Handle sensitive data (passwords, tokens) appropriately
- Validate all inputs
- Use secure defaults
- Follow principle of least privilege

## Git Workflow

- Use conventional commit messages
- Keep commits focused and atomic
- Include tests with new features
- Update documentation with changes
