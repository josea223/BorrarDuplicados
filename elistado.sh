#!/bin/bash
#mar 02 may 2017 11:13:25 -04 
# FUNCIONAMIENTO
# Envio 2 variables:
# Primero la ruta del listado con los duplicados a eliminar.
# Segundo el string que determina que archivos borrar dentro de la lista

# PENDIENTE
# Después de leer el listado comprobar que existen los archivos seleccionados 
# para ser eliminados [ -f "" ] Creo?
# Sólo muestro aquellos que todavía se encuentran en la ruta original
# y que se pueden borrar (rw) Creo?

# Concatenar fdupes -rf > listado con este script
# Luego muevo el listado a una carpeta con otros logs
# Pasar todos los echos a printf, según recomendado

#Limpio la pantalla para facilitar el proceso
clear

# Introduce la ruta del archivo que contiene el listado de duplicados junto al comando:
listado="$1"
salvar="$2"

# Compruebo la ruta del listado
if [ -r "$listado" ]; then
 printf "Hola %s.\nEl listado ha sido localizado y es legible\n" $LOGNAME
fi
# Compruebo si existe cadena de selección
if [ -z "$salvar" ]; then
 printf "[?] Cadena para la selección de borrado vacía\n\n"
fi

# Mostrar los registro seleccionados para borrar
echo -e "Estos archivos serán eliminados:\n"

 while read archivo
 do
  if [ ! -z "$archivo" ] && [[ "$archivo" == *"$salvar"* ]]; then
  echo [-][del] $archivo
  fi	
 done < $listado

echo -e "\nEliminar estos duplicados [si/no]"
read eliminar_sn

if [ "$eliminar_sn" = 'si' ]; then
echo -e "\nEliminando archivos ...\n"

 while read archivo
 do
  if [ ! -z "$archivo" ] && [[ "$archivo" == *"$salvar"* ]]; then
  rm -f "$archivo" 2>&1
  echo [deleted] $archivo
  fi	
 done < $listado
echo -e "\nDuplicados Eliminados"
else
echo -e "\nNingún archivo a sido eliminado"
fi

