# 运营商宽带业务配置

**标签：**

**PPPoE**

## 需求

运营商BRAS设备，为宽带用户提供接入服务。宽带用户采用PPPoE方式接入，需要支持双栈，BRAS设备作为PPPoE
Server通过DHCPv4协议为CPE分配IPv4地址，通过DHCPv6协议为Host
A分配IPv6地址。

## 实验步骤：

配置虚拟模板接口1的参数，采用PAP认证对端。

\#

interface Virtual-Template1

ppp authentication-mode pap domain dm1

ipv6 dhcp select server

ipv6 address auto link-local

ipv6 nd autoconfig managed-address-flag

ipv6 nd autoconfig other-flag

undo ipv6 nd ra halt

\#

在GigabitEthernet0/0接口上启用PPPoE
Server协议，将该以太网接口与虚拟模板接口1绑定。

\#

interface gigabitethernet 0/0

pppoe-server bind virtual-template 1

\#

启用DHCP服务。

\#

dhcp enable

\#

配置地址池。

\#

ipv6 dhcp prefix-pool 1 prefix 2002:410::/32 assign-len 48

ipv6 dhcp server forbidden-address 2001::1

\#

dhcp server ip-pool pool1

gateway-list 1.1.1.1 export-route

network 1.1.1.0 mask 255.255.255.0 export-route

dns-list 114.114.114.114

forbidden-ip 1.1.1.1

\#

ipv6 dhcp pool pool2

network 2001::/64 export-route

dns-server 2002::1

prefix-pool 1

\#

配置PPPoE用户。

\#

local-user user1 class network

password simple pass1

service-type ppp

\#

在ISP域dm1下，配置域用户使用本地AAA方案，并授权地址池。

\#

domain dm1

authentication ppp local

accounting ppp local

authorization ppp local

authorization-attribute ip-pool pool1

authorization-attribute ipv6-pool pool2

\#

## 测试结果

Host可以获取到IPv4与IPv6地址，并生成响应的路由。

![](./Media//image1.png)


CR也会能学习到发布出去的路由。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
