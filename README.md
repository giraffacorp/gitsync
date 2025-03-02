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
  -v $HOME/.ssh:/ssh:ro \
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
      - $HOME/.ssh:/ssh:ro

volumes:
  data-sync
```

## SSH Options
1. Mount entire SSH dir
   ```shell
   -v $HOME/.ssh:/ssh:ro
   ```
1. Mount single key
   ```shell
   -v $HOME/.ssh/id_rsa:/ssh/id_git:ro
   ```
1. Set key as environment variable
   ```shell
   -e GIT_SECRET_KEY="$(cat $HOME/.ssh/id_rse | base64)"
   ```
> [!NOTE]  
> Always mount SSH keys as read-only volumes

## Configuration Parameters
| Environment Variable   | Description                          | Default     |
|------------------------|--------------------------------------|-------------|
| `GIT_HOST`             | Git server hostname                  | github.com  |
| `GIT_REPO_URL`         | SSH URL of Git repository (required) | -           |
| `GIT_SUBFOLDER_PATH`   | Subfolder path to sync               | "" (root)   |
| `GIT_SECRET_KEY`       | SSH key private key                  | ""          |
| `GIT_BRANCH`           | Git branch to track                  | main        |
| `SYNC_INTERVAL`        | Sync interval in seconds             | 10          |

## Available Commands
- `sync` Perform single synchronization
- `watch` Continuous sync (default)

## Volumes
- `/sync`: Destination path for synchronized files
- `/ssh`: SSH configuration directory
