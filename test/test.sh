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

#mv `gpgshare selfdir`/to_send/todo_alias/*.privshare \
#`gpgshare selfdir`/to_send/todo_alias/*.privshare

#TODO Mr. B receiving both (check it is the same.
