# Main Project: Git Submodules in Multi-Repository Projects

This repository demonstrates a multi-repository dependency setup using Git
submodules. The main project integrates four externally maintained modules and
tracks each one by commit hash for reproducible builds.

## Integrated Submodules

- `libs/external-lib` -> core feature module
- `libs/external-utils` -> utility helper module
- `libs/external-config` -> configuration module
- `libs/external-logger` -> logging module

Submodule source mappings are defined in `.gitmodules`.

## Project Goals

- Keep external dependencies in independent repositories.
- Integrate dependencies into one primary repository.
- Pin exact dependency versions using submodule commit pointers.
- Provide a repeatable update flow for teams.

## Quick Start

```powershell
git clone --recurse-submodules https://github.com/vijeth06/main-project.git
cd main-project
git submodule status
powershell -ExecutionPolicy Bypass -File .\demo.ps1
```

## Expected Demo Output

Running `demo.ps1` prints values from all four submodules:

- External library message/version/status
- Utils message
- Config environment
- Logger message

## Core Submodule Operations

```powershell
# Initialize submodules after clone
git submodule update --init --recursive

# Update all submodules to latest remote commits
git submodule update --remote --merge

# Record updated pointers in main project
git add libs/external-lib libs/external-utils libs/external-config libs/external-logger
git commit -m "Update submodule pointers"

# Sync URL changes from .gitmodules
git submodule sync --recursive
```

## Documentation

- `SUBMODULE_USAGE.md` -> detailed setup and lifecycle guide
- `PROJECT_REPORT.md` -> assignment completion summary
- `demo.ps1` -> runtime validation script
