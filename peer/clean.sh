# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
sudo killall peer 2> /dev/null

# Remove all generated files
rm *.block 2> /dev/null
rm *.json 2> /dev/null
rm *.pb 2> /dev/null

# Remove the subfolders
function cleanOrgFolders {
    rm -rf $ORG_NAME/peer* 2> /dev/null
    rm $ORG_NAME/*.tx 2> /dev/null
    rm $ORG_NAME/*.block 2> /dev/null

    CORE_PEER_FILESYSTEM_PATH="/var/ledgers/$ORG_NAME"
    sudo rm -rf $CORE_PEER_FILESYSTEM_PATH
}

# Clean up the ucab folder
ORG_NAME=ucab
cleanOrgFolders


# Clean up the ce folder
ORG_NAME=ce
cleanOrgFolders

# Clean up the  sce folder
ORG_NAME=sce
cleanOrgFolders

# Clean up the config folder
rm  config/* 2> /dev/null

rm *.block 2> /dev/null
rm *.tx 2> /dev/null

docker container kill $(docker ps -q)

docker container rm $COUCHDB_ID_UCAB
docker container rm $COUCHDB_ID_CE
docker container rm $COUCHDB_ID_SCE

echo " ================ LISTO ================ "