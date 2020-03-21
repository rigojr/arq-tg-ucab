# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Generates the orderer | generate genesis block for ucabchannel
# export ORDERER_GENERAL_LOGLEVEL=debug
export FABRIC_LOGGING_SPEC=INFO
export FABRIC_CFG_PATH=$PWD

# Create the Genesis Block
echo    ' ================ ESCRIBIENDO BLOQUE GENESIS ================ '
configtxgen -profile UcabOrdererGenesis -outputBlock ./ucab-genesis.block -channelID ordererchannel
