#!/bin/bash

# version 1.00 Septembre 2026
# sh install.sh FICHIER

proc_exit ()
{
case $1 in
  perl) perl -e "$1" ;;
python) python3 -c "$1" ;;
esac 2>/dev/null
[ $? != "0" ] && { echo "  vous devez d'abbord installer : $2" ; exit ; }
}

#########################################################################

 FILE=$1
APPLI=`echo $FILE | cut -f1 -d.`
  EXT=`echo $FILE | cut -f4-5 -d.`
  DIR=$PWD/$APPLI-main  

FILE=$DIR/$FILE
[ "$EXT" != "tar.gz" ] && { echo "le fichier $FILE doit être un tar.gz" ; exit ; }
[ ! -s "$FILE"       ] && { echo "fichier $FILE absent" ; exit ; }

echo "vérification des dépendances"
proc_exit '' python

echo "verification de facila"
if [ "$FACILA" = "" ]
then FACILA=$PWD/facila
     echo "  ajout de FACILA dans .bashrc"
     printf "\n# FACILA\nexport FACILA=$FACILA\n" >> ~/.bashrc
fi

echo "installation de $FILE"
cd $FACILA
tar -pxzf $FILE
