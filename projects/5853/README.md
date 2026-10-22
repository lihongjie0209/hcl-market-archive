# IS-IS的DIS选择配置举例

## 需求：

SWA、SWB、SWC和SWD都运行IS-IS路由协议以实现互连，它们属于同一区域10，网络类型为广播网（以太网）。

SWA和SWB是Level-1-2交换机，SWC为Level-1交换机，SWD为Level-2交换机。要求通过改变接口的DIS优先级，将SWA配置为Level-1-2的DIS。。

##  实验步骤：

1.  互联接口ip配置

2.  配置ospf

3.  配置DIS优先级

## 测试结果：

通过display isis peer查看SWA的IS-IS邻居信息，

![](./Media//image1.png)


查看SWA的IS-IS接口信息，可以看到，在改变IS-IS接口的DIS优先级后，Switch
A立即成为Level-1-2的DR（DIS），且伪节点是0000.0000.0001.01。

![](./Media//image2.png)


查看SWC的IS-IS邻居和接口信息

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
