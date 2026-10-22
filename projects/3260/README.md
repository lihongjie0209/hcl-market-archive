# OSPF Stub区域配置举例（交换）

## 需求：

所有的交换机都运行OSPF，整个自治系统划分为3个区域。其中SWA和SWB作为ABR来转发区域之间的路由，SW
D作为ASBR引入了外部路由（静态路由）。要求将Area1配置为Stub区域，减少通告到此区域内的LSA数量，但不影响路由的可达性。。

##  实验步骤：

1.  配置各接口的IP地址；

2.  配置OSPF，建立OSPF邻居关系；

3.  配置Switch D引入静态路由；

4.  配置Area1为Stub区域；

5.  

## 测试结果：

引入静态路由后查看SWC的ospf路由表，可以看到路由表中存在AS外部的路由。

![](./Media//image1.png)


配置Area1为Stub区域，查看SWC的OSPF路由表，已经看不到AS外部的路由，取而代之的是一条缺省路由。

![](./Media//image2.png)


配置Area1为Totally Stub区域，查看Switch
C的OSPF路由表，可以看到路由表项进一步减少，只保留了一条通往区域外部的缺省路由

![](./Media//image3.png)


  

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
