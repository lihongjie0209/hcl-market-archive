# OSPF NSSA区域配置举例（交换）

## 需求：

所有的交换机都运行OSPF，整个自治系统划分为3个区域。其中SWA和SWB作为ABR来转发区域之间的路由。要求将Area1配置为NSSA区域，同时将Switch
C配置为ASBR引入外部路由（静态路由），且路由信息可正确的在AS内传播。。

##  实验步骤：

1.  配置各接口的IP地址；

2.  配置OSPF，建立OSPF邻居关系；

3.  配置Area1区域为NSSA区域；

4.  配置Switch C引入静态路由；

## 测试结果：

配置Area1区域为NSSA区域，并查看SWC的ospf路由表：

![](./Media//image1.png)


配置SWC引入静态路由，查看SWD的OSPF路由表，可以看到NSSA区域引入了一条AS外部路由

![](./Media//image2.png)


  

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
