# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Limpia los archivos de configuración y asesina el binario del server.
killall fabric-ca-server 2> /dev/null

rm -rf ./server/* 2> /dev/null

rm -rf ./client/* 2> /dev/null

echo " ================ TODOS LOS ARCHIVOS EN ./client & ./server FUERON REMOVIDOS ================ "