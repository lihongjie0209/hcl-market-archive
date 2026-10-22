# BGP VPNV4路由反射器配置

## 需求：

所有路由器运行BGP协议，Router A、Router C都与Router B建立IBGP连接。

Router B作为路由反射器，Router A和Router C为Router B的客户机。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置BGP连接

3.  配置BGP反射器

对于多邻居的情况，可以使用对等体组简化配置。

\#

bgp 100

group rr internal

peer rr connect-interface LoopBack0

peer 1.1.1.1 group rr

peer 3.3.3.3 group rr

\#

address-family vpnv4

undo policy vpn-target

peer rr enable

peer rr reflect-client

\#

## 测试结果：

查看Router A的BGP路由表。

![](./Media//image1.png)


可以看出，Router A从Router B已经学到了40.1.1.0/24路由。

从路由器反射器学习到的路由，含Originator与Cluster list属性。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
