# 工程名称
交换机分布式VxLAN IP网关配置举例


## 需求：
Switch A、Switch B为与服务器连接的分布式VXLAN IP网关设备，Switch C和Switch D为广域网内的三层交换机。虚拟机VM 1、VM 2属于不同VXLAN，通过VXLAN实现不同站点间的三层互联，使VM1能够跟VM2通信。


## 实验步骤：
1、配置IP地址和单播路由协议
2、VTEP之间创建VXLAN隧道，并将隧道与VXLAN关联，接口上关联VSI实例
3、分布式网关上配置vsi-interface，并与VSI关联
4、VM的缺省网关指向vsi-interface地址


## 测试结果：
查看SWA上的Tunnel接口信息，可以看到VXLAN模式的Tunnel接口处于up状态。
<SWA>display interface Tunnel 
Tunnel1
Current state: UP
Line protocol state: UP
Description: Tunnel1 Interface
Bandwidth: 64 kbps
Maximum transmission unit: 1464
Internet protocol processing: Disabled
Last clearing of counters: Never
Tunnel source 6.6.6.6, destination 8.8.8.8
Tunnel protocol/transport UDP_VXLAN/IP
Last 300 seconds input rate: 71 bytes/sec, 568 bits/sec, 1 packets/sec
Last 300 seconds output rate: 88 bytes/sec, 704 bits/sec, 1 packets/sec
Input: 204563 packets, 11897216 bytes, 0 drops
Output: 233218 packets, 13435592 bytes, 0 drops

查看SWA上的VSI虚接口信息，可以看到VSI虚接口处于up状态。
<SWA>display interface Vsi-interface 
Vsi-interface1
Current state: UP
Line protocol state: UP
Description: Vsi-interface1 Interface
Bandwidth: 1000000 kbps
Maximum transmission unit: 1444
Internet address: 10.1.1.1/24 (Primary)
IP packet frame type: Ethernet II, hardware address: 0001-0001-0001
IPv6 packet frame type: Ethernet II, hardware address: 0001-0001-0001
Physical: Unknown, baudrate: 1000000 kbps
Last clearing of counters: Never
Last 300 seconds input rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec
Last 300 seconds output rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec
Input: 0 packets, 0 bytes, 0 drops
Output: 0 packets, 0 bytes, 0 drops

Vsi-interface2
Current state: UP
Line protocol state: UP
Description: Vsi-interface2 Interface
Bandwidth: 1000000 kbps
Maximum transmission unit: 1444
Internet address: 10.1.2.1/24 (Primary)
IP packet frame type: Ethernet II, hardware address: 0002-0002-0002
IPv6 packet frame type: Ethernet II, hardware address: 0002-0002-0002
Physical: Unknown, baudrate: 1000000 kbps
Last clearing of counters: Never
Last 300 seconds input rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec
Last 300 seconds output rate: 0 bytes/sec, 0 bits/sec, 0 packets/sec
Input: 0 packets, 0 bytes, 0 drops
Output: 93846 packets, 5630760 bytes, 0 drops

查看SWA上的VSI信息，可以看到VSI内创建的VXLAN、与VXLAN关联的VXLAN隧道、与VSI关联的VSI虚接口等信息。
<SWA>display l2vpn vsi name vpna verbose 
VSI Name: vpna
  VSI Index               : 0
  VSI State               : Up
  MTU                     : 1500
  Bandwidth               : -
  Broadcast Restrain      : -
  Multicast Restrain      : -
  Unknown Unicast Restrain: -
  MAC Learning            : Enabled
  MAC Table Limit         : -
  MAC Learning rate       : -
  Drop Unknown            : -
  Flooding                : Enabled
  Gateway Interface       : VSI-interface 1
  VXLAN ID                : 10
  Tunnels:
    Tunnel Name          Link ID    State    Type        Flood proxy
    Tunnel1              0x5000001  UP       Manual      Disabled
  ACs:
    AC                                 Link ID    State       Type    
    GE1/0/3 srv100                     0          Up          Manual  
<SWA>display l2vpn vsi name vpnb verbose 
VSI Name: vpnb
  VSI Index               : 1
  VSI State               : Up
  MTU                     : 1500
  Bandwidth               : -
  Broadcast Restrain      : -
  Multicast Restrain      : -
  Unknown Unicast Restrain: -
  MAC Learning            : Enabled
  MAC Table Limit         : -
  MAC Learning rate       : -
  Drop Unknown            : -
  Flooding                : Enabled
  Gateway Interface       : VSI-interface 2
  VXLAN ID                : 20
  Tunnels:
    Tunnel Name          Link ID    State    Type        Flood proxy
    Tunnel1              0x5000001  UP       Manual      Disabled
  ACs:
    AC                                 Link ID    State       Type    
    GE1/0/3 srv200                     0          Up          Manual  

查看SWA上VSI的ARP表项信息，可以看到已学习到了虚拟机的ARP信息。
<SWA>display arp
  Type: S-Static   D-Dynamic   O-Openflow   R-Rule   M-Multiport  I-Invalid
IP address      MAC address    VLAN/VSI name Interface                Aging Type
1.1.1.2         6228-38c3-0306 --            GE1/0/1                  900   D   
2.1.1.2         6228-3f44-0406 --            GE1/0/2                  915   D   
10.1.1.11       6228-8286-0502 vpna          GE1/0/3                  1198  D   
10.1.2.11       0002-0002-0002 vpnb          Tunnel1                  1196  D   

虚拟机VM 1、VM 2之间可以互访
[VM2]ping 10.1.1.11
Ping 10.1.1.11 (10.1.1.11): 56 data bytes, press CTRL+C to break
56 bytes from 10.1.1.11: icmp_seq=0 ttl=253 time=3.000 ms
56 bytes from 10.1.1.11: icmp_seq=1 ttl=253 time=2.000 ms
56 bytes from 10.1.1.11: icmp_seq=2 ttl=253 time=2.000 ms
56 bytes from 10.1.1.11: icmp_seq=3 ttl=253 time=2.000 ms
56 bytes from 10.1.1.11: icmp_seq=4 ttl=253 time=1.000 ms

--- Ping statistics for 10.1.1.11 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/2.000/3.000/0.632 ms
[VM2]%Aug 17 17:03:44:744 2022 VM2 PING/6/PING_STATISTICS: Ping statistics for 10.1.1.11: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/2.000/3.000/0.632 ms.


## 说明： 
1、本实验用的模拟器为S6850，设置内存为默认。
2、本实验用的路由器版本为默认版本。

