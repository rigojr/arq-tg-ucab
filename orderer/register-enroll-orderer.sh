# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Creates/Enrolls the ucabor's identity + Sets up MSP for ucabor
# Script may executed multiple times 
# PS: Since Register (step 1) can happen only once - ignore register error if you run multiple times

# Function checks for the availability of the 
function    checkCopyYAML {
    SETUP_CONFIG_CLIENT_YAML="../ca/setup/ucabor/ucabor/fabric-ca-client-config.yaml"
    if [ -f "$FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml" ]
    then 
        echo "EMPLEANDO ARCHIVO YAML EN LA CARPETA"
    else
        echo "COPIANDO EL ARCHIVO YAML EN $SETUP_CONFIG_CLIENT_YAML "
        mkdir -p $FABRIC_CA_CLIENT_HOME
        cp  "$SETUP_CONFIG_CLIENT_YAML" "$FABRIC_CA_CLIENT_HOME/fabric-ca-client-config.yaml"
    fi
}

# Function sets the FABRIC_CA_CLIENT_HOME
function    setFabricCaClientHome {
    CA_CLIENT_FOLDER="../ca/client/ucabor"
    export FABRIC_CA_CLIENT_HOME="$CA_CLIENT_FOLDER/$IDENTITY"
}

# Identity of the ucabor will be created by the admin from the ucabor org
IDENTITY="admin"
# A function similar to the setclient.sh script - sets the FABRIC_CA_CLIENT_HOME
setFabricCaClientHome
ADMIN_CLIENT_HOME=$FABRIC_CA_CLIENT_HOME

# Step-1  Register the ucabor identity
echo "FABRIC_CA_CLIENT_HOME=$FABRIC_CA_CLIENT_HOME"
fabric-ca-client register --id.type orderer --id.name ucabor --id.secret pw --id.affiliation ucabor 
echo " ================ COMPLETADO PASO 1: UCABOR REGISTRADO (can be done only once) ================ "

# Step-2 Copy the client config yaml file

# Set the FABRIC_CA_CLIENT_HOME for ucabor
IDENTITY="ucabor"
setFabricCaClientHome

checkCopyYAML
echo " ================ COMPLETADO PASO 2: REVISION DEL ARCHIVO YAML DEL UCABOR ================ "

# Step-3 ucabor identity is enrolled
# Admin will  enroll the ucabor identity. The MSP will be written in the 
# FABRIC_CA_CLIENT_HOME
fabric-ca-client enroll -u http://ucabor:pw@localhost:7054
echo " ================ COMPLETADO PASO 3: ENROLADO UCABOR ================ "

# Step-4 Copy the admincerts to the appropriate folder
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
cp $ADMIN_CLIENT_HOME/msp/signcerts/*    $FABRIC_CA_CLIENT_HOME/msp/admincerts
echo " ================ COMPLETADO PASO 4: MSP CONFIGURADO PARA EL UCABOR ================ "





