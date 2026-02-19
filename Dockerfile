FROM node:22-bookworm-slim

ARG OPENCODE_VERSION=1.2.6
ARG AST_GREP_VERSION=0.39.5
ARG APP_USER=opencode
ARG APP_UID=10001

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        git \
        gh \
        tmux \
        python3 \
        jq \
        openssh-client \
        ripgrep \
        wl-clipboard \
        xclip \
        xsel \
        less \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g "opencode-ai@${OPENCODE_VERSION}" "@ast-grep/cli@${AST_GREP_VERSION}" \
    && opencode --version

RUN useradd --uid "${APP_UID}" --create-home --shell /bin/bash "${APP_USER}"

ENV HOME=/home/${APP_USER}
ENV OPENCODE_HOME=/home/${APP_USER}/.config/opencode
ENV XDG_CACHE_HOME=/home/${APP_USER}/.cache

RUN mkdir -p "${OPENCODE_HOME}"
COPY opencode-profile/package.json "${OPENCODE_HOME}/package.json"
COPY opencode-profile/package-lock.json "${OPENCODE_HOME}/package-lock.json"
RUN npm --prefix "${OPENCODE_HOME}" ci --omit=dev

COPY opencode-profile/ "${OPENCODE_HOME}/"
RUN chmod +x "${OPENCODE_HOME}/bin/opencode-clipimg" \
    && ln -sf "${OPENCODE_HOME}/bin/opencode-clipimg" /usr/local/bin/opencode-clipimg \
    && mkdir -p "/home/${APP_USER}/.cache" "/home/${APP_USER}/.local/share/opencode" "/home/${APP_USER}/.local/state" \
    && chown -R "${APP_USER}:${APP_USER}" "/home/${APP_USER}"

RUN git clone --depth 1 https://github.com/code-yeongyu/oh-my-opencode.git /opt/oh-my-opencode-source \
    && rm -rf /opt/oh-my-opencode-source/.git

WORKDIR /workspace
USER ${APP_USER}

ENTRYPOINT ["opencode"]
