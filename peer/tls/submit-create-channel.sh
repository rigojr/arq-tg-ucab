# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# This script simply submits the channel create transaction transaction
function usage {
    echo    "Usage:     ./submit-create-channel   ORG_NAME  [IDENTITY default=admin]  [ORDERER_ADDRESS default=localhost:7050]"
    echo    "           Uses the Organization Identity provided to submit transaction"
    echo    "           Script will fail if the Orderer is not up !!!"
}

# Org Name is needed
if [ -z $1 ]
then
    usage
    echo ' SUMINISTRE ORG_NAME '
    exit 1
else 
    ORG_NAME=$1
fi

# Identity check
if [ -z $2 ]
then
    IDENTITY=admin
else 
    IDENTITY=$2
fi

# Orderer address
if [ -z $3 ]
then
    ORDERER_ADDRESS="localhost:7050"
    echo " ================ EMPLEANDO EL ORDENADOR POR DEFECTO localhost:7050 ================"
else 
    ORDERER_ADDRESS=$3
fi

# Channel transaction file location
# The transaction should have been signed by one or more admins based on policy
CHANNEL_TX_FILE="$PWD/../orderer/ucab-channel.tx"

# Sets the environment variables for the given identity
source set-identity.sh  

# Submit the channel create transation
peer channel create -o $ORDERER_ADDRESS -c ucabchannel -f $CHANNEL_TX_FILE --tls --cafile /vagrant/ucab/tls/crypto-config/ordererOrganizations/ucabor.ucab.edu.ve/tlsca/tlsca.ucabor.ucab.edu.ve-cert.pem

echo " ================ LISTO, REVISE LOS LOGS DEL ORDENADOR POR POSIBLES ERRORES ================ "

















