echo " ****** generate-genesis.sh ****** "
source generate-genesis.sh
echo " ****** launch.sh ****** "
sleep 3s
source launch.sh
echo " ****** generate-channel-tx.sh ****** "
sleep 3s
source generate-channel-tx.sh
echo " ****** tail -f log/orderer.log ****** "
sleep 3s
tail -f log/orderer.log