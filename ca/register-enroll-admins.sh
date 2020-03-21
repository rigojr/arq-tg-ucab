# Registers the 3 admins
# acme-admin, budget-admin, orderer-admin

# Registers the admins
function registerAdmins {
    # 1. Set the CA Server Admin as FABRIC_CA_CLIENT_HOME
    source setclient.sh   caserver   admin

    # 2. Register ucab-admin
    echo "REGISTRANDO: ucab-admin"
    ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'
    fabric-ca-client register --id.type client --id.name ucab-admin --id.secret pw --id.affiliation ucab --id.attrs $ATTRIBUTES

    # 3. Register sce-admin
    echo "REGISTRANDO: sce-admin"
    ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'
    fabric-ca-client register --id.type client --id.name sce-admin --id.secret pw --id.affiliation sce --id.attrs $ATTRIBUTES

    # 4. Register ucabor-admin
    echo "REGISTRANDO: ucabor-admin"
    ATTRIBUTES='"hf.Registrar.Roles=orderer"'
    fabric-ca-client register --id.type client --id.name ucabor-admin --id.secret pw --id.affiliation ucabor --id.attrs $ATTRIBUTES

    # 5. Register ce-admin
    echo "REGISTRANDO: ce-admin"
    ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true"'
    fabric-ca-client register --id.type client --id.name ce-admin --id.secret pw --id.affiliation ce --id.attrs $ATTRIBUTES
}

# Setup MSP
function setupMSP {
    mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts

    echo "====> $FABRIC_CA_CLIENT_HOME/msp/admincerts"
    cp $FABRIC_CA_CLIENT_HOME/../../caserver/admin/msp/signcerts/*  $FABRIC_CA_CLIENT_HOME/msp/admincerts
}

# Enroll admin
function enrollAdmins {
    # 1. ucab-admin
    echo "ENROLANDO: ucab-admin"

    ORG_NAME="ucab"
    source setclient.sh   $ORG_NAME   admin
    fabric-ca-client enroll -u http://ucab-admin:pw@localhost:7054

    setupMSP

    # 2. sce-admin
    echo "ENROLANDO: sce-admin"

    ORG_NAME="sce"
    source setclient.sh   $ORG_NAME   admin
    fabric-ca-client enroll -u http://sce-admin:pw@localhost:7054

    setupMSP

    # 3. ucabor-admin
    echo "ENROLANDO: ucabor-admin"

    ORG_NAME="ucabor"
    source setclient.sh   $ORG_NAME   admin
    fabric-ca-client enroll -u http://ucabor-admin:pw@localhost:7054

    setupMSP

    # 4. ce-admin
    echo "ENROLANDO: ce-admin"

    ORG_NAME="ce"
    source setclient.sh   $ORG_NAME   admin
    fabric-ca-client enroll -u http://ce-admin:pw@localhost:7054

    setupMSP
}

echo "========= Registering ==============="
registerAdmins
echo "========= Enrolling ==============="
enrollAdmins
echo "==================================="