# VXLAN over GRE

**标签：**

**VXLAN**

## 需求

中间网络只放通GRE，对于原始VLXAN可以采用VXLAN over GRE的配置。

## 实验步骤：

1、配置各接口的IP地址与路由

2、VXLAN over GRE配置，以VTEP-1为例

\#

sysname VTEP-1

\#

l2vpn enable

\#

vsi vpna

vxlan 10

tunnel 1

\#

interface GigabitEthernet0/0

ip address 1.1.1.1 255.255.255.0

\#

interface Tunnel0 mode gre

ip address 10.1.1.1 255.255.255.0

source 1.1.1.1

destination 2.1.1.1

\#

interface Tunnel1 mode vxlan

source 10.1.1.1

destination 10.1.1.2

\#

可以看到，只需要把vxlan隧道的端点改为Gre的IP即可。

## 测试结果：

VM-1访问VM-2，封装的报文类型：

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
