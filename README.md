# BorrarDuplicados.sh
Elimina duplicados con fdupes.
El código solicita la ruta de la carpeta que queremos explorar en busca de duplicados. Luego nos pide la ruta relativa de la carpeta con archivos candidatos a ser borrados en caso de estar duplicados en otra carpeta. Por último muestra la lista de archivos duplicados y pregunta si deseamos eliminarlos.
# BorrarDuplica2.sh
Elimina duplicados con fdupes
Pide la dirección absoluta de una carpeta y luego pregunta si queremos actualizar la fecha de modificación de los archivos para darle prioridad a la hora de eliminar los archivos de esa ruta.
Luego nos pide la dirección absoluta de una segunda carpeta donde buscar también duplicados.
Por último ejecuta el touch si ha sido programado y busca duplicados, generando un archivo con éstos y pregunta si queremos borrarlos. En este último paso vuelve a llamar a fdupes, pero esta vez elimina los archivos y luego nos muestra la lista de archvios duplicados eliminados.
# Pendiente
Quiero poder leer el primer archivo generado por fdupes y recorrerlo eliminando los duplicados. De esta forma evito tener que llamar 3 veces a fdupes ganando así mucho tiempo y necesitando menos recursos.
