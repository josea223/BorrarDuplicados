#!/bin/bash
# 02/05/2017

# FUNCIONAMIENTO
# Recoge los datos de CrearListado.sh
# Muestra los archivos duplicados del listado y consulta si eliminarlos
# Consulta si borra carpetas vacías
# Consulta si borrar el listado o archivarlo

# PENDIENTE
# Después de leer el listado comprobar que existen los archivos seleccionados 
# para ser eliminados [ -f "" ] Creo?
# Sólo muestro aquellos que todavía se encuentran en la ruta original
# y que se pueden borrar (rw) Creo?


# Ruta a carpeta de archivo de listados
RR_archivar="archivo"
# Contadores. En caso de no existir registros muestra el 0
k=0
j=0
i=0


#Limpio la pantalla para facilitar el proceso
clear


# Compruebo la ruta del listado y que sea legible
if [ -r "$RA_listado" ]; then
 printf "Hola %s.\nEl listado ha sido localizado y es legible\n" $LOGNAME
else
 printf "Listado no localizado o no legible en:\n%s\n" "$RA_listado"
fi
# ---------------------------------------------------

sleep 1

# Mostrar los registro seleccionados para borrar
printf "Estos archivos serán eliminados:\n"

sleep 2

 while read archivo
 do
  if [ ! -z "$archivo" ] && [[ "$archivo" == *"$salvar"* ]] && [[ "$archivo" != "# "* ]]; then
  printf "\n[-] $archivo"
  ((i = $i + 1 ))
  fi
 done < "$RA_listado"

printf "\n\nSe han encontrado %s candidatos a ser eliminados\n" "$i"
# --------------------------------------------------------------------

# Consulta si borra todos los registros o les aplica un filtro
printf "\nReducir el número de duplicados eliminados o pulse ENTER para eliminarlos todos:\n"
read filtro

# Cuento cuantos duplicados quedan ahora y consulto si los elimino
 while read archivo
 do
  if [ ! -z "$archivo" ] && [[ "$archivo" == *"$filtro"* ]] && [[ "$archivo" != "# "* ]]; then
  (( k = $k + 1 ))
  printf "\n[%d] %s" "$k" "$archivo"
  fi	
 done < "$RA_listado"

printf "\n\nEliminar estos %d duplicados [si/no]\n" $k
read eliminar_sn
# ----------------------------------------------------------------

# ELIMINA ARCHIVOS ----------------------------------------------
if [ "$eliminar_sn" = 'si' ]; then
printf "\nEliminando archivos ...\n"

sleep 1

 while read archivo
 do
  if [ ! -z "$archivo" ] && [[ "$archivo" == *"$filtro"* ]] && [[ "$archivo" != "# "* ]]; then
  rm -vf "$archivo" 2>&1
  (( j = $j + 1 ))
  fi	
 done < "$RA_listado"

printf "\nSe han eliminado %s duplicados\n" "$j"
else
printf "\nNingún archivo a sido eliminado\n"
fi
# ------------------------------------------------------------------


# Borrar carpetas vacías
printf "\nBorrar carpetas vacias [si/no]\n"
read carpetas_sn
if [ "$carpetas_sn" = 'si' ]; then
printf "Buscando carpetas vacías en:\n$RA_duplicados\n"

find "$RA_duplicados"/. -type d -empty -delete -print
fi
# --------------------------------------------------------------------

#Borrar listado
printf "\nEliminar listado [si/no]\n"
read listado_sn
if [ "$listado_sn" = 'si' ]; then
rm -f $RA_listado 2>&1
else
mv $RA_listado "$RA_logs/$RR_archivar/$nombre" 2>&1
fi
# ---------------------------------------------------------------------
