Comandos útiles

``` bash
# Separating files by column number
awk 'BEGIN{ FS = "\t" }; { if(NF != 7){ print >> "UFO_fixme.tsv"} \
else { print >> "UFO_OK.tsv" } }' UFO-Nov-Dic-2014.tsv
```
```bash
# Validate column empthy
awk -F'|' '!length($29)' kmr_20190117.csv
```
