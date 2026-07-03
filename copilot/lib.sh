TOOL_NAME="copilot"
IMAGE_PREFIX="curb-copilot"

get_extra_args() {
    # Mounting a non-existent directory causes podman to create it as root.
    mkdir -p "${HOME}/.copilot"
    PODMAN_ARGS+=(-v "${HOME}/.copilot:/home/${USER_NAME}/.copilot:z")
}
