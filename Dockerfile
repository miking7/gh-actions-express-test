# Stage 1: Build C program
FROM gcc:14-bookworm AS c-builder
WORKDIR /build
COPY src/c .
RUN make

# Stage 2: Setup Node environment
FROM node:22-slim AS node-builder
WORKDIR /app
COPY src/server/package*.json ./
RUN npm install
COPY src/server .

# Stage 3: Production image
FROM node:22-slim
WORKDIR /app
COPY --from=node-builder /app ./
COPY --from=c-builder /build/hello ./c/hello

# Create non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 3000
CMD ["npm", "start"]
