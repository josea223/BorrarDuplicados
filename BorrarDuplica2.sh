#!/bin/bash
# Prepara los archivos para borrar duplicados con fdupes.
# Selecciona dos carpetas donde la primera se supone que tiene los posibles duplicados.
# La segunda carpeta tiene los originales ordenados.

# Toca los archivos de la carpeta
echo Carpeta con los duplicados a eliminar [ruta absoluta]
read borrar

# Opción de marcar carpeta para borrar en caso de conflicto con un duplicado en otra carpeta
echo Escribe \'touch\' para actualizar la hora de modificación de los archivos de la carpeta [touch/\'\']
read touch
if [ "$touch" = 'touch' ]; then
find $borrar/* -print -exec touch {} \;
echo Actualizada la fecha de modificación de los archivos en $borrar
else
#find $borrar/* -print -exec touch {} \;
echo Los archivos no han sido modificados y se eliminarán según su fecha de modificación actual.
fi

# Carpeta con los duplicados a conservar
echo Introducir ruta de la 2a carpeta con archivos duplicados
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
