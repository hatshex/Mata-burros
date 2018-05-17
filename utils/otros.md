
## SCP - Download information
scp dinger@13.66.58.166:/home/dinger/muestrajson_20180517.json ./

## VIM in Ex mode - Delete first row
ex -sc '1d|x' file.txt

## Review and Change Encode
file -i file.txt
iconv -f ISO-8859-1 -t UTF-8 file.txt -o fileutf.txt

## Background process
nohup /usr/share/logstash/bin/logstash --path.data /data/tmp -f file.conf &
tail -f nohup.out

## Tunel ssh
ssh -L 8083:localhost:8083 user1@servidor1			
ssh -L 8083:localhost:8083 user2@servidor2			
ssh -L 8083:localhost:8080 -N user3@servidor3
