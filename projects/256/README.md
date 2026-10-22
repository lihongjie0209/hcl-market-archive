# 配置MPLS L3VPN示例

## 需求：

1.  CE 1、CE 3属于VPN 1，CE 2、CE 4属于VPN 2；

2.  VPN 1使用的Route Target属性为111:1，VPN 2使用的Route
    Target属性为222:2。不同VPN用户之间不能互相访问；

3.  CE与PE之间配置EBGP交换VPN路由信息；

4.  PE与PE之间配置OSPF实现PE内部的互通、配置MP-IBGP交换VPN路由信息。

## 实验步骤：

1.  在MPLS骨干网上配置IGP协议，实现骨干网PE和P的互通

2.  在MPLS骨干网上配置MPLS基本能力和MPLS LDP，建立LDP LSP

3.  在PE设备上配置VPN实例，将CE接入PE

4.  在PE与CE之间建立EBGP对等体，引入VPN路由

5.  在PE之间建立MP-IBGP对等体

在配置中，MP-BGP使用环回口建立邻居，不能使用物理口地址建立邻居。该限制与LDP分配标签方式以及路由迭代方式相关，只有环回口地址32位地址才分配了LSP标签，才能迭代成功。

## 测试结果：

在PE设备上执行display ip routing-table
vpn-instance命令，可以看到去往对端CE的路由。

以PE 1上的VPN 1为例：

![](./Media//image1.png)


同一VPN的CE能够相互Ping通，不同VPN的CE不能相互Ping通。

例如：CE 1能够Ping通CE 3（10.3.1.1），但不能Ping通CE 4（10.4.1.1）。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
