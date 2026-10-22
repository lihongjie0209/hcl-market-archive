# BGP路由反射器配置

## 需求：

所有路由器运行BGP协议，Router A与Router B建立EBGP连接，Router C与Router
B和Router D之间建立IBGP连接。

Router C作为路由反射器，Router B和Router D为Router C的客户机。

Router D能够通过Router C学到路由20.0.0.0/8。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置BGP连接

3.  配置BGP反射器

\[RouterC\] bgp 200

\[RouterC-bgp-default\] address-family ipv4 unicast

\[RouterC-bgp-default-ipv4\] peer 193.1.1.2 reflect-client

\[RouterC-bgp-default-ipv4\] peer 194.1.1.2 reflect-client

\[RouterC-bgp-default-ipv4\] quit

\[RouterC-bgp-default\] quit

## 测试结果：

查看Router B的BGP路由表。

![](./Media//image1.png)


查看Router D的BGP路由表。

![](./Media//image2.png)


可以看出，Router D从Router C已经学到了20.0.0.0/8路由。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
