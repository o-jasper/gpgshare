#!/bin/bash
# Author Jasper den Ouden
#Placed in public domain  5-10-2013

export GPGSHARE_TESTING=true

gpgshare()
{
    sh ../gpgshare $@
}

export STORE=`pwd`/Mr.A/store
export GNUPGHOME=`pwd`/Mr.A/dotgnupg/

#TODO A,B know each other. See Makefile.

#Composing public messages(well, at least, not encrypted by gnupg)
DIR=`gpgshare selfdir`/messages
mkdir -p $DIR
echo 'Mr.A says hello to the world' > $DIR/hello_world
gpgshare send messages/hello_world hello_world.pubshare

#Compose for mr B 
echo 'Mr.A says hello to Mr.B' > $DIR/hello_mr_b
gpgshare send messages/hello_mr_b CE7D38D3 #thats mr.B

#Move into Bs directory
mkdir -p Mr.B/store/raw_received/
mv `gpgshare selfdir`/*.privshare \
   `gpgshare selfdir`/*.pubshare Mr.B/store/raw_received/

#Change identity
export STORE=`pwd`/Mr.B/store
export GNUPGHOME=`pwd`/Mr.B/dotgnupg/

gpgshare receive Mr.B/store/raw_received/*.pubshare
gpgshare receive Mr.B/store/raw_received/*.privshare

#TODO Mr. B receiving both (check it is the same.
