#!/bin/bash

# version 2.00 Septembre 2026
# sh install.sh FILE

check ()
{
local error="$1"
shift
"$@" 2>/dev/null || { echo "  vous devez d'abord installer : $error" ; exit ; }
}

###############################################################################

 FILE=$1
APPLI=`echo $FILE | cut -f1 -d.`
  EXT=`echo $FILE | cut -f4-5 -d.`
  DIR=$PWD/$APPLI-main  

FILE=$DIR/$FILE
[ "$EXT" != "tar.gz" ] && { echo "le fichier $FILE doit être un tar.gz" ; exit ; }
[ ! -s "$FILE"       ] && { echo "fichier $FILE absent" ; exit ; }

echo "vérification des dépendances"
. check.sh

echo "verification de facila"
if [ "$FACILA" = "" ]
then FACILA=$PWD/facila
     echo "  ajout de FACILA dans .bashrc"
     printf "\n# FACILA\nexport FACILA=$FACILA\n" >> ~/.bashrc
fi

echo "installation de $FILE"
cd $FACILA
tar -pxzf $FILE
