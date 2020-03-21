# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Joins the peer to a channel
# ORG_NAME="${PWD##*/}"

UCAB_CHANNEL_BLOCK=./ucabchannel.block

function usage {
    echo "Usage:     ./join-ucab-channel.sh  ORG_NAME  PEER_NAME  [PORT_NUMBER_BASE default=7050] [ORDERER_ADDRESS default=localhost:7050]"
    echo "           Specified Peer MUST be up for the command to be successful"
}

if [ -z $1 ]
then
    usage
    echo ' SUMINISTRE ORG_NAME & PEER_NAME '
    exit 1
else 
    ORG_NAME=$1
fi

if [ -z $2 ]
then
    usage
    echo 'SUMINISTRE PEER_NAME'
    exit 1
else 
    PEER_NAME=$2
fi


if [ -z $3 ]
then
    PORT_NUMBER_BASE=7050
    echo " ================ USANDO PUERTO BASE :7050 ================ "
else 
    PORT_NUMBER_BASE=$3
fi

if [ -z $4 ]
then
    ORDERER_ADDRESS="localhost:7050"
    echo " ================ EMPLEANDO ORDENADOR POR DEFECTO localhost:7050 ================"
else 
    ORDERER_ADDRESS=$4
fi

# Set the environment vars
source set-env.sh $ORG_NAME  $PEER_NAME  $PORT_NUMBER_BASE

./show-env.sh

# Only admin is allowed to execute join command
export CORE_PEER_MSPCONFIGPATH=$CRYPTO_CONFIG_ROOT_FOLDER/$ORG_NAME/admin/msp

# Fetch ucab channel configuration
peer channel fetch 0 $UCAB_CHANNEL_BLOCK -o $ORDERER_ADDRESS -c ucabchannel

# Join the channel
peer channel join -o $ORDERER_ADDRESS -b $UCAB_CHANNEL_BLOCK

# Execute the anchor peer update
