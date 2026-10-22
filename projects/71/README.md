# IPv6 BGP基本配置

## 需求：

所有路由器均运行IPv6 BGP协议。Router A位于AS 65008；Router B和Router
C位于AS 65009。要求Router A和Router B之间建立EBGP连接，Router B和Router
C之间建立IBGP连接，使得Router C能够访问Router A直连的50::/64网段。

## 实验步骤：

1.  配置各接口的IPv6地址及Loopback接口的IPv4地址

2.  配置BGP连接

## 测试结果：

在Router B上查看IPv6 BGP对等体的信息。可以看出，Router A和Router
B之间建立了EBGP连接，Router B和Router C之间建立了IBGP连接。

![](./Media//image2.png)


在Router A上查看IPv6 BGP路由表信息。可以看出，Router A学习到了AS
65009内的路由信息。

![](./Media//image3.png)


在Router C上查看IPv6 BGP路由表信息。可以看出，Router
C学习到了到达50::/64网段的路由。

![](./Media//image4.png)


在Router C上可以ping通50::/64网段内的主机。

![](./Media//image5.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
