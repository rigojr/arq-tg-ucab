echo " ****** server.sh init ****** "
source server.sh init

echo " ****** server.sh start ****** "
source server.sh start

echo " ****** server.sh enroll ****** "
sleep 1s
source server.sh enroll

echo " ****** register-enroll-admins.sh ****** "
sleep 1s
source register-enroll-admins.sh

echo "CREANDO LA ESTRUCTURA TLS DENTRO DE LAS ORGANIZACIONES"
source setup-org-tls.sh ce admin
source setup-org-tls.sh sce  admin
source setup-org-tls.sh ucab  admin
source setup-org-tls.sh ucabor  admin

echo " ****** register-enroll-orderer.sh ****** "
sleep 1s
source register-enroll-orderer.sh

echo " ****** rregister-enroll-peer.sh  ****** "
sleep 1s
source register-enroll-peer.sh ucab peer1
#sleep 1s
#source register-enroll-peer.sh ce peer3
#sleep 1s
#source register-enroll-peer.sh sce peer2



#echo " ****** configurando estructura de carpetas ****** "
#source setup-org-all.sh ce admin
#source setup-org-all.sh sce  admin
#source setup-org-all.sh ucab  admin
#source setup-org-all.sh ucabor  admin