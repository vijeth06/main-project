# Main Project: Git Submodules in Multi-Repository Projects

This repository demonstrates how to manage external dependencies that live in
separate Git repositories by using Git submodules.

## Project Purpose

The goal is to show a complete and practical workflow for:

- Creating a primary repository.
- Integrating an external repository as a submodule.
- Updating and synchronizing submodule references.
- Sharing reproducible setup commands with a development team.

## Repository Structure

- `libs/external-lib`: submodule checkout of the external dependency.
- `.gitmodules`: canonical mapping for submodule path and remote URL.
- `SUBMODULE_USAGE.md`: full command guide and operational notes.
- `demo.ps1`: simple runtime demo that imports and calls the external module.

## Quick Start

1. Clone with submodules:

	 `git clone --recurse-submodules https://github.com/vijeth06/main-project.git`

2. Enter the repository:

	 `cd main-project`

3. Validate submodule status:

	 `git submodule status`

4. Run the demo:

	 `powershell -ExecutionPolicy Bypass -File .\demo.ps1`

## Core Submodule Commands

- Add submodule:

	`git submodule add <external-repo-url> libs/external-lib`

- Initialize and fetch submodules after clone:

	`git submodule update --init --recursive`

- Pull latest changes from submodule remote and update pointer:

	`git submodule update --remote --merge`
	`git add libs/external-lib`
	`git commit -m "Update submodule pointer"`

- Synchronize URL changes from `.gitmodules` to local config:

	`git submodule sync --recursive`

## Documentation

For complete step-by-step setup, update, and verification instructions, read
`SUBMODULE_USAGE.md`.
