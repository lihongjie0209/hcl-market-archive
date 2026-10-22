分布式EVPN网关配置举例（IPv4网络）

![说明](./Media//image1.png)


本节仅以IPv4站点接入IPv4网络为例，IPv6站点接入IPv4网络的配置与此类似。

>  

1\. 组网需求

> Switch A、Switch B为分布式EVPN网关设备；Switch
> C为RR，负责在交换机之间反射BGP路由。
>
> 虚拟机VM 1和VM 3属于VXLAN 10；VM 2和VM 4属于VXLAN
> 20。相同VXLAN之间可以二层互通；不同VXLAN之间通过分布式EVPN网关实现三层互通，并采用对称IRB方式转发流量；VXLAN与广域网之间通过边界网关实现三层互通。

2\. 组网图

> 图1 分布式EVPN网关连接IPv4网络配置组网图
>
> ![](./Media//image2.png)
> 
>
> ‌

3\. 配置步骤

> (1)     配置设备工作的硬件资源模式。
>
> \# 配置Switch A、Switch B工作的硬件资源模式，并重启设备。以Switch
> A为例，其他设备的配置方法与此相同。
>
> \[SwitchA\] hardware-resource vxlan l3gw
>
> Do you want to change the specified hardware resource working mode?
> \[Y/N\]:y
>
> The hardware resource working mode is changed, please save the
> configuration and
>
> reboot the system to make it effective.
>
> \[SwitchA\] quit
>
> \<SwitchA\> reboot
>
> Start to check configuration with next startup configuration file,
> please wait..
>
> \...\....DONE!
>
> Current configuration may be lost after the reboot, save current
> configuration?
>
> \[Y/N\]:y
>
> This command will reboot the device. Continue? \[Y/N\]:y
>
> (2)     配置IP地址和单播路由协议
>
> \# 在VM 1和VM 3上指定网关地址为10.1.1.1；在VM 2和VM
> 4上指定网关地址为10.1.2.1。（具体配置过程略）
>
> \#
> 配置各接口的IP地址和子网掩码；在IP核心网络内配置OSPF协议，确保交换机之间路由可达。（具体配置过程略）
>
> (3)     配置Switch A
>
> \# 开启L2VPN能力。
>
> \<SwitchA\> system-view
>
> \[SwitchA\] l2vpn enable
>
> \# 关闭远端MAC地址和远端ARP自动学习功能。
>
> \[SwitchA\] vxlan tunnel mac-learning disable
>
> \[SwitchA\] vxlan tunnel arp-learning disable
>
> \# 在VSI实例vpna下创建EVPN实例，并配置自动生成EVPN实例的RD和RT。
>
> \[SwitchA\] vsi vpna
>
> \[SwitchA-vsi-vpna\] evpn encapsulation vxlan
>
> \[SwitchA-vsi-vpna-evpn-vxlan\] route-distinguisher auto
>
> \[SwitchA-vsi-vpna-evpn-vxlan\] vpn-target auto
>
> \[SwitchA-vsi-vpna-evpn-vxlan\] quit
>
> \# 创建VXLAN 10。
>
> \[SwitchA-vsi-vpna\] vxlan 10
>
> \[SwitchA-vsi-vpna-vxlan-10\] quit
>
> \[SwitchA-vsi-vpna\] quit
>
> \# 在VSI实例vpnb下创建EVPN实例，并配置自动生成EVPN实例的RD和RT。
>
> \[SwitchA\] vsi vpnb
>
> \[SwitchA-vsi-vpnb\] evpn encapsulation vxlan
>
> \[SwitchA-vsi-vpnb-evpn-vxlan\] route-distinguisher auto
>
> \[SwitchA-vsi-vpnb-evpn-vxlan\] vpn-target auto
>
> \[SwitchA-vsi-vpnb-evpn-vxlan\] quit
>
> \# 创建VXLAN 20。
>
> \[SwitchA-vsi-vpnb\] vxlan 20
>
> \[SwitchA-vsi-vpnb-vxlan-20\] quit
>
> \[SwitchA-vsi-vpnb\] quit
>
> \# 配置BGP发布EVPN路由。
>
> \[SwitchA\] bgp 200
>
> \[SwitchA-bgp-default\] peer 3.3.3.3 as-number 200
>
> \[SwitchA-bgp-default\] peer 3.3.3.3 connect-interface loopback 0
>
> \[SwitchA-bgp-default\] address-family l2vpn evpn
>
> \[SwitchA-bgp-default-evpn\] peer 3.3.3.3 enable
>
> \[SwitchA-bgp-default-evpn\] quit
>
> \[SwitchA-bgp-default\] quit
>
> \#
> 在接入服务器的接口Twenty-FiveGigE1/0/1上创建以太网服务实例1000，该实例用来匹配VLAN
> 2的数据帧。
>
> \[SwitchA\] interface GigabitEthernet 1/0/2
>
> \[SwitchA-GigabitEthernet1/0/2\] port link-type trunk
>
> \[SwitchA-GigabitEthernet1/0/2\] port trunk permit vlan 2 3
>
> \[SwitchA-GigabitEthernet1/0/2\] service-instance 1000
>
> \[SwitchA-GigabitEthernet1/0/2-srv1000\] encapsulation s-vid 2
>
> \# 配置以太网服务实例1000与VSI实例vpna关联。
>
> \[SwitchA-GigabitEthernet1/0/2-srv1000\] xconnect vsi vpna
>
> \[SwitchA-GigabitEthernet1/0/2-srv1000\] quit
>
> \#
> 在接口GigabitEthernet1/0/2上创建以太网服务实例2000，该实例用来匹配VLAN
> 3的数据帧。
>
> \[SwitchA-GigabitEthernet1/0/2\] service-instance 2000
>
> \[SwitchA-GigabitEthernet1/0/2-srv2000\] encapsulation s-vid 3
>
> \# 配置以太网服务实例2000与VSI实例vpnb关联。
>
> \[SwitchA-GigabitEthernet1/0/2-srv2000\] xconnect vsi vpnb
>
> \[SwitchA-GigabitEthernet1/0/2-srv2000\] quit
>
> \[SwitchA-GigabitEthernet1/0/2\] quit
>
> \# 配置L3VNI的RD和RT。
>
> \[SwitchA\] ip vpn-instance vpna
>
> \[SwitchA-vpn-instance-vpna\] route-distinguisher 1:1
>
> \[SwitchA-vpn-instance-vpna\] address-family ipv4
>
> \[SwitchA-vpn-ipv4-vpna\] vpn-target 2:2
>
> \[SwitchA-vpn-ipv4-vpna\] quit
>
> \[SwitchA-vpn-instance-vpna\] address-family evpn
>
> \[SwitchA-vpn-evpn-vpna\] vpn-target 1:1
>
> \[SwitchA-vpn-evpn-vpna\] quit
>
> \[SwitchA-vpn-instance-vpna\] quit
>
> \# 配置VSI虚接口VSI-interface1。
>
> \[SwitchA\] interface vsi-interface 1
>
> \[SwitchA-Vsi-interface1\] ip binding vpn-instance vpna
>
> \[SwitchA-Vsi-interface1\] ip address 10.1.1.1 255.255.255.0
>
> \[SwitchA-Vsi-interface1\] mac-address 1-1-1
>
> \[SwitchA-Vsi-interface1\] distributed-gateway local
>
> \[SwitchA-Vsi-interface1\] local-proxy-arp enable
>
> \[SwitchA-Vsi-interface1\] quit
>
> \# 配置VSI虚接口VSI-interface2。
>
> \[SwitchA\] interface vsi-interface 2
>
> \[SwitchA-Vsi-interface2\] ip binding vpn-instance vpna
>
> \[SwitchA-Vsi-interface2\] ip address 10.1.2.1 255.255.255.0
>
> \[SwitchA-Vsi-interface2\] mac-address 2-2-2
>
> \[SwitchA-Vsi-interface2\] distributed-gateway local
>
> \[SwitchA-Vsi-interface2\] local-proxy-arp enable
>
> \[SwitchA-Vsi-interface2\] quit
>
> \#
> 创建VSI虚接口VSI-interface3，在该接口上配置VPN实例vpna对应的L3VNI为1000。
>
> \[SwitchA\] interface vsi-interface 3
>
> \[SwitchA-Vsi-interface3\] ip binding vpn-instance vpna
>
> \[SwitchA-Vsi-interface3\] l3-vni 1000
>
> \[SwitchA-Vsi-interface3\] quit
>
> \# 配置VXLAN 10所在的VSI实例和接口VSI-interface1关联。
>
> \[SwitchA\] vsi vpna
>
> \[SwitchA-vsi-vpna\] gateway vsi-interface 1
>
> \[SwitchA-vsi-vpna\] quit
>
> \# 配置VXLAN 20所在的VSI实例和接口VSI-interface2关联。
>
> \[SwitchA\] vsi vpnb
>
> \[SwitchA-vsi-vpnb\] gateway vsi-interface 2
>
> \[SwitchA-vsi-vpnb\] quit
>
> (4)     配置Switch B
>
> \# 开启L2VPN能力。
>
> \<SwitchB\> system-view
>
> \[SwitchB\] l2vpn enable
>
> \# 关闭远端MAC地址和远端ARP自动学习功能。
>
> \[SwitchB\] vxlan tunnel mac-learning disable
>
> \[SwitchB\] vxlan tunnel arp-learning disable
>
> \# 在VSI实例vpna下创建EVPN实例，并配置自动生成EVPN实例的RD和RT。
>
> \[SwitchB\] vsi vpna
>
> \[SwitchB-vsi-vpna\] evpn encapsulation vxlan
>
> \[SwitchB-vsi-vpna-evpn-vxlan\] route-distinguisher auto
>
> \[SwitchB-vsi-vpna-evpn-vxlan\] vpn-target auto
>
> \[SwitchB-vsi-vpna-evpn-vxlan\] quit
>
> \# 创建VXLAN 10。
>
> \[SwitchB-vsi-vpna\] vxlan 10
>
> \[SwitchB-vsi-vpna-vxlan-10\] quit
>
> \[SwitchB-vsi-vpna\] quit
>
> \# 在VSI实例vpnb下创建EVPN实例，并配置自动生成EVPN实例的RD和RT。
>
> \[SwitchB\] vsi vpnb
>
> \[SwitchB-vsi-vpnb\] evpn encapsulation vxlan
>
> \[SwitchB-vsi-vpnb-evpn-vxlan\] route-distinguisher auto
>
> \[SwitchB-vsi-vpnb-evpn-vxlan\] vpn-target auto
>
> \[SwitchB-vsi-vpnb-evpn-vxlan\] quit
>
> \# 创建VXLAN 20。
>
> \[SwitchB-vsi-vpnb\] vxlan 20
>
> \[SwitchB-vsi-vpnb-vxlan-20\] quit
>
> \[SwitchB-vsi-vpnb\] quit
>
> \# 配置BGP发布EVPN路由。
>
> \[SwitchB\] bgp 200
>
> \[SwitchB-bgp-default\] peer 3.3.3.3 as-number 200
>
> \[SwitchB-bgp-default\] peer 3.3.3.3 connect-interface loopback 0
>
> \[SwitchB-bgp-default\] address-family l2vpn evpn
>
> \[SwitchB-bgp-default-evpn\] peer 4.4.4.4 enable
>
> \[SwitchB-bgp-default-evpn\] quit
>
> \[SwitchB-bgp-default\] quit
>
> \#
> 在接入服务器的接口GigabitEthernet1/0/2上创建以太网服务实例1000，该实例用来匹配VLAN
> 2的数据帧。
>
> \[SwitchB\] interface GigabitEthernet 1/0/2
>
> \[SwitchB-GigabitEthernet1/0/2\] port link-type trunk
>
> \[SwitchB-GigabitEthernet1/0/2\] port trunk permit vlan 2
>
> \[SwitchB-GigabitEthernet1/0/2\] service-instance 1000
>
> \[SwitchB-GigabitEthernet1/0/2-srv1000\] encapsulation s-vid 2
>
> \# 配置以太网服务实例1000与VSI实例vpna关联。
>
> \[SwitchB-GigabitEthernet1/0/2-srv1000\] xconnect vsi vpna
>
> \[SwitchB-GigabitEthernet1/0/2-srv1000\] quit
>
> \[SwitchB-GigabitEthernet1/0/2\] quit
>
> \#
> 在接口GigabitEthernet1/0/3上创建以太网服务实例2000，该实例用来匹配VLAN
> 3的数据帧。
>
> \[SwitchB\] interface GigabitEthernet 1/0/3
>
> \[SwitchB-GigabitEthernet1/0/3\] port link-type trunk
>
> \[SwitchB-GigabitEthernet1/0/3\] port trunk permit vlan 3
>
> \[SwitchB-GigabitEthernet1/0/3\] service-instance 2000
>
> \[SwitchB-GigabitEthernet1/0/3-srv2000\] encapsulation s-vid 3
>
> \# 配置以太网服务实例2000与VSI实例vpnb关联。
>
> \[SwitchB-GigabitEthernet1/0/3-srv2000\] xconnect vsi vpnb
>
> \[SwitchB-GigabitEthernet1/0/3-srv2000\] quit
>
> \[SwitchB-GigabitEthernet1/0/3\] quit
>
> \# 配置L3 VNI的RD和RT。
>
> \[SwitchB\] ip vpn-instance vpna
>
> \[SwitchB-vpn-instance-vpna\] route-distinguisher 1:2
>
> \[SwitchB-vpn-instance-vpna\] address-family ipv4
>
> \[SwitchB-vpn-ipv4-vpna\] vpn-target 2:2
>
> \[SwitchB-vpn-ipv4-vpna\] quit
>
> \[SwitchB-vpn-instance-vpna\] address-family evpn
>
> \[SwitchB-vpn-evpn-vpna\] vpn-target 1:1
>
> \[SwitchB-vpn-evpn-vpna\] quit
>
> \[SwitchB-vpn-instance-vpna\] quit
>
> \# 配置VSI虚接口VSI-interface1。
>
> \[SwitchB\] interface vsi-interface 1
>
> \[SwitchB-Vsi-interface1\] ip binding vpn-instance vpna
>
> \[SwitchB-Vsi-interface1\] ip address 10.1.1.1 255.255.255.0
>
> \[SwitchB-Vsi-interface1\] mac-address 1-1-1
>
> \[SwitchB-Vsi-interface1\] distributed-gateway local
>
> \[SwitchB-Vsi-interface1\] local-proxy-arp enable
>
> \[SwitchB-Vsi-interface1\] quit
>
> \# 创建VSI虚接口VSI-interface2。
>
> \[SwitchB\] interface vsi-interface 2
>
> \[SwitchB-Vsi-interface2\] ip binding vpn-instance vpna
>
> \[SwitchB-Vsi-interface2\] ip address 10.1.2.1 255.255.255.0
>
> \[SwitchB-Vsi-interface2\] mac-address 2-2-2
>
> \[SwitchB-Vsi-interface2\] distributed-gateway local
>
> \[SwitchB-Vsi-interface2\] local-proxy-arp enable
>
> \[SwitchB-Vsi-interface2\] quit
>
> \#
> 创建VSI虚接口VSI-interface3，在该接口上配置VPN实例vpna对应的L3VNI为1000。
>
> \[SwitchB\] interface vsi-interface 3
>
> \[SwitchB-Vsi-interface3\] ip binding vpn-instance vpna
>
> \[SwitchB-Vsi-interface3\] l3-vni 1000
>
> \[SwitchB-Vsi-interface3\] quit
>
> \# 配置VXLAN 10所在的VSI实例和接口VSI-interface1关联。
>
> \[SwitchB\] vsi vpna
>
> \[SwitchB-vsi-vpna\] gateway vsi-interface 1
>
> \[SwitchB-vsi-vpna\] quit
>
> \# 配置VXLAN 20所在的VSI实例和接口VSI-interface2关联。
>
> \[SwitchB\] vsi vpnb
>
> \[SwitchB-vsi-vpnb\] gateway vsi-interface 2
>
> \[SwitchB-vsi-vpnb\] quit
>
> (6)     配置Switch C
>
> \# 配置Switch C与其他交换机建立BGP连接。
>
> \<SwitchC\> system-view
>
> \[SwitchC\] bgp 200
>
> \[SwitchC-bgp-default\] group evpn
>
> \[SwitchC-bgp-default\] peer 1.1.1.1 group evpn
>
> \[SwitchC-bgp-default\] peer 2.2.2.2 group evpn
>
> \[SwitchC-bgp-default\] peer evpn as-number 200
>
> \[SwitchC-bgp-default\] peer evpn connect-interface loopback 0
>
> \# 配置BGP发布EVPN路由，并关闭BGP EVPN路由的VPN-Target过滤功能。
>
> \[SwitchC-bgp-default\] address-family l2vpn evpn
>
> \[SwitchC-bgp-default-evpn\] peer evpn enable
>
> \[SwitchC-bgp-default-evpn\] undo policy vpn-target
>
> \# 配置Switch C为路由反射器。
>
> \[SwitchC-bgp-default-evpn\] peer evpn reflect-client
>
> \[SwitchC-bgp-default-evpn\] quit
>
> \[SwitchC-bgp-default\] quit

4\. 验证配置

> (1)     验证分布式EVPN网关设备Switch A
>
> \# 查看Switch A上的EVPN路由信息，可以看到Switch
> A发送了网关的IP前缀路由、各VSI的IMET路由和MAC/IP路由，并接收到Switch
> B发送的网关IP前缀路由、各VSI的IMET路由和MAC/IP路由。
>
> \[SwitchA\] display bgp l2vpn evpn
>
>  BGP local router ID is 1.1.1.1
>
>  Status codes: \* - valid, \> - best, d - dampened, h - history,
>
>                s - suppressed, S - stale, i - internal, e - external
>
>                a - additional-path
>
>                Origin: i - IGP, e - EGP, ? - incomplete
>
>  
>
>  Total number of routes from all PEs: 14
>
>  
>
>  Route distinguisher: 1:1
>
>  Total number of routes: 4
>
>  
>
> \* \>  Network : \[5\]\[0\]\[24\]\[10.1.1.0\]/80
>
>      NextHop : 0.0.0.0                                  LocPrf    :
> 100
>
>      PrefVal : 32768                                    OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>  Network : \[5\]\[0\]\[24\]\[10.1.2.0\]/80
>
>      NextHop : 0.0.0.0                                  LocPrf    :
> 100
>
>      PrefVal : 32768                                    OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>i Network : \[5\]\[0\]\[24\]\[10.1.1.0\]/80
>
>      NextHop : 2.2.2.2                                  LocPrf    :
> 100
>
>      PrefVal : 0                                        OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>i Network : \[5\]\[0\]\[24\]\[10.1.2.0\]/80
>
>      NextHop : 2.2.2.2                                  LocPrf    :
> 100
>
>      PrefVal : 0                                        OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
>  Route distinguisher: 1:10
>
>  Total number of routes: 5
>
>  
>
> \* \>  Network :
> \[2\]\[0\]\[48\]\[0000-1234-0001\]\[0\]\[0.0.0.0\]/104
>
>      NextHop : 0.0.0.0                                  LocPrf    :
> 100
>
>      PrefVal : 32768                                    OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>  Network :
> \[2\]\[0\]\[48\]\[0000-1234-0001\]\[32\]\[10.1.1.10\]/136
>
>      NextHop : 0.0.0.0                                  LocPrf    :
> 100
>
>      PrefVal : 32768                                    OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>i Network :
> \[2\]\[0\]\[48\]\[0000-1234-0003\]\[32\]\[10.1.1.20\]/136
>
>      NextHop : 2.2.2.2                                  LocPrf    :
> 100
>
>      PrefVal : 0                                        OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>  Network : \[3\]\[10\]\[32\]\[1.1.1.1\]/80
>
>      NextHop : 0.0.0.0                                  LocPrf    :
> 100
>
>      PrefVal : 32768                                    OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>i Network : \[3\]\[10\]\[32\]\[2.2.2.2\]/80
>
>      NextHop : 2.2.2.2                                  LocPrf    :
> 100
>
>      PrefVal : 0                                        OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
>  Route distinguisher: 1:20
>
>  Total number of routes: 5
>
>  
>
> \* \>  Network :
> \[2\]\[0\]\[48\]\[0000-1234-0002\]\[0\]\[0.0.0.0\]/104
>
>      NextHop : 0.0.0.0                                  LocPrf    :
> 100
>
>      PrefVal : 32768                                    OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>  Network :
> \[2\]\[0\]\[48\]\[0000-1234-0002\]\[32\]\[10.1.2.10\]/136
>
>      NextHop : 0.0.0.0                                  LocPrf    :
> 100
>
>      PrefVal : 32768                                    OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>i Network :
> \[2\]\[0\]\[48\]\[0000-1234-0004\]\[32\]\[10.1.2.20\]/136
>
>      NextHop : 2.2.2.2                                  LocPrf    :
> 100
>
>      PrefVal : 0                                        OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>  Network : \[3\]\[10\]\[32\]\[1.1.1.1\]/80
>
>      NextHop : 0.0.0.0                                  LocPrf    :
> 100
>
>      PrefVal : 32768                                    OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
>  
>
> \* \>i Network : \[3\]\[10\]\[32\]\[2.2.2.2\]/80
>
>      NextHop : 2.2.2.2                                  LocPrf    :
> 100
>
>      PrefVal : 0                                        OutLabel  :
> NULL
>
>      MED     : 0
>
>      Path/Ogn: i
>
> \# 查看Switch
> A上的Tunnel接口信息，可以看到VXLAN模式的Tunnel接口处于up状态。（以Tunnel0接口为例）
>
> \[SwitchA\] display interface tunnel 0
>
> Tunnel0
>
> Current state: UP
>
> Line protocol state: UP
>
> Description: Tunnel0 Interface
>
> Bandwidth: 64 kbps
>
> Maximum transmission unit: 1464
>
> Internet protocol processing: Disabled
>
> Last clearing of counters: Never
>
> Tunnel source 1.1.1.1, destination 2.2.2.2
>
> Tunnel protocol/transport UDP_VXLAN/IP
>
> Last 300 seconds input rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec
>
> Last 300 seconds output rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec
>
> Input: 0 packets, 0 bytes, 0 drops
>
> Output: 0 packets, 0 bytes, 0 drops
>
> \# 查看Switch
> A上的VSI虚接口信息，可以看到VSI虚接口处于up状态。（以VSI虚接口1为例）
>
> \[SwitchA\] display interface vsi-interface brief
>
> Brief information on interfaces in route mode:
>
> Link: ADM - administratively down; Stby - standby
>
> Protocol: (s) - spoofing
>
> Interface            Link Protocol Primary IP          Description
>
> Vsi1                 UP   UP       10.1.1.1
>
> Vsi2                 UP   UP       10.1.2.1
>
> \# 查看Switch
> A上的VSI信息，可以看到VSI内创建的VXLAN、与VXLAN关联的VXLAN隧道、与VSI关联的VSI虚接口等信息。
>
> \[SwitchA\] display l2vpn vsi verbose
>
> VSI Name: Auto_L3VNI200_3
>
>   VSI Index               : 1
>
>   VSI State               : Down
>
>   MTU                     : 1500
>
>   Bandwidth               : Unlimited
>
>   Broadcast Restrain      : Unlimited
>
>   Multicast Restrain      : Unlimited
>
>   Unknown Unicast Restrain: Unlimited
>
>   MAC Learning            : Enabled
>
>   MAC Table Limit         : -
>
>   MAC Learning rate       : -
>
>   Drop Unknown            : -
>
>   Flooding                : Enabled
>
>   Statistics              : Disabled
>
>   Gateway Interface       : VSI-interface 3
>
>   VXLAN ID                : 1000
>
>  
>
> VSI Name: vpna
>
>   VSI Index               : 0
>
>   VSI State               : Up
>
>   MTU                     : 1500
>
>   Bandwidth               : Unlimited
>
>   Broadcast Restrain      : Unlimited
>
>   Multicast Restrain      : Unlimited
>
>   Unknown Unicast Restrain: Unlimited
>
>   MAC Learning            : Enabled
>
>   MAC Table Limit         : -
>
>   MAC Learning rate       : -
>
>   Drop Unknown            : -
>
>   Flooding                : Enabled
>
>   Statistics              : Disabled
>
>   Gateway Interface       : VSI-interface 1
>
>   VXLAN ID                : 10
>
>   Tunnels:
>
>     Tunnel Name          Link ID    State  Type      Flood proxy
>
>     Tunnel0              0x5000001  Up     Auto      Disabled
>
>     Tunnel1              0x5000002  Up     Auto      Disabled
>
>   ACs:
>
>     AC                               Link ID    State    Type
>
>     WGE1/0/1 srv1000                 0          Up       Manual
>
>  
>
> VSI Name: vpnb
>
>   VSI Index               : 0
>
>   VSI State               : Up
>
>   MTU                     : 1500
>
>   Bandwidth               : Unlimited
>
>   Broadcast Restrain      : Unlimited
>
>   Multicast Restrain      : Unlimited
>
>   Unknown Unicast Restrain: Unlimited
>
>   MAC Learning            : Enabled
>
>   MAC Table Limit         : -
>
>   MAC Learning rate       : -
>
>   Drop Unknown            : -
>
>   Flooding                : Enabled
>
>   Statistics              : Disabled
>
>   Gateway Interface       : VSI-interface 2
>
>   VXLAN ID                : 20
>
>   Tunnels:
>
>     Tunnel Name          Link ID    State  Type      Flood proxy
>
>     Tunnel0              0x5000001  Up     Auto      Disabled
>
>     Tunnel1              0x5000002  Up     Auto      Disabled
>
>   ACs:
>
>     AC                               Link ID    State    Type
>
>     WGE1/0/1 srv2000                 0          Up       Manual
>
> \# 查看Switch
> A上VSI的ARP表项信息，可以看到已学习到了本地虚拟机的ARP信息。
>
> \# 查看Switch A上VSI的EVPN
> ARP表项信息，可以看到已学习到了本地虚拟机的ARP信息。
>
> \[SwitchA\] display evpn route arp
>
> Flags: D - Dynamic   B - BGP      L - Local active
>
>        G - Gateway   S - Static   M - Mapping        I - Invalid
>
>  
>
> VPN instance: vpna                            Interface:
> Vsi-interface1
>
> IP address      MAC address     Router MAC      VSI Index   Flags
>
> 10.1.1.1        0001-0001-0001  a0ce-7e40-0400  0           GL
>
> 10.1.1.10       0000-1234-0001  a0ce-7e40-0400  0           DL
>
> 10.1.2.10       0000-1234-0002  a0ce-7e40-0400  0           DL
>
> 10.1.1.20       0000-1234-0003  a0ce-7e40-0400  0           B
>
> 10.1.2.20       0000-1234-0004  a0ce-7e40-0400  0           B
>
> (2)     验证主机之间可以互访
>
> 虚拟机VM 1、VM 2、VM 3、VM 4之间可以互访。
