# ISATAP隧道典型配置举例

## 需求：

IPv6网络和IPv4网络通过ISATAP路由器相连，在IPv4网络侧分布着一些IPv6主机。要求将IPv4网络中的IPv6主机通过ISATAP隧道接入到IPv6网络。

## 实验步骤：

1.  配置IP地址，并且Router A和Router B之间路由可达。

2.  创建模式为ISATAP隧道的接口Tunnel0。

3.  在Windows上，创建ISATAP接口。

## 测试结果：

在IPv6主机上配置一条到边界路由器隧道的路由。

C:\\\>netsh interface ipv6 set route 2001::/64 5 3001::1

PC CMD通过Ipconfig命令查看，Host已经获取到IPv6地址：

![](./Media//image1.png)


Ping IPv6网段可以通：

![](./Media//image2.png)


报文封装格式：外层为IPv4隧道地址，内层为IPv6地址。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
