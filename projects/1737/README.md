# 通过路由器实现VLAN间路由

## 需求：

VLAN内部节点的通信是二层通信，而不同的VLAN之间的节点通信则是三层通信，可以借助路由器实现VLAN间路由。

## 实验步骤：

1.  配置路由器接口的IP地址。

2.  配置SW VLAN，并与接口关联。

Router配置：

\#

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ip address 192.168.10.254 255.255.255.0

\#

interface GigabitEthernet0/1

port link-mode route

combo enable copper

ip address 192.168.20.254 255.255.255.0

\#

SW配置：

\#

vlan 10

\#

vlan 20

\#

interface GigabitEthernet1/0/1

port link-mode bridge

port access vlan 10

combo enable fiber

\#

interface GigabitEthernet1/0/2

port link-mode bridge

port access vlan 20

combo enable fiber

\#

interface GigabitEthernet1/0/3

port link-mode bridge

port access vlan 10

combo enable fiber

\#

interface GigabitEthernet1/0/4

port link-mode bridge

port access vlan 20

combo enable fiber

\#

## 测试结果：

配置完成后，PC之间可以互访。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
