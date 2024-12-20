# ElectronDocker
This guide explains how to run an Electron application inside a Docker container using Ubuntu and have the UI rendered on the host machine. The UI utilizes Three.js for rendering 3D graphics.


## Prerequisites

- Docker installed on the host machine.
- X11 forwarding enabled on the host machine (for UI projection).
- An Electron app that is ready to be run using `npm start`.

## Steps

### 1. Build the Docker Image

First, ensure you have the following `Dockerfile` in your project directory:

```Dockerfile
FROM ubuntu:20.04

# Configure timezone and environmenFROM ubuntu:20.04

# Set environment variables to avoid interactive configuration of tzdata
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=America/Los_Angeles

# Install Node.js, NPM, and additional dependencies needed for Electron
RUN apt-get update && apt-get install -y \
    tzdata \
    curl \
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxtst-dev \
    libxrandr-dev \
    libasound2-dev \
    libgtk-3-dev \
    libnss3 \
    libxss1 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libgbm1 \
    git \
    && apt-get clean

# Install Node.js 18.x (compatible with Electron 32.x)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Set the working directory to /app inside the container
WORKDIR /app

# Copy all files from the host to the /app folder in the container
COPY appw /app

# Install application dependencies
RUN npm install

# Command to run the Electron application using npm start
CMD ["npm", "start"]
```

Build the Docker image with the following command:

```bash

docker build -t electron-app .
```
### 2. Allow Display Forwarding

To allow the Docker container to connect to your display, run:

```bash

xhost +local:docker
```

### 3. Run the Docker Container

Once the image is built, you can run the Docker container using the following command:

```bash

docker run --rm -it \
    --env="DISPLAY" \
    --env="XAUTHORITY=$XAUTH" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    electron-app
```





