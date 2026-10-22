# OSPF与BFD联动配置举例（交换）

## 需求：

SWA、SWB和SWC上运行OSPF，网络层相互可达。当SWA和SWB通过L2
Switch通信的链路出现故障时BFD能够快速感知通告OSPF协议，并且切换到SWC进行通信。。

##  实验步骤：

1.  配置各接口的IP地址；

2.  配置OSPF，建立OSPF邻居关系；

3.  配置BFD功能。

## 测试结果：

查看Switch A的BFD信息：

![](./Media//image1.png)


查看在Switch A上查看120.1.1.1/32的路由信息，可以看出Switch A和Switch
B是通过L2 Switch进行通信的。

![](./Media//image2.png)


 当SWA和SWB通过L2 Switch通信的链路出现故障时：

\# 在SWA上查看120.1.1.1/32的路由信息，可以看出SWA和SW
B已经切换到SWC进行通信。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
