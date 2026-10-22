# Vlan-interface实现VLAN间路由

## 需求：

设备上配置vlan-interface接口，实现VLAN间通信。

注：真机需要添加二层接口卡或者使用原生二层接口。

## 实验步骤：

Router配置：

\#

vlan 10

\#

vlan 20

\#

interface Vlan-interface10

ip address 192.168.10.254 255.255.255.0

\#

interface Vlan-interface20

ip address 192.168.20.254 255.255.255.0

\#

interface GigabitEthernet0/0

port link-mode bridge

port access vlan 10

combo enable copper

\#

interface GigabitEthernet0/1

port link-mode bridge

port access vlan 20

combo enable copper

\#

## 测试结果：

配置完成后，PC之间可以互访。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
