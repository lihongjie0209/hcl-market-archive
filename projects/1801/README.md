# 动态路由中引入缺省路由配置举例

## 需求：

网络中SW1和SW2分别建立bgp和ospf，同时，设备SW1配置缺省路由并在两台设备的ospf和bgp中引入。

##  实验步骤：

1.  互联接口及环回口ip配置

2.  配置ospf、bgp、缺省路由

3.  在ospf及bgp中引入缺省路由

## 测试结果：

通过display bgp peer ipv4可以看到bgp邻居已经正常建立，

![](./Media//image1.png)


两台设备的ospf邻居状态可以通过display ospf
peer看到已经正常建立，此外lsdb中已经存在对端发过来的缺省路由

![](./Media//image2.png)


![](./Media//image3.png)


查看设备路由表状态发现缺省路由已经加表

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
