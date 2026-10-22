# 用户类白名单功能配置

**标签：**

**DHCP**

## 需求

Gateway作为DHCP服务器只为局域网中匹配硬件地址34c7-9acb-0305，硬件地址掩码为ffff-ffff-ffff的DHCP客户端动态分配网段为10.1.1.0/24的IP地址。

## 实验步骤：

配置DHCP服务器接口的IP地址。

\#

interface GigabitEthernet0/0

ip address 10.1.1.1 255.255.255.0

\#

创建DHCP用户类ss，设置匹配规则编号1，匹配硬件地址为34c7-9acb-0305，硬件地址掩码为ffff-ffff-ffff。

\#

dhcp class ss

if-match rule 1 hardware-address 34c7-9acb-0305 mask ffff-ffff-ffff

\#

创建DHCP地址池aa，配置可分配的地址范围为10.1.1.0/24，开启用户类白名单功能，配置白名单中包括的用户类为ss。

\#

dhcp enable

\#

dhcp server ip-pool 1

gateway-list 10.1.1.1

network 10.1.1.0 mask 255.255.255.0

dns-list 10.1.1.2

forbidden-ip 10.1.1.1

forbidden-ip 10.1.1.2

valid class ss

verify class

\#

## 测试结果：

配置完成后，匹配硬件地址34c7-9acb-0305，硬件地址掩码ffff-ffff-ffff的客户端可以从DHCP服务器申请到地址范围为10.1.1.0/24网段的IP地址。通过display
dhcp server ip-in-use命令可以查看DHCP服务器分配的IP地址。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
