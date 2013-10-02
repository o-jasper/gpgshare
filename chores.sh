#!/bin/bash
#Placed in public domain
#
# Does some chores if turned on for user and exists.

if [ "$STORE" == "" ]; then
    STORE=~/.store/
fi

do_chore()
{  #Do the chores of the user $1
    if [ -e "$STORE/do_chores/$1" -a -e "$STORE/obtained/$1" ]; then
        #Deals with stuff already in there.
        for el in `ls -d "$STORE/obtained/$1/"*`; do
          #Hmm, only allow symlinks to userspace-nonwritable?
            if [ -e "$STORE/bin/"`basename $el` ]; then 
	        "$STORE/bin/"`basename $el` $el
            fi
        done
    fi
}

if [ "$1" == "all" ]; then
    for el in `ls $STORE/obtained`; do
        do_chore `basename $el`
    done
else
    do_chore $1
fi
