# Aplicacion de Banco

Trabajo final integrador de la materia TTPS-Ruby

Alumno: Joaquin Fontana
Legajo: 18569/3

Requisitos Tecnicos:

- Version de Ruby: 2.7.6

- Version del framework Ruby on Rails: 7.0.4

- Base de Datos: PostgreSQL, Version: 13

Decisiones de diseño que considero importantes:

- Cuando se elimina una sucursal que ya no tiene turnos pendientes, tambien se eliminan los turnos completados y los usuarios con rol personal bancario asociados a esa sucursal

- Para indicar que una sucursal esta cerrada un dia de la semana, se debe ingresar en la fecha de inicio y de fin el horario: 00:00

- Un cliente puede visualizar la informacion de las sucursales, con el fin de saber los horarios de las mismas

- Un administrador puede crear clientes,personal bancario y administradores, y no solo personal bancario y administradores

Pasos para iniciar la aplicacion:

1. Clonar el repositorio TTPS-Ruby-TpIntegrador a alguna carpeta
2. Ingresar en el archivo config/database.yml y modificar las lineas 20 y 21 con su nombre y contraseña de su usuario de PostgreSQL
3. Dentro de la carpeta clonada, en una terminal ejecutar los siguientes comandos:
   1. bundle install (Instala todos los paquetes necesarios)
   2. rails db:create (Crea la base de datos)
   3. rails db:migrate (Crea todas las tablas y relaciones necesarias)
   4. rails db:seed (Ingresa valores por defecto a la base de datos)
   5. Esta aplicacion utiliza un framework de css llamado tailwind, por lo que si quiere iniciar la aplicacion debe:
      1. Si esta en linux ejecutar el comando: ./bin/dev
      2. Si se encuentra en Windows, en una terminal ejecutar: rails s; y en otra ejecutar: rails tailwindcss:watch. Ambas terminales deben estar corriendo al mismo tiempo
4. Disfrutar!!

Usuarios Generados por la seed:

- Administrador -> nombre de usuario: admin , contraseña: admin
- Cliente -> nombre de usuario: cliente , contraseña: 123
- Personal Bancario -> nombre de usuario: personal , contraseña: 123
