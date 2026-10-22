# DHCPv6无状态配置

**标签：**

**DHCPv6**

## 需求

DHCPv6服务器可以为已经具有IPv6地址/前缀的客户端分配其他网络配置参数，该过程称为DHCPv6无状态配置。

DHCPv6客户端通过地址无状态自动配置功能成功获取IPv6地址后，即DHCPv6客户端根据路由器发现/前缀发现所获取的信息自动配置IPv6地址后，如果接收到的RA（Router
Advertisement，路由器通告）报文中M标志位（Managed address configuration
flag，被管理地址配置标志位）取值为0、O标志位（Other stateful
configuration
flag，其他配置标志位）取值为1，则DHCPv6客户端会自动启动DHCPv6无状态配置功能，以获取除地址/前缀外的其他网络配置参数。

## 实验步骤：

1、Server配置：

\#

interface GigabitEthernet0/0

ipv6 nd ra prefix default 100 10

ipv6 address 1::1/64

undo ipv6 nd ra halt

\#

2、Client配置：

\#

interface GigabitEthernet0/0

ipv6 address auto

\#

## 测试结果：

配置完成后，Client可以直接通过Server的接口前缀生成IPv6地址。

![](./Media//image1.png)


地址生成方式实际为EUI-64：

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
