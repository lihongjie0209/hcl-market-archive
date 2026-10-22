# 动态分配地址配置举例

**标签：**

**DHCP**

## 需求

DHCP服务器通过地址池保存IP地址和网络参数，从地址池中选择IP地址和网络参数分配给客户端。路由器RTA做为DHCP
Server，终端动态获取IP。

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

## 测试结果：

配置完成后，各个PC可以从DHCP服务器申请到IP地址，并获取相关网络配置参数。通过display
dhcp server ip-in-use命令可以查看DHCP服务器为客户端分配的IP地址。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
