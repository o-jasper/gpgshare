#!/bin/bash
# Author Jasper den Ouden
#Placed in public domain  5-10-2013

export GPGSHARE_TESTING=true

gpgshare()
{
    sh ../gpgshare $@
}

export STORE=Mr.A/store
export GNUPGHOME=Mr.A/dotgnupg

#TODO A,B know each other.

#Composing public messages(well, at least, not encrypted by gnupg)
DIR=`gpgshare selfdir`/messages
mkdir -p $DIR
echo 'Mr.A says hello to the world' > $DIR/hello_world
gpgshare send messages/hello_world hello_world.pubshare

#TODO compose for mr B
echo 'Mr.A says hello to Mr.B' > $DIR/hello_mr_b


#TODO Mr. B receiving both (check it is the same.



