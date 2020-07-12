# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Joins the Regular peer to ucab channel

function usage {
    echo ". join-regualr-peer-to-ucabchannel.sh   ORG_NAME   PEER_NAME  [PORT_NUMBER_BASE default=7050] [ORDERER_ADDRESS default=loclahost:7050"
    echo "               Make sure peer is started cleanly"
}

if [ -z $1 ];
then
    usage
    echo " SUMINISTRE EL ORG Name"
    exit 0
else
    ORG_NAME=$1
    echo "CAMBIANDO PEER_NAME DE LA ORGANIZACION = $ORG_NAME"
fi

if [ -z $2 ];
then
    usage
    echo  " SUMINISTRE PEER_NAME / NOMBRE DEL PEER "
    exit 0
else
    PEER_NAME=$2
fi

PORT_NUMBER_BASE=7050
if [ -z $3 ]
then
    echo " CONFIGURANDO PORT_NUMBER_BASE=7050"   
else
    PORT_NUMBER_BASE=$3
fi

if [ -z $4 ]
then
    ORDERER_ADDRESS="localhost:7050"
    echo " ================ Using default orderer localhost:7050 ================ "
else 
    ORDERER_ADDRESS=$4
fi

source set-env.sh  $ORG_NAME  $PEER_NAME  $PORT_NUMBER_BASE
# 1. Fetch the 0th block for airline channel
peer channel fetch 0 -c ucabchannel -o $ORDERER_ADDRESS

# Give some time
sleep 5s

#export PEER_LOGGING_LEVEL=debug

# 2. Join the channel
# Only admin is allowed to execute join command

export CORE_PEER_MSPCONFIGPATH=$CRYPTO_CONFIG_ROOT_FOLDER/peerOrganizations/$ORG_NAME.ucab.edu.ve/users/Admin@$ORG_NAME.ucab.edu.ve/msp
peer channel join -b ucabchannel_0.block -o $ORDERER_ADDRESS


