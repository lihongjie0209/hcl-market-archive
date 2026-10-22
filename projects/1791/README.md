# GRE结合VRRP部署

**标签：**

**GRE**

**VRRP**

## 需求

GRE出口含两台设备，为了可靠性，可以使用VRRP结合GRE来部署。

## 实验步骤：

1、配置各接口的IP地址与路由

2、配置VRRP

VRRP-1设备

\#

track 1 interface GigabitEthernet0/0

\#

interface GigabitEthernet0/1

ip address 10.1.1.1 255.255.255.0

vrrp vrid 1 virtual-ip 10.1.1.111

vrrp vrid 1 priority 110

vrrp vrid 1 track 1 priority reduced 30

\#

VRRP-2设备

\#

interface GigabitEthernet0/1

ip address 10.1.1.2 255.255.255.0

vrrp vrid 1 virtual-ip 10.1.1.111

\#

3、配置GRE

VRRP-1设备

\#

interface Tunnel1 mode gre

ip address 13.1.1.1 255.255.255.0

source 10.1.1.111

destination 1.1.1.2

\#

ip route-static 192.168.0.0 24 Tunnel1

\#

VRRP-2设备

\#

interface Tunnel1 mode gre

ip address 13.1.1.2 255.255.255.0

source 10.1.1.111

destination 1.1.1.2

\#

ip route-static 192.168.0.0 24 Tunnel1

\#

## 测试结果：

配置完成后，两端内网可以通信，并且可以通过VRRP设备实现GRE的备份。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
