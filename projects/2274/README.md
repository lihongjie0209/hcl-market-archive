# 工程名称
V7防火墙作为网关配置DHCPv6服务器


## 需求：
1、防火墙作为vlan10的网关通过dhcp给下行终端分配ipv6地址

2、给pc1(mac:acdf-db19-0305)固定分配2022:8:3::5的地址，pc2可随机分配

## 实验步骤：
**1、配置接口ipv6地址，配置接口工作在ipv6 dhcp server模式，并取消RA消息抑制，配置被管理地址的配置标志位为1，即主机通过DHCPv6服务器获取IPv6地址。配置其他信息配置标志位为1，即主机通过DHCPv6服务器获取除IPv6地址以外的其他信息**
#
interface GigabitEthernet1/0/1
 port link-mode route
 ipv6 dhcp select server
 ipv6 address 2022:8:3::1/64
 ipv6 nd autoconfig managed-address-flag
 ipv6 nd autoconfig other-flag
 undo ipv6 nd ra halt
#

**2、配置dhcpv6地址池**
#              
ipv6 dhcp pool pool1
 network 2022:8:3::/64
 dns-server 2022::1
 static-bind address 2022:8:3::5/64 duid 00030001125707920305
#

**3、内网接口加入trust安全域**
#
security-zone name Trust
 import interface GigabitEthernet1/0/1
#

**4、配置ipv6安全策略放行trust域和local域之间的udp 目的端口为546和547的报文**
#
object-group service dhcpv6server
 0 service udp destination eq 546
 10 service udp destination eq 547
# 
security-policy ipv6
 rule 1 name dhcpv6server
  action pass
  source-zone trust
  source-zone local
  destination-zone local
  destination-zone trust
  service dhcpv6server
#


## 测试结果：
**1、PC1可获取到2022:8:3::5的地址**
[PC1]dis ipv6 dhcp client 
GigabitEthernet0/0:
  Type: Stateful client requesting address
    State: OPEN
    Client DUID: 00030001125707920305
    Preferred server:
      Reachable via address: FE80::1056:BFFF:FE98:106
      Server DUID: 000300011256bf980100
    IA_NA: IAID 0x00000001, T1 302400 sec, T2 483840 sec
      Address: 2022:8:3::5
        Preferred lifetime 604800 sec, valid lifetime 2592000 sec
        Will expire on Sep 2 2022 at 14:11:20 (2591965 seconds left)
    DNS server addresses:
      2022::1
[PC1] 


**2、PC2也获取到了ip地址**
[PC2]dis ipv6 dhcp client 
GigabitEthernet0/0:
  Type: Stateful client requesting address
    State: OPEN
    Client DUID: 0003000112570d260400
    Preferred server:
      Reachable via address: FE80::1056:BFFF:FE98:106
      Server DUID: 000300011256bf980100
    IA_NA: IAID 0x00000001, T1 302400 sec, T2 483840 sec
      Address: 2022:8:3::2
        Preferred lifetime 604800 sec, valid lifetime 2592000 sec
        Will expire on Sep 2 2022 at 14:08:59 (2591539 seconds left)
    DNS server addresses:
      2022::1
[PC2]

## 说明： 
**1、安全策略必须双向放行，否则会导致获取失败**

**2、必须配置接口工作在IPV6 dhcp server模式**

