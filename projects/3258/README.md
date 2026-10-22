# OSPF发布聚合路由配置举例（交换）

## 需求：

SWA和SWB位于AS 200内，AS 200内使用OSPF作为IGP协议。SWC、SWD和SWE位于AS
100内，AS
100内使用OSPF作为IGP协议。SWB和SWC之间建立EBGP连接，配置BGP引入OSPF和直连路由，配置OSPF进程引入BGP路由。为了减小SWA的路由表规模，在SWB上配置路由聚合，只发布聚合后的路由10.0.0.0/8。。

##  实验步骤：

1.  配置各接口的IP地址；

2.  配置OSPF，建立OSPF邻居关系；

3.  配置BGP，引入OSPF和直连路由；

4.  SW B和SW C上配置OSPF引入BGP路由；

5.  在SWB上配置路由聚合，只发布聚合路由10.0.0.0/8。

## 测试结果：

SW B和SW C上配置OSPF引入BGP路由息，后查看SWA的路由表信息：

![](./Media//image1.png)


在SWB上配置路由聚合，只发布聚合路由10.0.0.0/8后查看SWA的路由表信息：

![](./Media//image2.png)


  

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
