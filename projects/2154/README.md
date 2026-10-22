# 工程名称
V7防火墙作为网关配置DHCP服务器


## 需求：
1、防火墙作为vlan10的网关通过dhcp给下行终端分配ip地址

2、给pc1(mac:acdf-db19-0305)固定分配172.16.10.5的地址，pc2可随机分配

3、172.16.10.2不参与地址分配



## 实验步骤：

**1、配置接口ip和二层接口所属vlan**
#
vlan 10
# 
interface GigabitEthernet1/0/1
 port link-mode bridge
 port access vlan 10
#
interface Vlan-interface10
 ip address 172.16.10.1 255.255.255.0
#

**2、配置dhcp地址池，同时全局开启dhcp功能**
#              
dhcp server ip-pool vlan10
 gateway-list 172.16.10.1
 network 172.16.10.0 mask 255.255.255.0
 dns-list 114.114.114.114 8.8.8.8
 forbidden-ip 172.16.10.2
 static-bind ip-address 172.16.10.5 mask 255.255.0.0 hardware-address acdf-db19-0305
#
 dhcp enable
#


**3、内网二层接口及对应vlan-interface加入trust安全域**
#
security-zone name Trust
 import interface Vlan-interface10
 import interface GigabitEthernet1/0/1 vlan 10
#  


**4、配置安全策略放行trust域和local域之间的udp 目的端口为67和68的报文(这两个目的端口设备有默认的服务对象组，分别为dhcp-server和dhcp-client)**
#
security-policy ip
 rule 1 name dhcpserver
  action pass
  source-zone local
  source-zone trust
  destination-zone trust
  destination-zone local
  service dhcp-client
  service dhcp-server
#


## 测试结果：

**1、PC1可获取到172.16.10.5的地址**
[PC1]dis ip int brief
*down: administratively down
(s): spoofing  (l): loopback
Interface           Physical Protocol IP address/Mask    VPN instance Description  
GE0/0               up       up       172.16.10.5/24     --           --

**2、PC2也获取到了ip地址**
<H3C>dis ip int brief
*down: administratively down
(s): spoofing  (l): loopback
Interface           Physical Protocol IP address/Mask    VPN instance Description  
GE0/0               up       up       172.16.10.3/24     --           --

## 说明： 
**1、安全策略必须双向放行，否则会导致获取失败**

**2、三层接口默认工作在dhcp服务器模式**

**3、二层物理接口加安全域的时候必须指定vlan参数，这里的vlan指的是这个接口允许通过的vlan**

