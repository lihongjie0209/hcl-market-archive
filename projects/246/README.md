# BGP与BFD联动配置

## 需求：

在AS 200内使用OSPF作为IGP协议，实现AS内的互通。

Router A与Router C之间建立两条IBGP连接。当Router A与Router
C之间的两条路径均连通时，Router C与1.1.1.0/24之间的报文使用Router
A\<－\>Router B\<－\>Router C这条路径转发；当Router A\<－\>Router
B\<－\>Router
C这条路径发生故障时，BFD能够快速检测并通告BGP协议，使得Router
A\<－\>Router D\<－\>Router C这条路径能够迅速生效。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置OSPF，保证Router A和Router C之间路由可达

3.  配置BGP

4.  配置BFD联动BGP

## 测试结果：

下面以Router C为例，Router A和Router C类似，不再赘述。

显示Router C的BFD信息。

![](./Media//image1.png)


以上显示信息表明：Router A和Router
C之间已经建立了BFD连接，而且BFD协议运行正常。

在Router C上查看BGP邻居信息，可以看出Router A和Router
C之间建立两条BGP连接，且均处于Established状态。

![](./Media//image2.png)


在Router C上查看1.1.1.0/24的路由信息，可以看出Router C通过Router
A\<－\>Router B\<－\>Router C这条路径与1.1.1.0/24网段通信。

![](./Media//image3.png)


Router A和Router B之间的链路发生故障后，在Router
C上查看1.1.1.0/24的路由信息，可以看出Router C通过Router A\<－\>Router
D\<－\>Router C这条路径与1.1.1.0/24网段通信。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
