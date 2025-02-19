Help me create a minimal example of:
* a minimal ExpressJS project that uses a minimal hello-world C language hello-world program.
* that includes the files necessary to use a GitHub Actions / GHCR-based deployment pipeline to deploy the app using a best-practice multi-stage dockerfile
* That builds publishes mult-architecture dockerfiles

------------------------------------------------------------------------------------------------------------------------------------------------



I've created a minimal ExpressJS project that integrates with a C hello-world program and includes multi-architecture Docker deployment via GitHub Actions. Here's what was created:

C Program:

src/c/hello.c: A simple C program that prints "Hello from C!"
src/c/Makefile: Compiles the C program with proper flags
Express Server:

src/server/index.js: Express server that executes and returns C program output
src/server/package.json: Node.js dependencies and scripts
Docker Setup:

Dockerfile: Multi-stage build process that:
Builds the C program
Sets up Node environment
Creates a minimal production image
Implements security best practices (non-root user)
.dockerignore: Excludes unnecessary files from build context
GitHub Actions:

.github/workflows/docker.yml: Workflow that:
Builds multi-architecture images (amd64, arm64)
Uses GitHub Container Registry (GHCR)
Implements caching for faster builds
Handles proper tagging and metadata
To use this project:

Push the code to a GitHub repository
Ensure GitHub Actions has permission to write packages
The workflow will automatically build and push multi-arch Docker images to GHCR
The Docker image can be pulled and run with:

docker pull ghcr.io/[your-username]/[repo-name]:latest
docker run -p 3000:3000 ghcr.io/[your-username]/[repo-name]:latest
The application will be accessible at http://localhost:3000 and will return the output from the C program.

------------------------------------------------------------------------------------------------------------------------------------------------

Update my .gitignore with sensible defaults

+ manual edits

