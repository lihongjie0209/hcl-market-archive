# BGP Fake AS

**标签：**

**BGP**

## 需求

进行系统移植时，例如，Router A原来位于AS 2，现在将它移植到AS
3里，网络管理员需要在Router A的所有EBGP对等体上修改Router
A的AS号。通过在Router
A上为EBGP对等体/对等体组配置一个虚拟的本地自治系统号2，可以将本地真实的AS号3隐藏起来。在EBGP对等体看来Router
A始终位于AS 2，不需要改变EBGP对等体上的配置。

注意：peer fake-as命令只适用于EBGP对等体和对等体组。

## 实验步骤：

1、配置各接口的IP地址

2、配置BGP基本功能

RTA处于AS 200，与RTB建立邻居时，使用AS 100。

\#

bgp 200

peer 1.1.1.2 as-number 300

peer 1.1.1.2 fake-as 100

peer 2.2.2.2 as-number 400

\#

address-family ipv4 unicast

peer 1.1.1.2 enable

peer 2.2.2.2 enable

\#

## 测试结果：

邻居建立后，RTB上可以看到RTA路由器处于AS 100，隐藏了实际的AS 200。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
