FROM ubuntu:20.04

# Configurar las variables de entorno para evitar la configuración interactiva de tzdata
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Europe/Madrid

# Instalar Node.js, NPM, y dependencias adicionales necesarias para Electron
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

# Instalar Node.js 18.x (compatible con Electron 32.x)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Establecer el directorio de trabajo en /app dentro del contenedor
WORKDIR /app

# Copiar todos los archivos desde el host a la carpeta /app en el contenedor
COPY appw /app

# Instalar las dependencias de la aplicación
RUN npm install

# Comando para ejecutar la aplicación Electron usando npm start
CMD ["npm", "start"]

