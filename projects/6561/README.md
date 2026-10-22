# OSPF的DR选择配置举例

## 需求：

Switch A、Switch B、Switch C、Switch D在同一网段，运行OSPF协议后Switch
B为DR，Switch C为BDR；改变交换机接口的DR优先级使Switch A成为DR。

##  实验步骤：

1.  配置各接口的IP地址；

2.  分别在Switch A、Switch B、Switch C和Switch D上配置OSPF基本功能；

3.  在Switch A上通过display ospf peer verbose命令查看其邻居信息；

4.  配置Switch A接口的DR优先级为100。同时重启Switch A、Switch B、Switch
    C和Switch D上的OSPF进程，查看邻居信息。

## 测试结果：

采用设备默认接口的DR优先级，通过display ospf peer
verbose命令查看其邻居信息。以Switch A上为例，发现运行OSPF后Switch B为DR

![C:\\Users\\l25883\\Documents\\WXWork\\1688850877031255\\Cache\\Image\\2022-08\\企业微信截图_16595119544830.png](./Media//image1.png)


配置Switch A接口的DR优先级为100后，查看邻居信息，以Switch
D为例，发现网络中DR/BDR已经存在的情况下，接口上的路由器优先级的配置并不会立即生效。

![C:\\Users\\l25883\\AppData\\Local\\Temp\\企业微信截图_16595121671751.png](./Media//image2.png)


重启Switch A、Switch B、Switch C和Switch
D上的OSPF进程后查看邻居信息，发现Switch A成为DR设备。

![C:\\Users\\l25883\\Documents\\WXWork\\1688850877031255\\Cache\\Image\\2022-08\\企业微信截图_16595129713056.png](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
