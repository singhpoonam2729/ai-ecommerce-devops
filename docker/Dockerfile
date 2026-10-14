
# Stage 1: Install production dependencies
FROM node:20-alpine AS builder

WORKDIR /app
COPY application/package*.json ./
RUN npm ci --omit=dev

# Stage 2: Runtime image
FROM node:20-alpine

WORKDIR /app
ENV NODE_ENV=production

# Update Alpine security packages
USER root
RUN apk update && apk upgrade --no-cache \
    && rm -rf /var/cache/apk/*

# Remove npm and Corepack because runtime only needs Node.js
RUN rm -rf /usr/local/lib/node_modules/npm \
           /usr/local/lib/node_modules/corepack \
           /usr/local/bin/npm \
           /usr/local/bin/npx \
           /usr/local/bin/corepack

COPY --from=builder --chown=node:node /app/node_modules ./node_modules
COPY --chown=node:node application/app.js ./
COPY --chown=node:node application/package*.json ./

USER node

EXPOSE 3000
CMD ["node", "app.js"]
