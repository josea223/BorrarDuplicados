#!/bin/bash
# Introduce la ruta de la carpeta a analizar
echo Carpeta a analizar en busca de duplicados a eliminar [ruta absoluta]
read ruta

# Actualizar la fecha de modificación de candidatos a duplicados [touch]
# Evita que en caso de duplicados, aquellos en las restantes carpetas tengan priporidad para no ser eliminados.
echo Carpeta con duplicados a eliminar modificando su fecha de modificación [ruta relativa/'']
read duplicados

# Error ???
#if [ ! -z "$duplicados" ] && find $ruta/$duplicados/* -print -exec touch {} \;
if [ ! -z "$duplicados" ]; then find $ruta/$duplicados/* -print -exec touch {} \;
fi

# Primer análisis de duplicados y muestra en pantalla
fdupes -r "$ruta" > ./logs/ArchivosAEliminar.txt
echo Archivos duplicados candidatos a ser eliminados:
cat ./logs/ArchivosAEliminar.txt

# Seleccionar la opción de borrar o no los duplicados
echo Borrar los duplicados [si/no]
read borrar_sn
if [ "$borrar_sn" = 'si' ]; then
fdupes -rdN "$ruta" > ./logs/ArchivosEliminados.txt
echo Se eliminaron los siguientes archivos
cat ./logs/ArchivosEliminados.txt
echo Duplicados eliminados.
else
echo Acción cancelada. No se eliminó ningún archivo.
fi
