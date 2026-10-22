# DHCPv6有状态配置

**标签：**

**DHCPv6**

## 需求

为了便于集中管理IPv6地址，简化网络配置，DHCPv6服务器可以用来为DHCPv6客户端提供诸如IPv6地址、域名后缀、DNS服务器地址等网络配置参数。DHCPv6客户端根据服务器分配的参数来实现主机的配置。

DHCPv6服务器为客户端分配的IPv6地址分为以下两类：

临时IPv6地址：在短期内经常变化且不用续约的地址；

非临时IPv6地址：正常使用，可以进行续约的地址。

## 实验步骤：

1、Server配置：

\#

ipv6 dhcp pool 1

network 1::/64

dns-server 2:2::3

domain-name aaa.com

\#

interface GigabitEthernet0/0

ipv6 dhcp select server

ipv6 dhcp server allow-hint preference 255 rapid-commit

ipv6 address 1::1/64

ipv6 nd autoconfig managed-address-flag

ipv6 nd autoconfig other-flag

undo ipv6 nd ra halt

\#

2、Client配置：

\#

interface GigabitEthernet0/0

ipv6 address dhcp-alloc

\#

## 测试结果：

配置完成后，Client可以从DHCPv6服务器获取到IPv6地址。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
