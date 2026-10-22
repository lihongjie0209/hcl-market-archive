# DHCP中继基本组网配置举例

**标签：**

**DHCP**

**DHCP Relay**

## 需求

DHCP客户端所在网段为192.168.1.0/24，DHCP服务器的IP地址为192.168.2.2/24；

由于DHCP客户端和DHCP服务器不在同一网段，因此，需要在客户端所在网段设置DHCP中继设备，以便客户端可以从DHCP服务器申请到192.168.1.0/24网段的IP地址及相关配置信息；

DHCP中继通过GigabitEthernet0/1接口连接到DHCP客户端所在的网络，GigabitEthernet0/1接口的IP地址为192.168.1.1/24，GigabitEthernet0/0接口的IP地址为192.168.2.1/24。

## 实验步骤：

配置各接口的IP地址。

\#

interface GigabitEthernet0/0

ip address 192.168.2.1 255.255.255.0

\#

interface GigabitEthernet0/1

ip address 192.168.1.1 255.255.255.0

\#

开启DHCP服务。

\#

dhcp enable

\#

dhcp server ip-pool 1

gateway-list 192.168.1.1

network 192.168.1.0 mask 255.255.255.0

\#

配置GigabitEthernet0/1接口工作在DHCP中继模式，并指定DHCP服务器的地址。

\#

interface GigabitEthernet0/1

dhcp select relay

dhcp relay server-address 192.168.2.2

\#

## 测试结果：

配置完成后，DHCP客户端可以通过DHCP中继从DHCP服务器获取IP地址及相关配置信息。通过display
dhcp relay
statistics命令可以显示DHCP中继转发的DHCP报文统计信息；如果在DHCP中继上通过dhcp
relay client-information
record命令开启了DHCP中继的用户地址表项记录功能，则可以通过display dhcp
relay client-information命令可以显示通过DHCP中继获取IP地址的客户端信息。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
