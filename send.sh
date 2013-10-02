#!/bin/bash
#Placed in public domain
#
#Compiles data for some set of recipients.
#
# Arguments: 
#   Data directory, possibly comma-separated.
#   Recipient(can be gpg group if --hidden-recipient allows.

if [ "$STORE" == "" ]; then
    STORE=~/.store/
fi

cd $STORE/self
tar -cf "$2.tar" `echo $1 | tr ',' '\n'`

case "$2" in
    *pubshare) #It is for anyone who finds the file.
        gpg2 -z 6 --sign $2.tar
        mv $2.tar.gpg $1.pubshare
        echo pubshare;;
    *) #It is for the group or person
        gpg2 -z 6 -e -r $2 $2.tar
        mv $2.tar.gpg $2.privshare #TODO why doesnt it ask for passphrase? doesnt seem to work
        echo "$2.privshare";;
        #Groups should work? Docs tell of the existance but not if it works in this context.
        # NOTE  some people might want to use `--hidden-recipient`
esac
