# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
echo " ****** CONFIGURANDO VARIABLES DE ENTORNO ****** "

export FABRIC_CA_SERVER_HOME=`pwd`/server
export FABRIC_CA_SERVER_TLS_ENABLED=true
export FABRIC_CA_SERVER_CA_NAME=tlsca.ucab.edu.ve
export FABRIC_CA_SERVER_CSR_CN=tlsca.ucab.edu.ve
export FABRIC_CA_SERVER_CSR_HOSTS=0.0.0.0
export FABRIC_CA_SERVER_CA_KEYFILE=$FABRIC_CA_SERVER_HOME/crypto/tlsca.ucab.edu.ve-key.pem
export FABRIC_CA_SERVER_CA_CERTFILE=$FABRIC_CA_SERVER_HOME/crypto/tlsca.ucab.edu.ve-cert.pem
export FABRIC_CA_SERVER_DEBUG=true

# Used in go command - sleeps between start & enroll
SLEEP_TIME=4

function usage {
    echo    "No action taken. Please provide argument"
    echo    "Usage:    ./server.sh   start |  stop  | enroll | enable-removal"
    echo    "                                         enrolls the admin identity for the server"
    echo    "                                         enable-remove Restarts server with removal enabled"
}

# Enroll the bootstrap admin identity for the server
function enroll {
    
    DEFAULT_CLIENT_CONFIG_YAML="setup/fabric-ca-client-config.yaml"

    export FABRIC_CA_CLIENT_HOME=`pwd`/client/tlscaserver/admin
    export FABRIC_CA_CLIENT_TLS_CERTFILES=`pwd`/server/tls-cert.pem
    mkdir -p $FABRIC_CA_CLIENT_HOME

    cp $DEFAULT_CLIENT_CONFIG_YAML  "$FABRIC_CA_CLIENT_HOME/"

    fabric-ca-client enroll -d -u https://tls-ucab-admin:tls-ucab-adminpw@0.0.0.0:7150
}

# Starts the CA server
function start {

    echo "INICIALIZANDO SERVIDOR"
    # Inicializando el servidor en Background
    fabric-ca-server start -d -b tls-ucab-admin:tls-ucab-adminpw --port 7150 --cfg.identities.allowremove 2> $FABRIC_CA_SERVER_HOME/server.log &
    echo "SERVIDOR INICIALIZADO, LOGS DISPONIBLES EN >>> $FABRIC_CA_SERVER_HOME/server.log <<<"
    
    # Creando los directorios necesarios para guardar todos los materias criptograficos de las organizaciones
    echo "3. CREANDO LOS DIRECTORIOS ADMINISTRATIVOS PARA EL CLIENTE"
    ROUTE_ORG_CLIENT=`pwd`/client/
    mkdir -p $ROUTE_ORG_CLIENT/ucab/admin
    mkdir -p $ROUTE_ORG_CLIENT/ucabor/admin
    mkdir -p $ROUTE_ORG_CLIENT/ce/admin
    mkdir -p $ROUTE_ORG_CLIENT/sce/admin
    echo "CREADO LOS DIRECTORIOS CON EXITO"

    # Copiando los archivos de configuracion al directorio hogar de cada uno de los administradores
    echo "4. COPIANDO ARCHIVOS DE CONFIGURACION AL DIRECTORIO HOGAR DE LOS ADMINISTRADORES DE LAS ORGANIZACIONES"
    cp setup/ucab/fabric-ca-client-config.yaml  client/ucab/admin
    cp setup/ucabor/fabric-ca-client-config.yaml  client/ucabor/admin
    cp setup/ce/fabric-ca-client-config.yaml  client/ce/admin
    cp setup/sce/fabric-ca-client-config.yaml  client/sce/admin
    echo "COPIADO LOS ARCHIVOS DE CONFIGURACIONS A LOS DIRECTORIOS HOGAR"


}

function init {

    echo "INICIALIZANDO SERVIDOR"
    # Inicializando el servidor en Background
    fabric-ca-server init -d -b tls-ucab-admin:tls-ucab-adminpw --port 7150 --cfg.identities.allowremove 2> $FABRIC_CA_SERVER_HOME/server.log &
    echo "SERVIDOR INICIALIZADO, LOGS DISPONIBLES EN >>> $FABRIC_CA_SERVER_HOME/server.log <<<"
    sleep 1s
    cp server/msp/keystore/*_sk server/crypto/tlsca.ucab.edu.ve-key.pem
    
}


if [ -z $1 ];
then
    usage;
    exit 1
fi

case $1 in

    "start")
        # Kill CA server process if it is already running
        killall fabric-ca-server 2> /dev/null
        start
        ;;
    "init")
        # Kill CA server process if it is already running
        init
        ;;
    "stop")
        killall fabric-ca-server 2> /dev/null
        echo "Servidor DETENIDO, logs disponibles en = $FABRIC_CA_SERVER_HOME/server.log"
        ;;
    "enroll")
        enroll
        ;;
    "enable-removal")
        enable-removal
        ;;
    "go")
        start
        echo "Sleeping for $SLEEP_TIME seconds"
        sleep $SLEEP_TIME
        enroll
        ;;
    *) echo "ARGUMENTO NO VALIDO"
       usage
       ;;
esac





#echo "VARIABLES DE ENTORNO PARA LEVANTAR LA TLSCA"
#echo $FABRIC_CA_SERVER_CA_CERTFILE
#echo $FABRIC_CA_SERVER_CA_KEYFILE
#echo $FABRIC_CA_SERVER_CA_NAME
#echo $FABRIC_CA_SERVER_CSR_CN
#echo $FABRIC_CA_SERVER_CSR_HOSTS
#echo $FABRIC_CA_SERVER_DEBUG
#echo $FABRIC_CA_SERVER_HOME
#echo $FABRIC_CA_SERVER_TLS_ENABLED