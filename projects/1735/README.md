# VLAN间路由-单臂路由

## 需求：

在路由器以太网接口上进行子接口的划分，与交换机的Trunk链路对接，从而实现VLAN间路由。

## 实验步骤：

1.  路由器配置子接口的IP地址。

2.  SW配置VLAN，并与接口关联。

Router配置：

\#

interface GigabitEthernet0/0.1

ip address 192.168.1.1 255.255.255.0

vlan-type dot1q vid 2

\#

interface GigabitEthernet0/0.2

ip address 192.168.2.1 255.255.255.0

vlan-type dot1q vid 3

\#

SW配置：

\#

vlan 2 to 3

\#

interface GigabitEthernet1/0/1

port link-mode bridge

port link-type trunk

undo port trunk permit vlan 1

port trunk permit vlan 2 to 3

combo enable fiber

\#

interface GigabitEthernet1/0/2

port link-mode bridge

port access vlan 2

combo enable fiber

\#

interface GigabitEthernet1/0/3

port link-mode bridge

port access vlan 3

combo enable fiber

\#

## 测试结果：

配置完成后，PC之间可以互访。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
