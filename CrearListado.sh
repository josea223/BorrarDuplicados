#!/bin/bash
# 02/05/2007

# Crea un listado con archivos duplicados generado con fdupes
# Luego se envía el listado a el script DelListado.sh

# -------------------------------------------------------------

# RUTAS Y VARIABLES

# Ruta donde se guardan los logs
RA_logs='/mnt/Datos/Compartir/bin/logs/fdupes'

# Ruta donde se almacenan los logs no eliminados
RR_archivar="listados"

# Fecha de creación del listado que se utiliza como nombre del archivo
fecha=$(printf "%(%Y%m%d-%H%M%S)T" -1)

# Nombre del listado
nombre="$fecha.fdupes"

# ----------------------------------------------------------------

# Limpio la pantalla
clear

# Seleccionar carpeta a explorar por duplicados
printf 'Ruta absoluta a carpeta con archivos candidatos a duplicados:\n'
read RA_duplicados

# CREO LA LISTA
# ------------------------------------------------------------------------
# Ruta absoluta y nombre de la lista
RA_listado="$RA_logs/$nombre"

# Escribo el encabezado de la lista
printf "# Ruta: %s\n# Fecha: %s\n# Duplicados:\n\n" "$RA_duplicados" "$(printf "%(%d/%m/%Y a las %H:%M:%S)T" -1)" > "$RA_listado"

# Añado la lista de archivos duplicados
# -r -> recursivo: busca en todas las carpetas
# -f -> omite el primer resultado de cada set de duplicados
# -A -> omite archivos ocultos
fdupes -rfA "$RA_duplicados" >> "$RA_listado"
# --------------------------------------------------------------------------


# Muestro en pantalla la carpeta donde he guardado el listado.
ls -ahl $RA_logs

# Consulto si continúo con la función de borrado de los duplicados.
# Esta línea me da tiempo para que se genere el archivo.
printf "\nEjecutar script de borrado de duplicados [si/no]\n"
read ejecutar_sn

# Para pasar al siguiente script tengo que exportar las variables necesarias
if [ "$ejecutar_sn" = 'si' ]; then
export fecha
export nombre
export RA_logs
export RA_listado
export RA_duplicados

# Ejecuto el script de eliminación de duplicados
./josea/DelListado.sh
else

# Cancelo la operación de borrado y consulto si elimino el listado
 printf "\nEliminar listado [si/no]\n"
 read listado_sn
 if [ "$listado_sn" = 'si' ]; then
 rm -f $RA_listado 2>&1
 else

# Muevo el listado a la carpeta de archivo
 mv $listado "$RA_logs/$RR_archivar/$nombre" 2>&1
 fi

fi
