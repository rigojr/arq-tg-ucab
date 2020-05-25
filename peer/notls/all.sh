export COUCHDB_ID_UCAB=$(docker run  -e COUCHDB_USER=user -e COUCHDB_PASSWORD=password --name=couchdbUCAB -p 5984:5984 -d couchdb:2.2.0)
sleep 1s
export COUCHDB_ID_CE=$(docker run  -e COUCHDB_USER=user -e COUCHDB_PASSWORD=password --name=couchdbCE -p 15984:5984 -d couchdb:2.2.0)
sleep 1s
export COUCHDB_ID_SCE=$(docker run  -e COUCHDB_USER=user -e COUCHDB_PASSWORD=password --name=couchdbSCE -p 25984:5984 -d couchdb:2.2.0)
sleep 1s

echo " ****** sign-channel-tx.sh ucab ****** "
source sign-channel-tx.sh ucab
echo " ****** sign-channel-tx.sh ce  ****** "
sleep 1s
source sign-channel-tx.sh ce
echo " ****** sign-channel-tx.sh sce ****** "
sleep 1s
source sign-channel-tx.sh sce
echo " ****** submit-create-channel.sh ucab admin ****** "
sleep 1s
source submit-create-channel.sh ucab admin


echo " ****** register-enroll-peer.sh ucab peer1 ****** "
sleep 1s
source register-enroll-peer.sh ucab peer1
echo " ****** launch-peer.sh ucab peer1 ****** "
sleep 1s
source launch-peer.sh ucab peer1
echo " ****** . set-env.sh ucab admin ****** "
sleep 5s
. set-env.sh ucab admin
echo " ****** join-ucab-channel.sh ucab peer1 ****** "
sleep 1s
source join-ucab-channel.sh ucab peer1

echo " ****** register-enroll-peer.sh ce peer3 ****** "
sleep 7s
source register-enroll-peer.sh ce peer3
echo " ****** launch-peer.sh ce peer3 9050 ****** "
sleep 7s
source launch-peer.sh ce peer3 9050
echo " ****** join-regular-peer-to-ucabchannel.sh ce peer3 9050 ****** "
sleep 7s
source join-regular-peer-to-ucabchannel.sh ce peer3 9050

echo " ****** register-enroll-peer.sh sce peer2 ****** "
sleep 10s
source register-enroll-peer.sh sce peer2
echo " ****** launch-peer.sh sce peer2 8050 ****** "
sleep 5s
source launch-peer.sh sce peer2 8050
echo " ****** join-regular-peer-to-ucabchannel.sh sce peer2 8050 ****** "
sleep 5s
source join-regular-peer-to-ucabchannel.sh sce peer2 8050