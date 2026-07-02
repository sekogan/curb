ARG COMMON_IMAGE=curb-common:latest
FROM ${COMMON_IMAGE}

ARG USER_NAME=user

# Install markdownlint-cli globally (requires root), then switch back to the
# non-root user to install Claude Code into ~/.local/bin via its install script.
USER root
RUN npm install -g markdownlint-cli
USER ${USER_NAME}

RUN curl -fsSL https://claude.ai/install.sh | bash

ENV CLAUDE_CODE_DISABLE_MOUSE=1

ENTRYPOINT ["claude", "--dangerously-skip-permissions"]
