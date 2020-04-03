# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Creates/Enrolls the Peer's identity + Sets up MSP for peer
# Script needs to be executed for the peers setup
# PS: Since Register (step 1) can happen only once - ignore register error if you run script multiple times

function usage {
    echo "./register-enroll-peer.sh ORG_NAME  PEER_NAME"
    echo "     Sets up the Peer identity and MSP"
    echo "     Script will fail if CA Server is not running!!!"
}

if [ -z $1 ];
then
    usage
    echo " SUMINISTRE ORG Name "
    exit 0
else
    ORG_NAME=$1
fi

if [ -z $2 ];
then
    usage
    echo  " SUMINISTRE PEER_NAME "
    exit 0
else
    PEER_NAME=$2
fi

# Function checks for the availability of the 
function    checkCopyYAML {
    SETUP_CONFIG_CLIENT_YAML="setup/$ORG_NAME/$PEER_NAME/fabric-ca-client-config.yaml"
    if [ -f "$FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml" ]
    then 
        echo "EMPLEANDO ARCHIVO YAML EN LA CARPETA"
    else
        echo "COPIANDO EL ARCHIVO YAML EN$SETUP_CONFIG_CLIENT_YAML "
        mkdir -p $FABRIC_CA_CLIENT_HOME
        cp  "$SETUP_CONFIG_CLIENT_YAML" "$FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml"
    fi
}

# Function sets the FABRIC_CA_CLIENT_HOME
function    setFabricCaClientHome {
    CA_CLIENT_FOLDER="client/$ORG_NAME"
    export FABRIC_CA_CLIENT_HOME="$CA_CLIENT_FOLDER/$IDENTITY"
}

export FABRIC_CA_CLIENT_HOME=`pwd`/client/tlscaserver/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=`pwd`/server/tls-cert.pem

fabric-ca-client register -d --id.name $PEER_NAME --id.secret pw --id.type peer -u https://0.0.0.0:7150
IDENTITY=$PEER_NAME
setFabricCaClientHome
checkCopyYAML
fabric-ca-client enroll -d -u https://$PEER_NAME:pw@localhost:7150




