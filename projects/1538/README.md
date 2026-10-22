# RIPng基本功能配置

**标签：**

**RIPng**

## 需求

Router A、Router B和Router C相连并通过RIPng来学习网络中的IPv6路由信息。

在Router B上对接收的路由信息进行过滤，仅接收除2::/64之外的路由信息。

在Router B上对发布的路由信息进行过滤，仅发布4::/64路由信息。

## 实验步骤：

1、配置各接口的IPv6地址

2、使能RIPng功能

配置Router A。

\#

interface LoopBack0

ipv6 address 2::1/64

ripng 1 enable

\#

interface GigabitEthernet0/0

ipv6 address 1::1/64

ripng 1 enable

\#

配置Router B。

\#

interface GigabitEthernet0/0

ipv6 address 1::2/64

ripng 1 enable

\#

interface GigabitEthernet0/1

ipv6 address 3::1/64

ripng 1 enable

\#

配置Router C。

\#

interface LoopBack0

ipv6 address 4::1/64

ripng 1 enable

\#

interface LoopBack1

ipv6 address 5::1/64

ripng 1 enable

\#

interface GigabitEthernet0/0

ipv6 address 3::2/64

ripng 1 enable

\#

3、配置Router B对接收和发布的路由进行过滤

\#

ripng 1

filter-policy prefix-list bbb import

filter-policy prefix-list aaa export

\#

ipv6 prefix-list aaa index 10 permit 4:: 64

ipv6 prefix-list bbb index 10 deny 2:: 64

ipv6 prefix-list bbb index 20 permit :: 0 less-equal 128

\#

## 测试结果：

查看Router A和Router B的RIPng路由表。

![](./Media//image1.png)


![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
