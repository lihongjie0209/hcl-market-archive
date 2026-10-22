# DHCP Relay多Server配置示例

**标签：**

**DHCP**

**DHCP Relay**

## 需求

为了提高可靠性，可以在一个网络中设置多个DHCP服务器。DHCP中继上配置多个DHCP服务器后，DHCP中继会将客户端发来的DHCP报文转发给所有的服务器。

## 实验步骤：

设备参考配置

\#

dhcp enable

dhcp relay client-information record

\#

interface GigabitEthernet0/0

ip address 192.168.3.2 255.255.255.0

\#

interface GigabitEthernet0/1

ip address 192.168.4.2 255.255.255.0

\#

interface GigabitEthernet0/2

ip address 192.168.1.1 255.255.255.0

ip address 192.168.2.1 255.255.255.0 sub

dhcp select relay

dhcp relay server-address 192.168.3.1

dhcp relay server-address 192.168.4.1

\#

## 测试结果：

配置完成后，DHCP客户端发的请求报文会同时发到两个服务器，获取的IP一般是先响应的地址。

配置的第二个服务器收的的DHCP请求报文：

\<Server-2\>debugging dhcp server packet

\<Server-2\>t d

The current terminal is enabled to display debugging logs.

\<Server-2\>t m

The current terminal is enabled to display logs.

\<Server-2\>\*Jul 12 08:44:29:495 2022 Server-2 DHCPS/7/PACKET:

From 192.168.4.2 port 67, interface GigabitEthernet0/0

Message type: REQUEST (1)

Hardware type: 1, Hardware address length: 6

Hops: 1, Transaction ID: 2349676777

Seconds: 0, Broadcast flag: 1

Client IP address: 0.0.0.0 Your IP address: 0.0.0.0

Server IP address: 0.0.0.0 Relay agent IP address: 192.168.1.1

Client hardware address: 7873-29f2-0506

Server host name: not configured

Boot file name: not configured

DHCP message type: DHCPDISCOVER (1)

\*Jul 12 08:44:29:497 2022 Server-2 DHCPS/7/PACKET:

From 192.168.4.2 port 67, interface GigabitEthernet0/0

Message type: REQUEST (1)

Hardware type: 1, Hardware address length: 6

Hops: 1, Transaction ID: 2349676777

Seconds: 0, Broadcast flag: 1

Client IP address: 0.0.0.0 Your IP address: 0.0.0.0

Server IP address: 0.0.0.0 Relay agent IP address: 192.168.1.1

Client hardware address: 7873-29f2-0506

Server host name: not configured

Boot file name: not configured

DHCP message type: DHCPREQUEST (3)

实际地址由Server-1分配：

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
