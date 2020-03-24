echo " ****** server.sh start ****** "
source server.sh start
echo " ****** server.sh enroll ****** "
sleep 2s
source server.sh enroll
echo " ****** register-enroll-admins.sh ****** "
sleep 2s
source register-enroll-admins.sh
echo " ****** setup-org-msp-all.sh ****** "
sleep 2s
source setup-org-msp-all.sh
echo " ****** tail -f server/server.log ****** "
sleep 2s
tail -f server/server.log