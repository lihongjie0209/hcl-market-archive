# BGP与IGP交互配置

## 需求：

公司A的所有设备在AS 65008内，公司B的所有设备在AS 65009内，AS 65008和AS
65009通过设备Router A和Router B相连。

现要求实现Router A能够访问AS 65009内的网段9.1.2.0/24，Router C能够访问AS
65008内的网段8.1.1.0/24。

## 实验步骤：

1.  配置各接口的IP地址

2.  RTC与RTC配置OSPF邻居

3.  RTA与RTB配置EBGP连接

4.  在RTB上BGP引入OSPF路由

## 测试结果：

查看Router B的BGP对等体的连接状态。

![](./Media//image1.png)


查看Router B的OSPF路由。

![](./Media//image2.png)


配置BGP引入OSPF路由。

![](./Media//image3.png)


Router A查看学习到的BGP路由。

![](./Media//image4.png)


使用Ping进行验证。

![](./Media//image5.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
