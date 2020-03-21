# Generates the orderer | generate the airline channel transaction

# export ORDERER_GENERAL_LOGLEVEL=debug
export FABRIC_LOGGING_SPEC=INFO
export FABRIC_CFG_PATH=$PWD

function usage {
    echo "./generate-channel-tx.sh "
    echo "     Creates the ucab-channel.tx for the channel ucabchannel"
}

echo    '================ Writing airlinechannel ================'

configtxgen -profile UcabChannel -outputCreateChannelTx ./ucab-channel.tx -channelID ucabchannel



echo    '======= Done. Launch by executing orderer ======'
