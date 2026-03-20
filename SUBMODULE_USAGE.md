# Git Submodules in Multi-Repository Projects

This project demonstrates how to integrate and manage an external repository as a Git submodule.

## Repository Layout

- `main-project` -> primary repository
- `external-lib` -> external dependency repository
- `main-project/libs/external-lib` -> submodule working tree

## 1. Create the Main Repository

```powershell
mkdir main-project
cd main-project
git init
"# Main Project`n" | Set-Content README.md
git add README.md
git commit -m "Initial commit for main project"
```

## 2. Create the External Repository

```powershell
mkdir external-lib
cd external-lib
git init
"# External Library`n" | Set-Content README.md
git add README.md
git commit -m "Initial commit for external library"
```

## 3. Add External Repository as Submodule

Run this from `main-project`:

```powershell
git -c protocol.file.allow=always submodule add "..\external-lib" "libs/external-lib"
git commit -am "Add external-lib as submodule"
```

Notes:
- `.gitmodules` stores submodule metadata (name, path, url).
- `libs/external-lib` is tracked as a Gitlink (mode `160000`).

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
git add libs/external-lib
git commit -m "Update submodule to latest external-lib commit"
```

This records the new submodule commit pointer in the main repository.

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
