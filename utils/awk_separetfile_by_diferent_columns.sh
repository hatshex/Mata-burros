 awk 'BEGIN{ FS = "\t" }; { if(NF != 7){ print >> "UFO_fixme.tsv"} \
else { print >> "UFO_OK.tsv" } }' UFO-Nov-Dic-2014.tsv
