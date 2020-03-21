# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Generates the orderer | generate the ucab channel transaction

export FABRIC_LOGGING_SPEC=INFO
export FABRIC_CFG_PATH=$PWD

function usage {
    echo "./generate-channel-tx.sh "
    echo "     Creates the ucab-channel.tx for the channel ucabchannel"
}

echo    ' ================ ESCRIBIENDO EL UCABCHANNEL ================ '

configtxgen -profile UcabChannel -outputCreateChannelTx ./ucab-channel.tx -channelID ucabchannel

echo    ' ================ LISTO ================ '