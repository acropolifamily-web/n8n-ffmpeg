FROM n8nio/n8n:latest

USER root
RUN set -eux; \
  if command -v apk >/dev/null 2>&1; then \
    apk add --no-cache ffmpeg; \
  elif command -v apt-get >/dev/null 2>&1; then \
    apt-get update && apt-get install -y --no-install-recommends ffmpeg && rm -rf /var/lib/apt/lists/*; \
  else \
    echo "No supported package manager found (apk/apt-get)"; exit 1; \
  fi

# vuelve a usuario normal (como hace la imagen oficial)
USER node

# 🔧 Arranque explícito del CLI de n8n (sin entrypoint)
# En la imagen oficial, el binario está aquí:
# /usr/local/lib/node_modules/n8n/bin/n8n
CMD ["node", "/usr/local/lib/node_modules/n8n/bin/n8n", "start"]
