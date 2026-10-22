# OSPF NSR配置举例（交换）

## 需求：

Switch S、Switch A、Switch
B属于同一OSPF区域，通过OSPF协议实现网络互连。要求对Switch
S进行主备倒换时，Switch A和Switch B到Switch S的邻居没有中断，Switch
A到Switch B的流量没有中断。

##  实验步骤：

1.  配置各路由器接口的IP地址和OSPF协议，配置各交换机之间采用OSPF协议进行互连，确保Switch
    S、Switch A和Switch
    B之间能够在网络层互通，并且各交换机之间能够借助OSPF协议实现动态路由更新；

2.  配置OSPF NSR；

## 测试结果：

#Switch S进行主备倒换：

![](./Media//image1.png)


查看Switch A上OSPF协议的邻居和路由。

![](./Media//image2.png)


查看Switch B上OSPF协议的邻居和路由。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
