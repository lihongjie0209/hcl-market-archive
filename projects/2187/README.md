# 工程名称
V7防火墙作为网关配置DHCP中继


## 需求：
防火墙作为vlan10的网关通过配置DHCP中继指定DHCP服务器地址，由专用DHCP服务器给下行终端分配ip地址


## 实验步骤：
**1、配置接口ip和二层接口所属vlan以及路由，务必保证使能dhcp中继的接口地址可以跟dhcp服务器互通，本例中DHCP服务器与防火墙直连，所以防火墙无需手动添加到dhcp服务器的路由**


**2、配置网关接口工作在DHCP中继模式、指定DHCP服务器地址同时全局开启dhcp功能**
#
vlan 10
# 
interface GigabitEthernet1/0/1
 port link-mode bridge
 port access vlan 10
#
interface Vlan-interface10
 ip address 172.16.10.1 255.255.255.0
 dhcp select relay
 dhcp relay server-address 10.0.12.2
#
 dhcp enable
#

**3、内网二层接口及对应vlan-interface加入trust安全域，链接DHCP服务器的接口加入dhcpserver域**
#
security-zone name Trust
 import interface Vlan-interface10
 import interface GigabitEthernet1/0/1 vlan 10
#
security-zone name dhcpserver
 import interface GigabitEthernet1/0/2
#


**4、配置安全策略放行trust域和local域之间的udp 目的端口为67和68的报文(这两个目的端口设备有默认的服务对象组，分别为dhcp-server和dhcp-client)，同时放行dhcpserver安全域与local域的udp 目的端口为67的报文(防火墙默认的dhcp-relay服务对象组)**
#
security-policy ip
 rule 1 name todhcpclient
  action pass
  source-zone local
  source-zone trust
  destination-zone trust
  destination-zone local
  service dhcp-client
  service dhcp-server
 rule 2 name todhcpserver
  action pass
  source-zone local
  source-zone dhcpserver
  destination-zone dhcpserver
  destination-zone local
  service dhcp-relay
#

## 测试结果：
**1、PC1和PC2都可以获取到地址**
[DHCPserver]dis dhcp server ip-in-use 
IP address       Client identifier/    Lease expiration      Type
                 Hardware address
172.16.10.2      0030-3862-392e-3032-  Aug  2 13:38:23 2022  Auto(C)            
                 3063-2e30-3430-352d-                                           
                 4745-302f-30                                                   
172.16.10.3      0030-3862-392e-3039-  Aug  2 13:39:12 2022  Auto(C)            
                 3161-2e30-3530-352d-                                           
                 4745-302f-30                                                   
[DHCPserver] 

**2、DHCP中继服务器上可以看到和DHCP服务器交互的报文计数**
<FW1>dis dhcp relay statistics 
DHCP packets dropped:                  0
DHCP packets received from clients:    4
   DHCPDISCOVER:                       2
   DHCPREQUEST:                        2
   DHCPINFORM:                         0
   DHCPRELEASE:                        0
   DHCPDECLINE:                        0
   BOOTPREQUEST:                       0
DHCP packets received from servers:    4
   DHCPOFFER:                          2
   DHCPACK:                            2
   DHCPNAK:                            0
   BOOTPREPLY:                         0
DHCP packets relayed to servers:       4
   DHCPDISCOVER:                       2
   DHCPREQUEST:                        2
   DHCPINFORM:                         0
   DHCPRELEASE:                        0
   DHCPDECLINE:                        0
   BOOTPREQUEST:                       0
DHCP packets relayed to clients:       4
   DHCPOFFER:                          2
   DHCPACK:                            2
   DHCPNAK:                            0
   BOOTPREPLY:                         0
DHCP packets sent to servers:          0
   DHCPDISCOVER:                       0
   DHCPREQUEST:                        0
   DHCPINFORM:                         0
   DHCPRELEASE:                        0
   DHCPDECLINE:                        0
   BOOTPREQUEST:                       0
DHCP packets sent to clients:          0
   DHCPOFFER:                          0
   DHCPACK:                            0
   DHCPNAK:                            0
   BOOTPREPLY:                         0
<FW1> 

## 说明： 
**1、设备作为DHCP中继时，一定要保证使能中继的接口地址和dhcp服务器地址可以互通**

**2、防火墙要双向放行local域和DHCP客户端所在安全域之间的目的为udp 67(dhcp-server)和udp 68(dhcp-client)的报文，同时双向放行local域和DHCP服务器之间的目的为udp 67(dhcp-relay)的报文。**

