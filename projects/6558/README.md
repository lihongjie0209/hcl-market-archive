# BGP团体属性组网配置举例

## 需求：

Switch B分别与Switch A、Switch C之间建立EBGP连接。通过在Switch
A上配置NO_EXPORT团体属性，使得AS 10发布到AS 20中的路由，不会再被AS
20发布到其他AS。

##  实验步骤：

1.  配置各接口的IP地址；

2.  配置EBGP；

3.  配置BGP团体属性；

4.  验证配置。

## 测试结果：

未配置NO_EXPORT团体属性前，Switch
B能够把到达目的地址9.1.1.0/24的路由可以通过BGP发布出去，Switch C从Switch
B那里学到了目的地址为9.1.1.0/24的路由：

![C:\\Users\\l25883\\Documents\\WXWork\\1688850877031255\\Cache\\Image\\2022-07\\企业微信截图_16576044554815.png](./Media//image1.png)


在SwitchA上配置路由策略并应用后，在Switch
B的BGP路由表中可以看到配置的团体属性，Switch
B不会通过BGP将到达目的地址9.1.1.0/24的路由发布出去：

![C:\\Users\\l25883\\Documents\\WXWork\\1688850877031255\\Cache\\Image\\2022-07\\企业微信截图_16576052539578.png](./Media//image2.png)


![C:\\Users\\l25883\\Documents\\WXWork\\1688850877031255\\Cache\\Image\\2022-07\\企业微信截图_16576052722369.png](./Media//image3.png)


![](./Media//image4.png)


![](./Media//image5.png)


查看Device C DHCP服务器为客户端分配的IPv4地址

![](./Media//image6.png)


  查看Device A DHCP中继的用户地址表项信息

![](./Media//image7.png)


  查看Device D申请到的IP地址

![](./Media//image8.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
