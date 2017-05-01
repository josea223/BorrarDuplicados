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

# Listado provisional de duplicados
echo Listado de carpetas
echo $(ls $conservar)
echo Continuar [si/no]
read continuar_sn

if [ "$continuar_sn" = 'si' ]; then
echo Buscando duplicados ...
fdupes -r "$borrar" "$conservar" > ./logs/ArchivosAEliminar.txt
echo Archivos duplicados candidatos a ser eliminados:
cat ./logs/ArchivosAEliminar.txt

# Confirmación de borrado
echo ¿Seguro que quieres borrar los duplicados? [si/no]
read borrar_sn

# Ejecución de fdupes y borrado de duplicados
if [ "$borrar_sn" = 'si' ]; then
fdupes -rdN "$borrar" "$conservar" > ./logs/ArchivosEliminados.txt
echo Archivos eliminados:
cat ./logs/ArchivosEliminados.txt
else echo No se ha eliminado ningún archivo.
fi
fi
