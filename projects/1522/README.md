# DHCP服务器的用户下线探测

**标签：**

**DHCP**

## 需求

在移动终端接入比较频繁的场景中，部分用户离开时可能没有正常发送DHCP下线报文，导致DHCP服务器占用了较多DHCP地址，只有等到租约老化才能释放。为了缓解该类问题，可以配置DHCP用户下线探测功能。

DHCP服务器的用户下线探测功能以ARP表项老化功能为基础，当ARP表项老化时认为该表项对应的用户已下线。如果在接口上开启了DHCP服务器的用户下线探测功能，则当ARP表项老化时，系统会删除该表项对应用户的地址绑定信息。

手工删除ARP表项，不会触发DHCP服务器删除对应用户的地址绑定信息。

## 实验步骤：

1、配置接口的IP地址。

\#

interface GigabitEthernet0/0

ip address 10.1.1.126 255.255.255.0

\#

2、配置DHCP服务。

\#

dhcp enable

dhcp server forbidden-ip 10.1.1.2

dhcp server forbidden-ip 10.1.1.4

\#

dhcp server ip-pool 1

gateway-list 10.1.1.126

network 10.1.1.0 mask 255.255.255.128

dns-list 10.1.1.2

domain-name aabbcc.com

expired day 10 hour 12

nbns-list 10.1.1.4

\#

3、开启dhcp用户下线探测功能。

\#

interface GigabitEthernet0/0

dhcp client-detect

\#

## 测试结果：

配置完成后，各个PC可以从DHCP服务器申请到IP地址，并获取相关网络配置参数。通过display
dhcp server ip-in-use命令可以查看DHCP服务器为客户端分配的IP地址。

![](./Media//image1.png)


当设备上的ARP表项老化时，DHCP服务器认为该表项对应的DHCP客户端已经下线，DHCP服务器会删除对应的IP地址租约。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
