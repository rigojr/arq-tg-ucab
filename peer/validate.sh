# Test case #3 for validating the setup
# Ensures that the chaincode state is reflected across the 
# organizations.
#
# Requires: Orderer, acme peer1 & budget-peer1 to be available
# 1. Installs the CC to acme peer1 & budget-peer1
# 2. Instantiates CC on acme peer1
# 3. Executes query on budget-peer1
# 4. Executes invoke on acme peer1
# 5. Executes query on budget-peer1

CC_CONSTRUCTOR='{"Args":["Init"]}'
CC_NAME="cc-cold"
CC_PATH="braulio"
CC_VERSION="1.1"
CC_CHANNEL_ID="ucabchannel"

# 1. Install CC on acme peer1 & budget-peer1
echo "====> 1   Installing chaincode"
ORG_NAME="ucab"
IDENTITY="admin"
PEER_NAME="peer1"
PEER_BASE_PORT=7050
source  set-env.sh  $ORG_NAME $PEER_NAME $PEER_BASE_PORT $IDENTITY
peer chaincode install  -n $CC_NAME -p $CC_PATH -v $CC_VERSION

# 2. Instantiate the chaincode on acme peer1
echo "====> 2   Instantiating chaincode"
ORG_NAME="ucab"
IDENTITY="admin"
PEER_NAME="peer1"
PEER_BASE_PORT=7050
source  set-env.sh  $ORG_NAME $PEER_NAME $PEER_BASE_PORT $IDENTITY
peer chaincode instantiate -C $CC_CHANNEL_ID -n $CC_NAME  -v $CC_VERSION -c $CC_CONSTRUCTOR

# 3. Executes query on budget peer1
echo "====> 3   Querying"
ORG_NAME="ucab"
IDENTITY="admin"
PEER_NAME="peer1"
PEER_BASE_PORT=7050
source  set-env.sh  $ORG_NAME $PEER_NAME $PEER_BASE_PORT $IDENTITY
peer chaincode query -C $CC_CHANNEL_ID -n $CC_NAME  -c '{"Args":["query","a"]}'

# 4. Executes invoke on acme peer1
echo "====> 4   Invoking"
ORG_NAME="ucab"
IDENTITY="admin"
PEER_NAME="peer1"
PEER_BASE_PORT=7050
source  set-env.sh  $ORG_NAME $PEER_NAME $PEER_BASE_PORT $IDENTITY
peer chaincode invoke -C $CC_CHANNEL_ID -n cc-cold  -c '{"Args":["queryAllArduinos"]}' 