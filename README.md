# NEXU Backend Test


## Requerimientos


- Docker
- docker-compose
- Postman


## Levantar aplicación


Para poder levantar la aplicación una vez clonado el repositorio, seguimos los siguientes pasos:


```sh
cd nexu-backend-test


docker-compose build && docker-compose up
#Esperamos a que docker termine de construir y levantar las imágenes de ruby y postgresql
```


una vez iniciados los contenedores, en otra terminal ejecutamos los siguientes comandos:
```sh
# procedemos a crear las bases de datos (development y test)
docker exec -it nexu-backend-test rails db:create


# ejecutamos las migraciones pendientes
docker exec -it nexu-backend-test rails db:migrate


# cargamos la información necesaria en la base de datos
docker exec -it nexu-backend-test rails db:seed
```


## Pruebas


En este punto, podemos importar el archivo [Nexu Test.postman_collection.json] a postman para poder probar la API


## RSpec


De igual manera, también se pueden ejecutar los test unitarios con rspec, de la siguiente manera


```sh
docker exec -it nexu-backend-test bundle exec rspec
```
## Comentarios
Se fijó el objetivo de dejar una aplicación funcional, con validaciones (básicas) y pruebas unitarias (escenarios más críticos).

En lo personal stoy muy satisfecho con la realización de esta prueba, independientemente de la finalidad y resultado, me pareció una actividad bastante interesante y retadora.


Todo comentario y crítica constructiva es bienvenida.
