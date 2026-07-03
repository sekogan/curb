TOOL_NAME="claude"
IMAGE_PREFIX="curb-claude"

get_extra_args() {
    # Mounting a non-existent file causes podman to create a directory instead.
    [[ ! -f "${HOME}/.claude.json" ]] && echo '{}' > "${HOME}/.claude.json"
    mkdir -p "${HOME}/.claude"
    PODMAN_ARGS+=(
        -v "${HOME}/.claude.json:/home/${USER_NAME}/.claude.json:z"
        -v "${HOME}/.claude:/home/${USER_NAME}/.claude:z"
    )
}
