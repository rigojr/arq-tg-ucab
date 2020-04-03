# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Creates/Enrolls the ucabor's identity + Sets up MSP for ucabor
# Script may executed multiple times 
# PS: Since Register (step 1) can happen only once - ignore register error if you run multiple times

# Function checks for the availability of the 
function    checkCopyYAML {
    SETUP_CONFIG_CLIENT_YAML="setup/ucabor/ucabor/fabric-ca-client-config.yaml"
    if [ -f "$FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml" ]
    then 
        echo "EMPLEANDO ARCHIVO YAML EN LA CARPETA"
    else
        echo "COPIANDO EL ARCHIVO YAML EN $SETUP_CONFIG_CLIENT_YAML "
        mkdir -p $FABRIC_CA_CLIENT_HOME
        cp  "$SETUP_CONFIG_CLIENT_YAML" "$FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml"
    fi
}

# Function sets the FABRIC_CA_CLIENT_HOME
function    setFabricCaClientHome {
    CA_CLIENT_FOLDER="client/ucabor"
    export FABRIC_CA_CLIENT_HOME="$CA_CLIENT_FOLDER/$IDENTITY"
}

export FABRIC_CA_CLIENT_HOME=`pwd`/client/tlscaserver/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=`pwd`/server/tls-cert.pem

fabric-ca-client register -d --id.name ucabor --id.secret pw --id.type orderer -u https://0.0.0.0:7150
IDENTITY="ucabor"
setFabricCaClientHome
checkCopyYAML
fabric-ca-client enroll -d -u https://ucabor:pw@0.0.0.0:7150





