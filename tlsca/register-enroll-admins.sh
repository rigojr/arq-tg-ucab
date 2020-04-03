# Fuente Fabric Network design & setup (https://www.udemy.com/course/hyperledger-fabric-network-design-setup).
# Registro de 4 admins
# ucab-admin, sce-admin, ucabor-admin y ce-admin

# Función para registrar los admins

    export FABRIC_CA_CLIENT_HOME=`pwd`/client/tlscaserver/admin
    export FABRIC_CA_CLIENT_TLS_CERTFILES=`pwd`/server/tls-cert.pem

function registerAdmins {
    # 1. Configura el FABRIC_CA_CLIENT_HOME con el Admin del CA Server
    source setclient.sh   tlscaserver   admin
    echo " ================ INICIANDO REGISTRO DE LOS ADMINISTRADORES ================"

    # 2. Registra ucab-admin
    echo "REGISTRANDO: ucab-admin"
    ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'
    #fabric-ca-client register --id.type client --id.name ucab-admin --id.secret pw --id.attrs $ATTRIBUTES -u https://0.0.0.0:7150
    fabric-ca-client register -d --id.name ucab-admin --id.secret pw --id.type admin -u https://0.0.0.0:7150


    # 3. Registra sce-admin
    echo "REGISTRANDO: sce-admin"
    ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'
    #fabric-ca-client register --id.type client --id.name sce-admin --id.secret pw --id.attrs $ATTRIBUTES -u https://0.0.0.0:7150
    fabric-ca-client register -d --id.name sce-admin --id.secret pw --id.type admin -u https://0.0.0.0:7150

    # 4. Registra ucabor-admin
    echo "REGISTRANDO: ucabor-admin"
    ATTRIBUTES='"hf.Registrar.Roles=orderer"'
    #fabric-ca-client register --id.type client --id.name ucabor-admin --id.secret pw --id.attrs $ATTRIBUTES -u https://0.0.0.0:7150
    fabric-ca-client register -d --id.name ucabor-admin --id.secret pw --id.type admin -u https://0.0.0.0:7150

    # 5. Registra ce-admin
    echo "REGISTRANDO: ce-admin"
    ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'
    #fabric-ca-client register --id.type client --id.name ce-admin --id.secret pw --id.attrs $ATTRIBUTES -u https://0.0.0.0:7150
    fabric-ca-client register -d --id.name ce-admin --id.secret pw --id.type admin -u https://0.0.0.0:7150
}

# Configurando MSP
function setupMSP {
    mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts

    echo "$FABRIC_CA_CLIENT_HOME/msp/admincerts"
    cp $FABRIC_CA_CLIENT_HOME/../../tlscaserver/admin/msp/signcerts/*  $FABRIC_CA_CLIENT_HOME/msp/admincerts
}

# Enrolar admins
function enrollAdmins {
    echo " ================ INICIANDO ENROLAMIENTO DE LOS ADMINISTRADORES ================"

    # 1. ucab-admin
    echo "ENROLANDO: ucab-admin"

    ORG_NAME="ucab"
    source setclient.sh   $ORG_NAME   admin
    fabric-ca-client enroll -u https://ucab-admin:pw@0.0.0.0:7150

    setupMSP

    # 2. sce-admin
    echo "ENROLANDO: sce-admin"

    ORG_NAME="sce"
    source setclient.sh   $ORG_NAME   admin
    fabric-ca-client enroll -u https://sce-admin:pw@0.0.0.0:7150

    setupMSP

    # 3. ucabor-admin
    echo "ENROLANDO: ucabor-admin"

    ORG_NAME="ucabor"
    source setclient.sh   $ORG_NAME   admin
    fabric-ca-client enroll -u https://ucabor-admin:pw@0.0.0.0:7150

    setupMSP

    # 4. ce-admin
    echo "ENROLANDO: ce-admin"

    ORG_NAME="ce"
    source setclient.sh   $ORG_NAME   admin
    fabric-ca-client enroll -u https://ce-admin:pw@0.0.0.0:7150

    setupMSP
}

echo "========= REGISTRANDO ==============="
registerAdmins
echo "========= ENROLANDO ==============="
enrollAdmins