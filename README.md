# Git Sync Container

A Docker image that continuously synchronizes a Git repository subtree to a destination path using Go Task.

## Prerequisites
- Docker installed
- SSH key configured for Git repository access

## Quick Start
```shell
docker run -d \
  -e GIT_REPO_URL="git@github.com:your/repo.git" \
  -e GIT_SUBFOLDER_PATH="src" \
  -v $HOME/.ssh:/root/.ssh:ro \
  -v /host/path/to/sync/to:/sync \
  giraffacarp/gitsync
```

## Docker Compose Example
```yaml
services:
  gitsync:
    image: giraffacarp/gitsync
    environment:
      GIT_REPO_URL: "git@github.com:your/repo.git"
      GIT_SUBFOLDER_PATH: "src"
      SYNC_INTERVAL: 30
    volumes:
      - data-sync:/sync
      - $HOME/.ssh:/root/.ssh:ro

volumes:
  data-sync
```

## SSH Options
Mount either:
1. Entire SSH config
   ```shell
   -v $HOME/.ssh:/root/.ssh:ro
   ```
1. Single key
   ```shell
   -v $HOME/.ssh/id_rsa:/root/.ssh/id_git:ro
   ```
> [!IMPORTANT]  
> Always mount SSH keys as read-only volumes

## Configuration Parameters
| Environment Variable   | Description                          | Default     |
|------------------------|--------------------------------------|-------------|
| `GIT_HOST`             | Git server hostname                  | github.com  |
| `GIT_REPO_URL`         | SSH URL of Git repository (required) | -           |
| `GIT_SUBFOLDER_PATH`   | Subfolder path to sync               | "" (root)   |
| `GIT_BRANCH`           | Git branch to track                  | main        |
| `SYNC_INTERVAL`        | Sync interval in seconds             | 10          |

## Available Commands
- `sync` Perform single synchronization
- `watch` Continuous sync (default)

## Volumes
- `/sync`: Destination path for synchronized files
- `/root/.ssh`: SSH configuration directory
