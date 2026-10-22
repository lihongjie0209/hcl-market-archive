# OSPF基本功能配置举例

## 需求：

所有的交换机都运行OSPF，并将整个自治系统划分为3个区域。其中SWA和SWB作为ABR来转发区域之间的路由。

##  实验步骤：

1.  互联接口ip配置

2.  配置ospf

## 测试结果：

通过display ospf peer verbose查看SWA的OSPF邻居，

![](./Media//image1.png)


查看Switch A的OSPF路由信息

![](./Media//image2.png)


查看Switch D的OSPF路由信息

![](./Media//image3.png)


SWD可以ping通SWC

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
