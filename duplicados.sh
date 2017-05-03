#!/bin/bash
# Creado: 02/05/2017
# Menú para lanzamiento de los distintos scripts de borrado.

# Borrar duplicados de una única ubicación
printf "Selecciona número de ubicaciones donde buscar duplicados [1/2]\n"
read ubicaciones_12

if [ "$ubicaciones_12" = 2 ]; then
./josea/BorrarDuplica2.sh
elif [ "$ubicaciones_12" = 1 ]; then
./josea/CrearListado.sh
#./josea/BorrarDuplicados.sh
else
printf "Por el momento solo hay 2 opciones\n"
fi
