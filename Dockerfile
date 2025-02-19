# Stage 1: Build C program
FROM gcc:14-bookworm AS c-builder
WORKDIR /app
COPY src/c /app/src/c
RUN cd src/c && make

# Stage 2: Setup Node environment
FROM node:22-slim AS node-builder
WORKDIR /app
COPY src/server /app/src/server
WORKDIR /app/src/server
RUN npm install

# Stage 3: Production image
FROM node:22-slim
WORKDIR /app
COPY --from=node-builder /app/src/server /app/src/server
COPY --from=c-builder /app/dist /app/dist

# Create non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 3000
WORKDIR /app/src/server
CMD ["npm", "start"]
