# curb

Sandbox runner for AI coding agents. Curb your AI's enthusiasm.

Runs each tool in an isolated [Podman](https://podman.io/) container, mounting your current project as the workspace. The container image is built automatically on first run and cached for subsequent runs. Configuration and credentials are mounted from the host so they persist across invocations.

## Installation

```sh
make install
```

To install a specific tool:

```sh
make -C claude install
make -C copilot install
```

## Features

- **Isolation** — the tool runs in a container with access only to the current directory and its config, nothing else on the host.
- **Custom base images** — layer any tool on top of a Debian/Ubuntu or RHEL/Fedora/UBI image to provide the exact toolchain your project needs.
- **Per-project configuration** — commit a `.config/curb.conf` to pin the base image for a project (`curb init`).
- **Extra mounts** — mount additional host directories into the container, read-only by default, with `-m/--mount` or `MOUNTS` in `curb.conf`.
- **SELinux-aware** — volume mounts are labelled correctly for SELinux hosts (Fedora, RHEL).

> [!WARNING]
> All tools run in **no-confirmation mode** (`--dangerously-skip-permissions` for Claude, `--yolo` for Copilot), meaning they execute commands without asking. The container limits the blast radius to the current directory, but it does **not** make this fully safe. Prompt injection attacks can still instruct the tool to exfiltrate the contents of your working directory.

## Tools

### [claude](claude/)

Runs [Claude Code](https://claude.ai/code). Mounts `~/.claude` and `~/.claude.json` from the host for session and config persistence.

```sh
curb claude                                     # launch in the current directory
curb claude -C ~/projects/myapp                 # launch in a specific directory
curb claude -b ghcr.io/myorg/dev:latest         # use a custom base image
curb claude -m ~/datasets                       # mount read-only at /mnt/datasets
curb claude -m /srv/cache:/cache:rw             # mount read-write at /cache
curb claude --rebuild                           # rebuild the container image
curb claude -- --model claude-opus-4-6          # pass arguments directly to claude
```

### [copilot](copilot/)

Runs [GitHub Copilot CLI](https://github.com/github/copilot.vim). Mounts `~/.copilot` from the host for authentication and config persistence.

```sh
curb copilot                                    # launch in the current directory
curb copilot -C ~/projects/myapp                # launch in a specific directory
curb copilot -b ghcr.io/myorg/dev:latest        # use a custom base image
curb copilot --rebuild                          # rebuild the container image
```
