# DHCPv6中继基本组网典型配置

**标签：**

**DHCPv6**

## 需求

DHCPv6客户端所在网络地址为1::/64，DHCPv6服务器的地址为2::2/64。客户端和服务器不在同一个链路范围，需要通过DHCPv6中继转发报文。

DHCPv6
Relay同时作为1::/64网络的网关设备，通过RA消息中的M标志位和O标志位指定该网络中的主机通过DHCPv6获取IPv6地址和其他网络配置参数。

## 实验步骤：

配置接口GigabitEthernet0/0和GigabitEthernet0/1的IPv6地址。取消设备发布RA消息的抑制。配置被管理地址的配置标志位为1，即主机通过DHCPv6服务器获取IPv6地址。配置其他信息配置标志位为1，即主机通过DHCPv6服务器获取除IPv6地址以外的其他信息。配置接口GigabitEthernet0/1工作在DHCPv6中继模式，并指定DHCPv6服务器地址。

\#

interface GigabitEthernet0/0

ipv6 address 2::1/64

\#

interface GigabitEthernet0/1

ipv6 dhcp select relay

ipv6 dhcp relay server-address 2::2

ipv6 address 1::1/64

ipv6 nd autoconfig managed-address-flag

ipv6 nd autoconfig other-flag

undo ipv6 nd ra halt

\#

## 测试结果：

配置完成后，Client可以从DHCPv6服务器获取到IPv6地址。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
