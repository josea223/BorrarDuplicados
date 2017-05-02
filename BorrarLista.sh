#!/bin/bash

clear

# Introduce la ruta del archivo que contiene el listado de duplicados junto al comando:
listado="$1"

# Archivos del listado a mantener
echo Introduce una cadena contenida en los archivos que no quieres borrar o deja en blanco para borrar todos los duplicados.
read salvar

# En caso de introducir una ruta relativa se modifican/marcan los candidatos a duplicados
if [ ! -z "$salvar" ]; then
#find $ruta/$duplicados/* -print -exec touch {} \;

# Borra los duplicados listados en el archivo y salva los que coinciden con la cadena detallada antes
while read archivo
do
  if [ $salvar in $archivo]; then echo [+] "$archivo"
  else
  rm -f "$archivo"
  echo [-] $archivo
  fi
done < $listado
