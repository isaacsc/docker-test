# Definimos la imagen desde la que quermos construir la nuestra
FROM node:6

# Crear el directorio app, que será nuestro directorio de trabajo
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Instalar las dependencias de app
COPY ./src/package.json /usr/src/app/
RUN npm install

# Copiamos el código del API dentro de la imagen de Docker
COPY ./src /usr/src/app

# Definimos el puerto que quermos utilizar
EXPOSE 3000

# Definimos el comando que se usará para ejecutar la app
CMD [ "npm", "start" ]