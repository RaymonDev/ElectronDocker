FROM ubuntu:20.04

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
