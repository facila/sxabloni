#!/bin/bash

# version 3.00 septembre 2026
# sh install.sh FICHIER

proc_check ()
{
ERROR=$1
shift
"$@" 2>/dev/null || { echo "  vous devez d'abord installer : $ERROR" ; exit ; }
}

proc_facila ()
{
OK_FACILA=1
if [ "$FACILA" = "" ]
then OK_FACILA=0
     FACILA=$PWD/facila
     echo "  ajout de FACILA dans .bashrc"
     printf "\n# FACILA\nexport FACILA=$FACILA\n" >> ~/.bashrc
fi

SAVE=$FACILA/save
if [ ! -d $SAVE ]
then echo "  création des répertoires de facila"
     mkdir -p $SAVE
     cd $SAVE 
     mkdir archive data delete install old version
fi
}

proc_save_old ()
{
OLD=$DIR/install_$APPLI
[ ! -f $OLD ] && return

OK_OLD=0
for F in $(cat $OLD)
do if [ -d $F -o -f $F ]
   then OK_OLD=1
        mkdir -p $SAVE/old/$F # création des répertoires contenus dans $F
        rmdir    $SAVE/old/$F # suppression du dernier repertoire de $F
        mv $F    $SAVE/old/$F.`date +%y%m%d_%H%M` 2> /dev/null
   fi
done
[ $OK_OLD = 1 ] && echo "  sauvegarde de l'ancienne version dans $SAVE/old"
}

proc_init_data ()
{
INIT=kreo/data_init/$APPLI
[ ! -d $INIT ] && return

# copie du dossier d'installation data_init dans data pour l'utilisateur
DATA=$APPLI/data/$USER
[ ! -d $DATA ] && mkdir $DATA
cp -r $INIT/* $DATA
}

proc_init_lang ()
{
[ "$LG" = "$LANG"     ] && return
[ -d "$APPLI/var/$LG" ] && return

echo "copie du répertoire d'origine $LG dans la langue de la machine $LANG"
cp -R $APPLI/var/$LG $APPLI/var/$LANG
echo "  votre langue est $LANG"
echo "  vous pouvez traduire les fichiers ( menu , aide , ... )"
}

proc_save_new ()
{
cd ..
mv $APPLI-main.zip $SAVE/install
mv $FILE           $SAVE/version
rm -rf $APPLI-main
}

proc_command ()
{
COM=$FACILA/$APPLI/prg/$APPLI
[ ! -s "$COM" ] && return

echo "  application : $APPLI"
echo "  commande    : $COM"
[ $OK_FACILA = 0 ] && echo "  fermer et relancer le shell pour exécuter $APPLI"
}

#################################################################################

 FILE=$1
APPLI=`echo $FILE | cut -f1 -d.`
  EXT=`echo $FILE | cut -f4-5 -d.`
  DIR=$PWD/$APPLI-main  
   LG=fr_FR.UTF-8

FILE=$DIR/$FILE
[ ! -s "$FILE"       ] && { echo "fichier $FILE absent" ; exit ; }
[ "$EXT" != "tar.gz" ] && { echo "le fichier $FILE doit être un tar.gz" ; exit ; }

echo "vérification des dépendances"
. $DIR/install_check.sh

echo "verification de facila"
proc_facila
cd $FACILA

echo "installation de $FILE"
proc_save_old
tar -pxzf $FILE
proc_init_data
proc_init_lang
proc_save_new
proc_command
