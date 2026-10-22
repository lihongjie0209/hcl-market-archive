# 接口上开启uRPF配置举例

## 需求：

客户路由器Router A与ISP路由器Router B直连，在Router
B的接口GigabitEthernet0/0上配置严格型uRPF检查，源地址能够匹配ACL
2000的报文在任何情况下都能通过检查。

在Router
A的接口GigabitEthernet0/0上配置严格型uRPF检查，同时允许匹配缺省路由。

## 实验步骤：

配置Router A

配置接口GigabitEthernet0/0。

\#

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ip address 1.1.1.1 255.255.255.0

ip urpf strict allow-default-route

\#

配置Router B

配置ACL 2000，允许10.1.1.0/24网段的流量通过uRPF检查。

\#

acl basic 2000

rule 0 permit source 10.1.1.0 0.0.0.255

\#

在接口GigabitEthernet1/0/1上配置严格型uRPF检查。

\#

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ip address 1.1.1.2 255.255.255.0

ip urpf strict acl 2000

\#

## 测试结果：

在完成上述配置后，在任意视图下执行display命令可以显示配置uRPF后的运行情况，通过查看显示信息验证配置的效果。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
