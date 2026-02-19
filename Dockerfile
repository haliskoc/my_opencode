FROM node:22-bookworm-slim

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

RUN npm install -g opencode-ai @ast-grep/cli \
    && opencode --version

COPY opencode-profile/package.json /root/.config/opencode/package.json
RUN npm --prefix /root/.config/opencode install --omit=dev

COPY opencode-profile/ /root/.config/opencode/
RUN chmod +x /root/.config/opencode/bin/opencode-clipimg \
    && ln -sf /root/.config/opencode/bin/opencode-clipimg /usr/local/bin/opencode-clipimg

RUN git clone --depth 1 https://github.com/code-yeongyu/oh-my-opencode.git /opt/oh-my-opencode-source \
    && rm -rf /opt/oh-my-opencode-source/.git

WORKDIR /workspace

ENTRYPOINT ["opencode"]
