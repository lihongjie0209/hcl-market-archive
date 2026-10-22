# BGP基本配置

## 需求：

所有路由器均运行BGP协议。要求Router A和Router B之间建立EBGP连接，Router
B和Router C之间建立IBGP连接，使得Router C能够访问Router
A直连的8.1.1.0/24网段。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置BGP连接

## 测试结果：

查看Router B的BGP对等体的连接状态。

![](./Media//image2.png)


可以看出，Router B与Router C、Router B与Router A之间的BGP连接均已建立。

查看Router A的BGP路由表。

![](./Media//image3.png)


使用Ping进行验证。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
