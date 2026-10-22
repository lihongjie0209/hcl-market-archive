# BGP重路由配置（交换）

## 需求：

Switch A、Switch B、Switch C 和Switch D 通过BGP
协议实现网络互连。要求链路B 正常时，Switch A 和Switch D
之间的流量通过链路B 转发；链路B 出现故障时，流量可以快速切换到链路A 上。

##  实验步骤：

(1)  配置各接口的IP 地址

\(2\) 在 AS 200 内配置OSPF，发布接口地址所在网段的路由（包括Loopback
接口），确保SwitchB、Switch C 和Switch D 之间路由可达。

\(3\) 配置 BGP 连接


\(4\) 修改路由的首选值，使得Switch A 和Switch D 之间的流量优先通过链路B
转发


\(5\) 配置 BGP 快速重路由



## 测试结果：

\# 在Switch A 上查看4.4.4.4/32
路由，可以看到备份下一跳信息。![](./Media//image1.png)


![](./Media//image2.png)


\# 在Switch D 上查看1.1.1.1/32
路由，可以看到备份下一跳信息。![](./Media//image3.png)


![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
