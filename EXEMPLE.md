# facila sxabloni : module python pour template

template interfaces :
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
