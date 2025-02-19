# Build instructions for simple ExpressJS + C-language demo

## Run latest production version from GHCR (built on push using GitHub actions):

docker run --rm --pull always -p 3000:3000 -d ghcr.io/miking7/gh-actions-express-test

## Build and run locally:

### Single architecture build (default):

docker build -t express-test:local .
docker run --rm -p 3000:3000 -d express-test:local

### Multi-architecture build using buildx:

```bash
# Create and use a new builder instance with multi-architecture support
docker buildx create --name multiarch-builder --use

# Option 1: Build for your current architecture (recommended for local testing)
docker buildx build --platform $(docker info -f '{{.Architecture}}') \
  -t express-test:multiarch \
  --load \
  .

# Option 2: Build for a specific architecture
# For Intel/AMD processors (x86_64):
docker buildx build --platform linux/amd64 \
  -t express-test:multiarch \
  --load \
  .
# OR for Apple Silicon (M1/M2) and other ARM processors:
docker buildx build --platform linux/arm64 \
  -t express-test:multiarch \
  --load \
  .

# Run the image
docker run --rm -p 3000:3000 -d express-test:multiarch

# Note: To build for multiple architectures simultaneously, you would need to
# either push to a registry or use a local registry. For local development,
# it's usually sufficient to build for your current architecture.
```
