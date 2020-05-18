# Reniec Bash
## Info
El proyecto trata de automarizar la busqueda en el enlace: http://www.reniec.gob.pe/concer/concer.do , de esta manera podrás buscar la fechas de nacimiento de una persona solo deduciendo ciertos patrones.

## Requerimientos
El proyecto corre en linux, ya que esta usando los comandos de bash.
El proyecto requiere de que el sistema linux tenga una version funcional de cURL.

## Uso
Para usar el script basta con hacer un **git clone** al repositorio y luego ejecutar lo siguiente.

	./reniec.sh APELLIDOP APELLIDOM NONMBRE DIAI DIAF MESI MESF AÑOI AÑOF

Siendo:
* **APELLIDOP** el apellido paterno.
* **APELLIDOM** el apellido materno.
* **NOMBRE** el nombre o los nombres, en que caso de más de uno especificarlo entre comillas *"nombre1 nombre2 nombre3"*.
* **DIAI** el dia inicial del rango
* **DIAF** el dia final del rango
* **MESI** el mes inicial del rango
* **MESF** el mes final del rango
* **AÑOI** el año inicial del rango
* **AÑOF** el año final del rango

**Recomendacion: Si el comando demora mucho, verifique en otra terminal si es que se creo el fichero en el directorio outputs/**

Autor: Eduardo Sarria (Desdes)
