# Facila Sxabloni

### Module python pour template

    version : 1.00 Septembre 2026
    auteur  : Thierry Le Gall
    contact : facila@gmx.fr
    site    : https://github.com/facila/sxabloni
    
### Installation de facila sxabloni

    vous devez avoir installé au préalable :
    - python 
      apt-get install python3
 
    voir facila/install README.md

### Module sxabloni_templates.py 

    fonction : remplacement des variables des templates par leurs valeurs dans la structure struct

    format des templates :
     - il permet de ne pas avoir à faire de script à l'intérieur des templates , if then else , while , ...
     - le format des templates inclu des conditions
     - les templates sont donc trés facile à élaborer et à lire

      template   (( template )) : si template : exécute un autre template
      list       [[ list ]]     : si list     : exécute pour toute la liste
      dictionary {{ dict }}     : si dict     : exécute pour tout le dictionnaire

      text est optionnel
      -> replacer par

      variable   << var >>                  : si value -> "value"           , sinon : ne pas afficher la ligne
      option     <o var o>                  : si value -> "value"           , sinon -> ""
      option     <O text <o var o> text O>  : si value -> "text value text" , sinon -> ""

      boolean    <b var b>                  : si true  -> "var"                                         , sinon -> ""
      boolean    <B0 text <b var b> text B> : si true  -> "text var text"                               , sinon -> ""
      boolean    <B1 text <b var b> text B> : si true  -> "text var text" , si false -> "var"           , sinon : ne pas afficher la ligne
      boolean    <B2 text <b var b> text B> : si true  -> "var"           , si false -> "text var text" , sinon : ne pas afficher la ligne
      boolean    <B3 text <b var b> B>      : si true  -> "text"          , si false -> ""              , sinon : ne pas afficher la ligne
      boolean    <B4 text <b var b> B>      : si true  -> ""              , si false -> "text"          , sinon : ne pas afficher la ligne

### Script sxabloni.py utilisant le module sxabloni_templates.py

    exécution du template :
      format yaml : sxabloni.py model template [value] -y yaml
      format dsl  : sxabloni.py model template [value] -d dsl

      format yaml : à partir d'un fichier yaml
      format dsl  : à partir d'un fichier dsl de fonctions et paramètres et du module model associé

    sxabloni est fourni avec un modèle cisco , que vous pouvez compléter

    vous pouvez ajouter d'autres modéles
      exécuter : model.sh
      mettre à jour les fichiers du modéle : model et module
