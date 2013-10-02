#!/bin/bash
#Placed in public domain
#
#Receives data for some set.
#
# Argument is the file received.

if [ "$STORE" == "" ]; then
    STORE=~/.store/
fi

err()
{  echo Error: $@ > /dev/stderr
}
warn()
{  echo Warning: $@ > /dev/stderr
}

case "$1" in
    *pubshare) #Public, signed sharing.
	gpg2 -d "$1" > "$1.tar"
	HANDLE="$1.tar";;
    *.privshare) #Private, encrypted sharing.
	#(todo) try-all-secrets if hiding recipients.
	gpg2 -d $1 > "$1.tar"
	HANDLE="$1.tar";;
    *) #Dont know what this is.
	err 'invalid file extension, must be .pubshare or .privshare'
	exit -1;;
esac

#TODO figure who it came from, if that is a known signature..
#FROM_NAME= #.... how? read stdout? (it doesn seem specified)

if [ "$FROM_NAME"=="" ]; then
    FROM_NAME='figure_out_name'
fi

if [ -e "$STORE/before_update/$FROM_NAME" -a -e "$STORE/obtained/$FROM_NAME" ]; then
    #Deals with stuff already in there.
    for el in `ls -d "$STORE/obtained/$FROM_NAME/"*`; do
	"$STORE/bin/"`basename $el` $el
    done
fi

#After this point it is up to the programs using the data to deal with it.
# Note that it overwrites existing data. 
mkdir -p "$STORE/obtained/$FROM_NAME/"
tar -xf $HANDLE -C "$STORE/obtained/$FROM_NAME/"
mkdir -p "$STORE/todo/";
touch "$STORE/todo/$FROM_NAME";
