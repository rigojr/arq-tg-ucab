# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
#!/bin/bash

# Sets the env & identity to specified   Org   User

# Extract name of the ORG from the folder name
#ORG_NAME="${PWD##*/}"
#ORG_PWD=`pwd`

function usage {
    echo ". set-env.sh   ORG_NAME   PEER_NAME  [PORT_NUMBER_BASE default=7050]  [Identity]"
    echo "               Sets the environment variables for the peer that need to be administered"
    echo "               If [Identity] is specified then the MSP is set to the specified Identity instead of PEER MSP"
}

# Change this to appropriate level
#export CORE_LOGGING_LEVEL=info  #debug  #info #warning
export FABRIC_LOGGING_SPEC=INFO

echo "Current PEER_NAME: $CORE_PEER_ID"

if [ -z $1 ];
then
    usage
    echo " SUMINISTRE ORG Name "
    exit 0
else
    ORG_NAME=$1
    echo " CAMBIANDO PEER_NAME POR Org = $ORG_NAME"
fi

if [ -z $2 ];
then
    usage
    echo  " SUMINISTRE PEER_NAME / NOMBRE DEL PEER"
    exit 0
else
    PEER_NAME=$2
fi

PORT_NUMBER_BASE=7050
if [ -z $3 ]
then
    echo " CONFIGURANDO PORT_NUMBER_BASE=7050 "   
else
    PORT_NUMBER_BASE=$3
fi

export CORE_PEER_ID=$PEER_NAME

if [ -z $4 ]
then
    # do nothing
    echo "Identity=$PEER_NAME"
    IDENTITY=$PEER_NAME
else
    IDENTITY=$4
    
fi

# Create the path to the crypto config folder
CRYPTO_CONFIG_ROOT_FOLDER="$PWD/../crypto/crypto-config/"
export CORE_PEER_MSPCONFIGPATH=$CRYPTO_CONFIG_ROOT_FOLDER/peerOrganizations/$ORG_NAME.ucab.edu.ve/users/Admin@$ORG_NAME.ucab.edu.ve/msp
export FABRIC_CFG_PATH="$PWD/$ORG_NAME"

#export CORE_PEER_MSPCONFIGPATH=$CRYPTO_CONFIG_ROOT_FOLDER/$ORG_NAME/$PEER_NAME/msp
# Capitalize the first letter of Org name e.g., acme => Acme  budget => Budget
MSP_ID="$(tr '[:lower:]' '[:upper:]' <<< ${ORG_NAME:0:1})${ORG_NAME:1}"
export CORE_PEER_LOCALMSPID=$MSP_ID"MSP"

export GOPATH="$PWD/../../gopath"

export NODECHAINCODE="$PWD/../../nodechaincode"

#export CORE_PEER_MSPCONFIGPATH=$CRYPTO_CONFIG_ROOT_FOLDER/$ORG_NAME/$PEER_NAME/msp
#export CORE_PEER_FILESYSTEMPATH=~/vagrant/ledgers/peer/multi-org/$ORG_NAME/$PEER_NAME/ledger
export CORE_PEER_FILESYSTEM_PATH="/var/ledgers/ucab/$ORG_NAME/$PEER_NAME/ledger" 

# This is to avoid Port Number contention
VAR=$((PORT_NUMBER_BASE+1))
export CORE_PEER_LISTENADDRESS=localhost:$VAR
export CORE_PEER_ADDRESS=localhost:$VAR
export CORE_PEER_GOSSIP_BOOTSTRAP=localhost:$VAR
VAR=$((PORT_NUMBER_BASE+2))
export CORE_PEER_CHAINCODELISTENADDRESS=localhost:$VAR
VAR=$((PORT_NUMBER_BASE+3))
export CORE_PEER_EVENTS_ADDRESS=localhost:$VAR



export PEER_LOGS=$PWD/$ORG_NAME/$PEER_NAME



#echo "====>Peer binary will use CORE_PEER_MSPCONFIGPATH=$CORE_PEER_MSPCONFIGPATH"

# Simply checks if this script was executed directly on the terminal/shell
# it has the '.'
if [[ $0 = *"set-env.sh" ]]
then
    echo "Did you use the . before ./set-env.sh? If yes then we are good :)"
fi