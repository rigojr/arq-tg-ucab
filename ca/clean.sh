# Cleans the setup
killall fabric-ca-server 2> /dev/null

rm -rf ./server/* 2> /dev/null

rm -rf ./client/* 2> /dev/null

echo "TODOS LOS ARCHIVOS EN ./client & ./server FUERON REMOVIDOS"