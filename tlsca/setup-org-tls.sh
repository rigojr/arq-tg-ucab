# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Configura la estructura de archivos para el TLSCA

function usage {
    echo    "Usage:    setup-org-msp.sh    <ORG-Name>"
    echo    "          Creates the admincerts folder and copies the admin's cert to admincerts folder"
}

if [ -z $1 ]
then
    echo "SUMINISTRE ORG-Name"
    usage
    exit 0
else 
    ORG_NAME=$1
fi

# Set the destination as ORG folder
source setclient.sh $ORG_NAME  admin

# Path to the CA certificate
ROOT_CA_CERTIFICATE=./server/tls-cert.pem

# Parent folder for the TLS folder
DESTINATION_CLIENT_HOME="$FABRIC_CA_CLIENT_HOME/.."

# Create the TLS subfolders
mkdir -p $DESTINATION_CLIENT_HOME/tls/admincerts
mkdir -p $DESTINATION_CLIENT_HOME/tls/cacerts
mkdir -p $DESTINATION_CLIENT_HOME/tls/keystore


# Copy the TLS CA Cert
cp $ROOT_CA_CERTIFICATE $DESTINATION_CLIENT_HOME/tls/cacerts

# Copy the admin certs - ORG admin is the admin for the specified Org
cp $FABRIC_CA_CLIENT_HOME/msp/signcerts/* $DESTINATION_CLIENT_HOME/tls/admincerts         


echo "CREADO TLS EN: $DESTINATION_CLIENT_HOME"



