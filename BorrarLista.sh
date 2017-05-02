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

# Marco las líneas vacías con un "-"
  if [ "$archivo" = '' ]; then echo "-"

# Compruebo la cadena a salvar. Si se encuentra en la ruta del archivo no se borra
  elif [[ "$archivo" == *"$salvar"* ]]; then
	 echo [+] "$archivo"
# La ruta del archivo no coincide con la cadena a salvar, por lo tanto elimino el duplicado
  else
  rm -f "$archivo"
  echo [-] $archivo
  fi
done < $listado

# En el caso de que no se introduzca ninguna cadena a salvar, directamente borro los duplicados
else
while read archivo
do
rm -f "$archivo"
echo [-] $archivo
done < $listado
fi
