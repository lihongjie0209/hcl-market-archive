# 模糊的Dot1q终结配置举例

## 需求：

Host A、Host B、Host C和Switch A相连，Server group和Switch B相连。Host
A、Host B、Host C分别属于VLAN 11、VLAN 12、VLAN 13；这些Host需要与Server
group互相通信。

## 实验步骤：

1.  Host A、Host B、Host C的配置

将Host A的IP地址指定为1.1.1.1/24，Host B的IP地址为1.1.1.2/24，Host
C的IP地址为1.1.1.3/24，网关地址均指定为1.1.1.11/24。

2.  L2 Switch A的配置

创建VLAN，将接口添加进VLAN。

3.  Device的配置

创建以太网子接口GigabitEthernet1/0/1.10，为其配置IP地址，开启Dot1q终结功能，指定终结最外层VLAN
ID在范围11～13内的报文，并允许该子接口发送广播、组播报文。

4.  L2 Switch B的配置

L2 Switch B采用出厂配置即可。

5.  Server group的配置

将Server
group里所有设备的IP地址配置在1.1.2.0/24网段，网关地址指定为1.1.2.11/24即可。

Devie的配置：

\#

interface GigabitEthernet0/0.10

ip address 1.1.1.11 255.255.255.0

vlan-type dot1q vid 11 to 13

vlan-termination broadcast enable

\#

## 测试结果：

配置完成后， Host A、Host B、Host C可以与Server group相互ping通。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
