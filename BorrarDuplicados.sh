#!/bin/bash
# Creo o marco los archivos del log
touch ./logs/ArchivosAEliminar.txt
touch ./logs/ArchivosEliminados.txt

# Introduce la ruta de la carpeta a analizar
printf "Carpeta a analizar en busca de duplicados a eliminar [ruta absoluta]\n"
read ruta

# Actualizar la fecha de modificación de candidatos a duplicados [touch]
# Evita que en caso de duplicados, aquellos en las restantes carpetas tengan priporidad para no ser eliminados.
printf "\nCarpeta con duplicados a eliminar modificando su fecha de modificación [ruta relativa]\n"
read duplicados
printf "\n"

# En caso de introducir una ruta relativa se modifican/marcan los candidatos a duplicados
# Error -> if [ ! -z "$duplicados" ] && find $ruta/$duplicados/* -print -exec touch {} \;
if [ ! -z "$duplicados" ]; then
 find $ruta/$duplicados/* -print -exec touch {} \;
 printf "\nActualizadas los tiempos de modificación de los archivos seleccionados.\n"
fi

sleep 1

# Primer análisis de duplicados y muestra en pantalla
fdupes -rf "$ruta" > ./logs/ArchivosAEliminar.txt
printf "\nArchivos duplicados candidatos a ser eliminados:\n\n"
cat ./logs/ArchivosAEliminar.txt

# Seleccionar la opción de borrar o no los duplicados
printf "Borrar los duplicados [si/no]\n"
read borrar_sn

if [ "$borrar_sn" = 'si' ]; then
 fdupes -rdN "$ruta" > ./logs/ArchivosEliminados.txt
 printf "\nSe eliminaron los siguientes archivos:\n"
 cat ./logs/ArchivosEliminados.txt
 printf "Duplicados eliminados."
else
 printf "Acción cancelada. No se eliminó ningún archivo."
fi
