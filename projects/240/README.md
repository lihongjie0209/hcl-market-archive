# BGP快速重路由配置

## 需求：

Router A、Router B、Router C和Router
D通过BGP协议实现网络互连。要求链路B正常时，Router A和Router
D之间的流量通过链路B转发；链路B出现故障时，流量可以快速切换到链路A上。

## 实验步骤：

1.  配置各接口的IP地址

2.  在AS
    200内配置OSPF，发布接口地址所在网段的路由（包括Loopback接口），确保Router
    B、Router C和Router D之间路由可达

3.  配置BGP连接

4.  修改路由的首选值，使得Router A和Router D之间的流量优先通过链路B转发

5.  配置BGP快速重路由

## 测试结果：

在Router A上查看4.4.4.4/32路由，可以看到备份下一跳信息。

![](./Media//image1.png)


在Router D上查看1.1.1.1/32路由，可以看到备份下一跳信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
