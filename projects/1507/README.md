# 静态绑定地址配置举例

**标签：**

**DHCP**

## 需求

路由器Gateway做为DHCP
Server，PC-1、PC-2获取的地址需要固定。这里采用静态绑定的方式对其分配地址。

## 实验步骤：

1、配置接口的IP地址

\#

interface GigabitEthernet0/0

ip address 10.1.1.1 255.0.0.0

\#

2、配置DHCP服务，并对PC-1与PC-2分别静态绑定MAC，client-identifier 。

\#

dhcp enable

\#

dhcp server ip-pool 1

gateway-list 10.1.1.1

network 10.1.1.0 mask 255.255.255.0

dns-list 10.1.1.2

forbidden-ip 10.1.1.1

forbidden-ip 10.1.1.2

static-bind ip-address 10.1.1.3 mask 255.0.0.0 hardware-address
34c7-9acb-0305

static-bind ip-address 10.1.1.4 mask 255.0.0.0 client-identifier
0033-3463-372e-3963-6532-2e30-3430-352d-4745-302f-30

\#

## 测试结果：

配置完成后，各个PC可以从DHCP服务器申请到IP地址，并获取相关网络配置参数。通过display
dhcp server ip-in-use命令可以查看DHCP服务器为客户端分配的IP地址。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
