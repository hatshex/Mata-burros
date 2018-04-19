#!/bin/bash
# $1 carpeta de origen
# $2 carpeta destino
# Programa que limpia un archivo csv
./clean_csv.sh fuente/ destino/

rm -r $2
mkdir $2

for i in `ls -1 $1/*.csv`
do
  archivo=`basename $i`
  echo "Limpiando archivo ........"
  awk 'BEGIN{FS=",";OFS=","}
  {
  columnas=""
  siguiente=0

   for (i=1; i<=NF; i++) 
   {
    siguiente= i+1  

    if ($i~ /[^[ ][A-Z]|[ÁÉÍÓÚ]]/)
      {
        if (substr(columnas,length(columnas),length(columnas))=="|")
        {
          gsub(/^[ ]/,"\"",$i)

        }
        if ($siguiente ~ /[^[ ][A-Z]|[ÁÉÍÓÚ]]/)
          { 

            columnas=columnas$i","  }
        else
          { columnas=columnas$i"\"|"  }
      } 
    else
      {
      gsub(/^[ ]/,"",$i)
      columnas=columnas$i"|"
      }
   }
   columnas=substr(columnas,0,length(columnas)-1)

   print columnas
  }' $1/$archivo > $2/$archivo\.clean.psv

done
