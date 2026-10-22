# MPLS L3VPN配置举例

## 需求：

CE 1、CE 3属于VPN 1，CE 2、CE 4属于VPN 2；VPN 1使用的Route
Target属性为111:1，VPN 2使用的Route
Target属性为222:2。不同VPN用户之间不能互相访问。

##  实验步骤：

1.  在交换机上配置路由协议，使得各交换机的接口IP地址（包括Loopback接口IP地址）之间路由可达；

2.  在MPLS骨干网上配置MPLS基本能力和MPLS LDP，建立LDP LSP；

3.  在PE设备上配置VPN实例，将CE接入PE；

4.  在PE与CE之间建立EBGP对等体，引入VPN路由;

5.  在PE之间建立MP-IBGP对等体。

## 测试结果：

在PE设备上执行display ip routing-table
vpn-instance命令，可以看到去往对端CE的路由。以PE 1上的VPN 1为例：

![](./Media//image1.png)


同一VPN的CE能够相互Ping通，不同VPN的CE不能相互Ping通。

例如：CE 1能够Ping通CE 3（10.3.1.1），但不能Ping通CE 4（10.4.1.1）

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
