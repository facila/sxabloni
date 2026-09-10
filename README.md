# sxabloni
```
module sxabloni_templates.py version 1.00 Septembre 2026 par Thierry Le Gall

fonction : remplacement des variables des templates par leurs valeurs dans la structure data

format des templates :
 - il permet de ne pas avoir à faire de script à l'intérieur des templates , si then sinon , while , ...
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

exemple template interfaces :
!
interface << interfaces >>
 description << description >>
 <B2 no <b shutdown b> B>
 <B2 no <b switchport b> B>
 switchport mode << mode >>
 switchport trunk allowed vlan [[ trunk_vlans ]]
 switchport access vlan << access_vlan >>
 ip address {{ addresses }} << ip >> << mask >> <b secondary b>
 (( standbys ))
 ip helper [[ helpers ]]
 ip access-group << access_group_in >> in
 ip access-group << access_group_out >> out
 ip service-policy << service_policy_in >> in
 ip service-policy << service_policy_out >> out
 speed << speed >>
 duplex << duplex >>

fichier yaml :

interfaces:
  Vlan10:
    description: Users Gateway
    addresses:
      - ip: 192.168.10.2
        mask: 255.255.255.0
      - ip: 192.168.11.2
        mask: 255.255.255.0
        secondary: true
    helpers:
      - 192.168.100.10
      - 192.168.100.11
    standbys:
      1:
        virtual_ip: 192.168.10.1
        priority: 110
        preempt: true
      2:
        virtual_ip: 192.168.11.1
        priority: 90
        preempt: false

structure data :

{'interfaces': {'Vlan10': {'addresses': [{'ip': '192.168.10.2',
                                          'mask': '255.255.255.0'},
                                         {'ip': '192.168.11.2',
                                          'mask': '255.255.255.0',
                                          'secondary': True}],
                           'description': 'Users Gateway',
                           'helpers': ['192.168.100.10', '192.168.100.11'],
                           'standbys': {1: {'preempt': True,
                                            'priority': 110,
                                            'virtual_ip': '192.168.10.1'},
                                        2: {'preempt': False,
                                            'priority': 90,
                                            'virtual_ip': '192.168.11.1'}}}}}

résultat :
!
interface Vlan10
 description Users Gateway
 ip address 192.168.10.2 255.255.255.0
 ip address 192.168.11.2 255.255.255.0 secondary
 ip standby 1 ip 192.168.10.1
 ip standby 1 priority 110
 ip standby 1 preempt
 ip standby 2 ip 192.168.11.1
 ip standby 2 priority 90
 no ip standby 2 preempt
 ip helper 192.168.100.10
 ip helper 192.168.100.11
```
