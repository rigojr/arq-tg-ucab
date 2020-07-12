PASO A PASO PARA DESPLEGAR LA ARQUITECTURA
============
Las dependencias tienen que ser instaladas previo a la ejecución de cualquier comando descrito en el presente documento.

1- GENERAR LOS MATERIALES CRIPTOGRAFICOS
========================================
## Paso a paso para lanzar la CA (DESDE /ca/).

- INICIALIZO EL SERVIDOR CA
    * ./server.sh start 
- ENROLO EL ADMINISTRADOR DE LA CA
    * ./server.sh enroll
- ENROLO LOS ADMINISTRADORES DE LAS ORGANIZACIONES
    * ./register-enroll-admins.sh 
- CREO LA ESTRUCTURA MSP Y COPIO LOS MATERIALES CRIPTOGRAFICOS
    * ./setup-org-msp-all.sh

- EJECUTE TODOS LOS COMANDOS ANTERIORES CON
    * ./all.sh

## Otros comandos útiles

- LEO LA COLA DEL SERVER.LOG
    * tail -f server/server.log
- DETENGO EL SERVIDOR
    * ./server.sh stop
- LIMPIO TODO MI DIRECTORIO
    * ./clean.sh

2- LANZAR EL ORDENADOR
========================================
## Paso a paso para lanzar el ORDENADOR (DESDE /orderer/).

- GENERAR EL BLOQUE GENESIS
    * ./generate-genesis.sh
- REGISTRAR Y ENROLAR LA IDENTIDAD DEL ORDENADOR COMO TAL
    * ./register-enroll-orderer.sh 
- LANZAR EL ORDENADOR
    * ./launch.sh 
- GENERAR EL CHANNEL TX
    * ./generate-channel-tx.sh
- EJECUTE TODOS LOS COMANDOS ANTERIORES CON
    * ./all.sh

## Otros comandos útiles
- LIMPIO TODO MI DIRECTORIO
    * ./clean.sh
- LEO LA COLA DEL ORDERER.LOG
    * tail -f log/orderer.log

2- LANZAR EL PEER
========================================
## Paso a paso para lanzar los PEER (DESDE /peer/).

- FIRMAR EL CHANNEL.TX PARA LANZARLO
    * ./sign-channel-tx.sh ucab
    * ./sign-channel-tx.sh ce
    * ./sign-channel-tx.sh sce
- ENVIAR EL CHANNEL.TX AL ORDENADOR PARA SU LANZAMIENTO
    * ./submit-create-channel.sh ucab admin

### Paso a paso para lanzar el Anchor PEER de ucab (DESDE /peer/).

- REGISTRO Y ENROLO LA IDENTIDAD
    * ./register-enroll-peer.sh ucab peer1
- LANZO EL PEER CONFIGURANDO LAS VARIABLES DE ENTORNO Y CON EL PUERTO 7050 POR DEFECTO
    * ./launch-peer.sh ucab peer1
- CONFIGURO LAS VARIABLES DE ENTORNO PARA SU POSTERIOR INGRESO AL CANAL
    * . set-env.sh ucab admin
- ENTRO AL CANAL UCABCHANNEL
    * ./join-ucab-channel.sh ucab peer1
- LEER EL OUTPUT DEL BINARIO DEL PEER
    * tail -f ucab/peer1/peer.log

### Paso a paso para lanzar el Anchor PEER de ce (DESDE /peer/).
- REGISTRO Y ENROLO LA IDENTIDAD
    * ./register-enroll-peer.sh ce peer3
- LANZO EL PEER CONFIGURANDO LAS VARIABLES DE ENTORNO Y CON EL PUERTO 9050
    * ./launch-peer.sh ce peer3 9050
- INGRESAR AL CANAL
    * ./join-regular-peer-to-ucabchannel.sh ce peer3 9050
- CONFIGURAR VARIALBES DE AMBIENTE PARA EL PEER 3
    * . set-env.sh ce peer3 9050
- LEER EL OUTPUT DEL BINARIO DEL PEER
    * tail -f ce/peer3/peer.log

### Paso a paso para lanzar el Anchor PEER de sce (DESDE /peer/).
- REGISTRO Y ENROLO LA IDENTIDAD
    * ./register-enroll-peer.sh sce peer2
- LANZO EL PEER CONFIGURANDO LAS VARIABLES DE ENTORNO Y CON EL PUERTO 9050
    * ./launch-peer.sh sce peer2 8050
- INGRESAR AL CANAL
    * ./join-regular-peer-to-ucabchannel.sh sce peer2 8050
- CONFIGURAR VARIALBES DE AMBIENTE PARA EL PEER 2
    * . set-env.sh sce peer2 8050
- LEER EL OUTPUT DEL BINARIO DEL PEER
    * tail -f sce/peer2/peer.log

# COMANDOS DEL PEER

- Lista de canales en donde esta el peer
    * peer channel list
- Lista de peers activos
    * ps -eal | grep peer

# Otros comandos 

## DOCKER

- MATO UN CONTENEDOR POR ID
    * docker container rm ID

## WIRESHARK

- MUESTRA TODO LOS PAQUETES DE LOCALHOST Y EL PORTE 7051
    * sudo tshark -i any -w nlog.pcap -V host 127.0.0.1 and port 7051

## CONECTAR CON AWS

- COMANDOS
    * ssh -i vote-ledger-ssh.pem ubuntu@ec2-18-209-179-50.compute-1.amazonaws.com
    * scp -i vote-ledger-ssh.pem/path/SampleFile.txt ubuntu@ec2-18-209-179-50.compute-1.amazonaws.com:~