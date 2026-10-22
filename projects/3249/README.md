# IS-IS基本功能配置举例

## 需求：

Switch A、Switch B、Switch C和Switch
D属于同一自治系统，要求它们之间通过IS-IS协议达到IP网络互连的目的。

Switch A和Switch B为Level-1交换机，Switch D为Level-2交换机，Switch
C作为Level-1-2交换机将两个区域相连。Switch A、Switch B和Switch
C的区域号为10，Switch D的区域号为20。

##  实验步骤：

1.  Switch A和Switch B为Level-1交换机，Switch D为Level-2交换机，Switch
    C作为Level-1-2交换机将两个区域相连；

2.  Switch A、Switch B和Switch C的区域号为10，Switch D的区域号为20

## 测试结果：

\# 显示各交换机的IS-IS LSDB信息，查看LSP是否完整。

![](./Media//image1.png)


![](./Media//image2.png)


![](./Media//image3.png)


![](./Media//image4.png)


\#
显示各交换机的IS-IS路由信息。Level-1交换机的路由表中应该有一条缺省路由，且下一跳为Level-1-2交换机，Level-2交换机的路由表中应该有所有Level-1和Level-2的路由。

![](./Media//image5.png)


![](./Media//image6.png)


![](./Media//image7.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
