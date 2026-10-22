# 工程名称
V7防火墙作为网关配置DHCPv6中继


## 需求：
防火墙作为内网网关通过配置DHCPv6中继指定DHCPv6服务器地址，由专用DHCPv6服务器给下行终端分配ipv6地址


## 实验步骤：
**1、配置接口ip**

**2、配置网关接口工作在DHCPv6中继模式、指定DHCPv6服务器地址**
#
interface GigabitEthernet1/0/1
 port link-mode route
 ipv6 dhcp select relay
 ipv6 dhcp relay server-address 1::2
 ipv6 address 2022:8:3::1/64
 ipv6 nd autoconfig managed-address-flag
 ipv6 nd autoconfig other-flag
 undo ipv6 nd ra halt
#

**3、内网接口加入trust安全域，链接DHCP服务器的接口加入server域**
#
security-zone name Trust
 import interface GigabitEthernet1/0/1
#
security-zone name server
 import interface GigabitEthernet1/0/2
#

**4、配置ipv6安全策略放行trust域和local域之间的udp 目的端口为546和547的报文，同时放行local安全域到server域的udp 目的端口为546和547的报文**
#
object-group service dhcpv6server
 0 service udp destination eq 546
 10 service udp destination eq 547
#  
security-policy ipv6
 rule 1 name withdhcpv6client
  action pass
  source-zone local
  source-zone trust
  destination-zone trust
  destination-zone local
  service dhcpv6server
 rule 2 name withdhcpv6server
  action pass
  source-zone local
  destination-zone server
  service dhcpv6server
#

## 测试结果：
1、PC1和PC2都可以获取到地址
<PC1>dis ipv6 dhcp client 
GigabitEthernet0/0:
  Type: Stateful client requesting address
    State: OPEN
    Client DUID: 00030001162c6fe60300
    Preferred server:
      Reachable via address: FE80::142C:26FF:FEC0:106
      Server DUID: 00030001162c96d00500
    IA_NA: IAID 0x00000001, T1 302400 sec, T2 483840 sec
      Address: 2022:8:3::2
        Preferred lifetime 604800 sec, valid lifetime 2592000 sec
        Will expire on Sep 3 2022 at 20:41:23 (2591755 seconds left)
    DNS server addresses:
      2022::1
<PC1>
<PC2>dis ipv6 dhcp client 
GigabitEthernet0/0:
  Type: Stateful client requesting address
    State: OPEN
    Client DUID: 00030001162c76170400
    Preferred server:
      Reachable via address: FE80::142C:26FF:FEC0:106
      Server DUID: 00030001162c96d00500
    IA_NA: IAID 0x00000001, T1 302400 sec, T2 483840 sec
      Address: 2022:8:3::3
        Preferred lifetime 604800 sec, valid lifetime 2592000 sec
        Will expire on Sep 3 2022 at 20:41:40 (2591738 seconds left)
    DNS server addresses:
      2022::1
<PC2>

## 说明： 
**配置ipv6安全策略放行trust域和local域之间的udp 目的端口为546和547的报文，同时放行local安全域到server域的udp 目的端口为546和547的报文**

