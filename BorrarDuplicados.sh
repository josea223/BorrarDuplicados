#!/bin/bash
# Toca los archivos de la carpeta
echo Carpeta con los duplicados a eliminar [ruta completa o relativa]
read borrar
# cd borrar
echo Escribe no para evitar modificar la hora de cambio de los archivos de la carpeta [touch]
read touch
if [ "$touch" = 'no' ]; then echo Se borrarán los archivos según fecha de modificación actual.
else
find $borrar/* -print -exec touch {} \;
echo Actualizada fecha de modificación de los archivos en $borrar
fi
# Carpeta con los duplicados a conservar
echo Carpeta con los duplicados a conservar
read conservar
echo Acción a realizar [borrar/prueba]
read accion
# Ejecuto fdupes
if [ "$accion" = 'borrar' ]; then
fdupes -rdN "$borrar" "$conservar" > ./logs/ArchivosEliminados.txt
echo Archivos eliminados:
cat ./logs/ArchivosEliminados.txt
else fdupes -r "$borrar" "$conservar" > ./logs/ArchivosAEliminar.txt
echo Archivos duplicados candidatos a ser eliminados:
cat ./logs/ArchivosAEliminar.txt
fi
