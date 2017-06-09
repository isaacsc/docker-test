# Dockerizando una aplicacion Node.js

Ejemplo para crear un contenedor Docker de una sencilla API hecha con Express.

## Estructura de directorios

~~~
Dockerfile
.dockerignore
src/
    package.json
    app.js
~~~

## Creación de la API con Node

Dentro del directorio /src, que es donde va a vivir el API, creamos un fichero *package.json*

~~~~
{
  "name": "docker-node-api",
  "version": "1.0.0",
  "description": "Test Docker y Node",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.13.3"
  }
}
~~~~

Después creamos el archivo app.js que definirá nuestra API

~~~
const express = require('express');

// Constants
const PORT = 3000;

// App
const app = express();
app.get('/', (req, res) => {  
  res.send('Hola Mundo!!!')
})

app.get('/:nombre', (req, res) => {  
  res.send(`Hola ${req.params.nombre}!`)
})

app.listen(PORT, (err) => {  
  console.log(`Server running on port ${PORT}`)
})
~~~

## Creación del archivo Dockerfile

Creamos un archivo vacio llamado #Dockerfile#:

` touch Dockerfile`

Una vez creado lo editamos con el siguiente código

~~~
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
~~~

## Fichero .dockerignore

Creamos un fichero #.dockerignore# en el mismo directorio que nuesto #Dockerfile# con el siguiente contenido

~~~
node_modules
npm-debug.log
~~~

Esto evitará que los módulos locales y los logs de depuración se copien dentro de la imagen de Dockery puedan sobreescribir los instalados.

## Construyendo la imagen

Accedemos desde el terminal al directorio en el que se encuentra el fichero #Dockerfile# y ejecutamos la siguiente instrucción

~~~
$ docker build -t <your username>/node-api .
~~~

El flag #-t# nos permite etiquetar la imagen para que sea más fácil de identificar al listarlas, para ello usaremos el comando `$ docker images` que nos devolverá algo asi:

~~~
# Example
REPOSITORY                      TAG        ID              CREATED
node                            boron      539c0211cd76    3 weeks ago
<your username>/node-web-app    latest     d64d3505b0d2    1 minute ago
~~~

## Ejecutar la imagen

~~~
docker run -d --name "nodejs" -p 5000:8080 example/nodejs
~~~

Ejecutando la imagen con #-d# el conatiner se ejecuta en segundo plano (detached mode). El flag #-p# hace una redirección de un puerto público (5000) a uno privado dentro del contenedor. Con #--name# asignamos un nombre al container de manera que sea más fácil identificarlo al listar los contenedores, por último especificamos la imagen que acabamos de contruir.

## Más instrucciones de Docker

* Listar contenedores en ejecución
`docker ps`

* Listar todos los contenedores (en ejecución e inactivos)
`docker ps -a`

* Listar todas las imágenes
`docker images`

* Imprimir log
`docker logs <container id>`

* Parar un contenedor
`docker stop <container id>` o `docker stop <container name>` 

* Reiniciar un contenedor
`docker start <container id>` o `docker start <container name>`

* Eliminar uno o varios contenedores
`docker rm -f <container ids>`

* Eliminar uno o varias imagenes
`docker rmi <images ids>`