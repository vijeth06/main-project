# Git Submodules in Multi-Repository Projects

This project demonstrates how to integrate and manage multiple external repositories as Git submodules.

## Repository Layout

- `main-project` -> primary repository
- `external-lib` -> external core library repository
- `external-utils` -> external utilities repository
- `external-config` -> external configuration repository
- `main-project/libs/external-lib` -> submodule working tree
- `main-project/libs/external-utils` -> submodule working tree
- `main-project/libs/external-config` -> submodule working tree

## 1. Create the Main Repository

```powershell
mkdir main-project
cd main-project
git init
"# Main Project`n" | Set-Content README.md
git add README.md
git commit -m "Initial commit for main project"
```

## 2. Create External Repositories

```powershell
mkdir external-lib
cd external-lib
git init
"# External Library`n" | Set-Content README.md
git add README.md
git commit -m "Initial commit for external library"

cd ..
mkdir external-utils
cd external-utils
git init
"# External Utils`n" | Set-Content README.md
git add README.md
git commit -m "Initial commit for external-utils"

cd ..
mkdir external-config
cd external-config
git init
"# External Config`n" | Set-Content README.md
git add README.md
git commit -m "Initial commit for external-config"
```

## 3. Add External Repositories as Submodules

Run this from `main-project`:

```powershell
git -c protocol.file.allow=always submodule add "..\external-lib" "libs/external-lib"
git -c protocol.file.allow=always submodule add "..\external-utils" "libs/external-utils"
git -c protocol.file.allow=always submodule add "..\external-config" "libs/external-config"
git commit -am "Add external-lib, external-utils, external-config as submodules"
```

Notes:
- `.gitmodules` stores submodule metadata (name, path, url).
- Each `libs/*` submodule is tracked as a Gitlink (mode `160000`).

## 4. Initialize and Synchronize Submodules

Use these commands in the main repository:

```powershell
git submodule init
git -c protocol.file.allow=always submodule update --remote --merge
git submodule sync --recursive
git submodule status
```

Purpose of each command:
- `git submodule init` -> registers submodules from `.gitmodules` into local Git config.
- `git submodule update --remote --merge` -> fetches latest commit from submodule remote and merges into checked-out submodule branch.
- `git submodule sync --recursive` -> syncs URL/config changes from `.gitmodules` into local config.
- `git submodule status` -> shows currently tracked commit per submodule.

## 5. Update Workflow (When External Repo Changes)

1. Commit changes in `external-lib`.
2. In `main-project`, run:

```powershell
git -c protocol.file.allow=always submodule update --remote --merge
git add libs/external-lib libs/external-utils libs/external-config
git commit -m "Update submodule pointers to latest commits"
```

This records new submodule commit pointers in the main repository.

## 6. Clone Workflow for New Developers

```powershell
git clone <main-project-url>
cd main-project
git submodule update --init --recursive
```

Or in a single command:

```powershell
git clone --recurse-submodules <main-project-url>
```

## 7. Push to GitHub

Push both repositories separately:

```powershell
# Push external first
cd external-lib
git remote add origin <external-lib-github-url>
git push -u origin master

# Then push main project
cd ..\main-project
git remote add origin <main-project-github-url>
git push -u origin master
```

Important:
- Ensure the URL in `.gitmodules` points to the GitHub URL of `external-lib` before sharing publicly.
- If you change `.gitmodules`, run `git submodule sync --recursive` and commit `.gitmodules`.

## 8. Verification Checklist

- Main repo has `.gitmodules`.
- Submodule folder exists at `libs/external-lib`.
- `git submodule status` shows a valid commit hash.
- Main repo commit history includes:
  - submodule add commit
  - submodule update commit

## 9. Multi-Submodule Validation

Useful checks after updates:

```powershell
git submodule status
git diff -- .gitmodules
git log --oneline --max-count=5
```
