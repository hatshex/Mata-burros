# Eliminar espacios entre palabras y al final de un renglón
sed -e 's/  */ /g' -e 's/^ *\(.*\) *$/\1/'

# Muestra el código ascci de las palabras, para eliminar caracteres raros
od -bc file.log   | head -1
