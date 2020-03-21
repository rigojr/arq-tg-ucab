sudo killall orderer

# Simply deletes the files generated for orderer

rm *.tx 2> /dev/null
rm *.block 2> /dev/null

sudo rm -rf /home/vagrant/ledgers/ucabor/ledger  2> /dev/null

rm -rf log  2> /dev/null
rm -rf temp  2> /dev/null

sudo rm -rf /var/ledgers/ucabor/ledger 2> /dev/null

rm -rf ./log


echo "Done."
echo "To delete 'orderer' identity also use:  ca/multi-org-ca/remove-identity.sh orderer orderer"