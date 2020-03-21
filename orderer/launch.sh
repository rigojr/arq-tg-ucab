# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Use this script for overriding ORDERER Parameters
export FABRIC_CFG_PATH=$PWD

export ORDERER_FILELEDGER_LOCATION="/home/vagrant/ledgers/ucabor/ledger" 

mkdir -p log

LOG_FILE=./log/orderer.log

sudo -E orderer 2> $LOG_FILE &

echo " ================ LISTO, REVISE LOS LOGS EN $LOG_FILE ================"