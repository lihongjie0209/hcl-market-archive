# VRRP场景下DHCP配置举例

**标签：**

**DHCP**

**VRRP**

## 需求

VRRP场景下，链路或网络问题可能导致网关主备切换。在该情况下，备设备如果没有配置DHCP可能会导致后续接入的终端不能获取地址上网，因此主备设备都需要配置DHCP池，开启DHCP服务。

## 实验步骤：

以VRRP-1设备为例，配置VRRP：

\#

track 1 interface GigabitEthernet0/0

\#

interface Vlan-interface10

ip address 192.168.10.252 255.255.255.0

vrrp vrid 10 virtual-ip 192.168.10.254

vrrp vrid 10 priority 120

vrrp vrid 10 track 1 priority reduced 30

\#

interface Vlan-interface20

ip address 192.168.20.253 255.255.255.0

vrrp vrid 20 virtual-ip 192.168.20.254

\#

interface GigabitEthernet0/1

port link-mode bridge

port link-type trunk

port trunk permit vlan 1 10 20

combo enable copper

\#

配置DHCP：

\#

dhcp enable

\#

dhcp server ip-pool 1

gateway-list 192.168.10.254

network 192.168.10.0 mask 255.255.255.0

forbidden-ip 192.168.10.254

\#

dhcp server ip-pool 2

gateway-list 192.168.20.254

network 192.168.20.0 mask 255.255.255.0

forbidden-ip 192.168.20.254

\#

## 测试结果：

配置完成后，DHCP客户端可以从DHCP服务器获取IP地址及相关配置信息。该情况下，由于主备切换或主设备没有恢复正常，地址由备设备分配。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
