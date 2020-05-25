sudo killall orderer
# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Simply deletes the files generated for orderer

rm *.tx 2> /dev/null
rm *.block 2> /dev/null

sudo rm -rf /home/vagrant/ledgers/ucabor/ledger  2> /dev/null

rm -rf log  2> /dev/null
rm -rf temp  2> /dev/null

sudo rm -rf /var/ledgers/ucabor/ledger 2> /dev/null

rm -rf ./log

export ZK_HOSTS="localhost:2181"

$HOME/kafka/bin/kafka-topics.sh --zookeeper $ZK_HOSTS --delete --topic ordererchannel
$HOME/kafka/bin/kafka-topics.sh --zookeeper $ZK_HOSTS --delete --topic ucabchannel

echo " ================ LISTO ================ "