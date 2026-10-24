FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_ENV=production
ENV PORT=7860

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    tar \
    bash \
    git \
    procps \
    coreutils \
    findutils \
    util-linux \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x -o /tmp/nodesource.sh \
    && bash /tmp/nodesource.sh \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -f /tmp/nodesource.sh \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install dependencies from this repository
COPY package*.json ./
RUN npm install --omit=dev

# Copy your actual project files; don't clone a different repository
COPY . .

EXPOSE 7860

CMD ["node", "server.js"]