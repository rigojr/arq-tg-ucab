# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Utility for
# 1. Initializing the CA server     a) copy the server YAML to ./server b) server.sh  start
#    Validate by checking the logs under ./server/server.log
#    To use different config - replace the ./server/fabric-ca-server-config.yaml
# 2. Starting the CA Server         a) server.sh  start
# 3. Stopping the CA Server
# 4. Enrolling the Root CA Server admin

export FABRIC_CA_SERVER_HOME=`pwd`/server
DEFAULT_SERVER_CONFIG_YAML="setup/fabric-ca-server-config.yaml"
DEFAULT_CLIENT_CONFIG_YAML="setup/fabric-ca-client-config.yaml"

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
    
    export FABRIC_CA_CLIENT_HOME=`pwd`/client/caserver/admin

    if [ -f "$FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml" ]
    then
        echo "SE ENCONTRO EL ARCHIVO DE CONFIGURACION >>> fabric-ca-client-config.yaml <<<"
    else
        echo "NO EXISTE EL ARCHIVO DE CONFIGURACION >>> fabric-ca-client-config.yaml <<<"
        echo "CREANDO LA RUTA $FABRIC_CA_CLIENT_HOME <<<"
        mkdir -p $FABRIC_CA_CLIENT_HOME
        echo "COPIANDO EL ARCHIVO DE CONFIGURACION DE LA RUTA POR DEFECTO"
        cp $DEFAULT_CLIENT_CONFIG_YAML  "$FABRIC_CA_CLIENT_HOME/"
    fi

    fabric-ca-client enroll -u http://admin:pw@localhost:7054
}

# Starts the CA server
function start {

    # Check the ./server for SERVER Yaml file
    if [ -f "./server/fabric-ca-server-config.yaml" ]
    then   
        echo "1. SE ENCONTRO EL ARCHIVO DE CONFIGURACION >>> fabric-ca-server-config.yaml <<<"
    else
        echo "1. NO EXISTE EL ARCHIVO DE CONFIGURACION >>> fabric-ca-server-config.yaml <<<"
        echo "COPIANDO EL ARCHIVO DE CONFIGURACION DE LA RUTA POR DEFECTO"
        cp $DEFAULT_SERVER_CONFIG_YAML  ./server
    fi
    echo "2. INICIALIZANDO SERVIDOR"
    # Inicializando el servidor en Background
    fabric-ca-server start 2> $FABRIC_CA_SERVER_HOME/server.log &
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

function enable-removal {
    if [ -f "./server/fabric-ca-server.db" ]
    then   
        # DB file not there - so just kill & start 
        killall fabric-ca-server 2> /dev/null
        fabric-ca-server start --cfg.identities.allowremove 2> $FABRIC_CA_SERVER_HOME/server.log &
        echo "identity removal HABILITADO."
    else
	    echo "Error: INICIE EL SERVIDOR ANTES DE HABILITAR EL indentity removal"
        exit 0
    fi
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


