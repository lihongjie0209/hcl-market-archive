# IS-IS多实例进程基本功能配置举例

## 需求：

IPv4网络和IPv6的接口开销值不同，要求通过IS-IS多实例隔离IPv4和IPv6网络，避免使用传统IS-IS进程导致IPv6路由计算出错的问题。

##  实验步骤：

1.  互联接口ipv4和ipv6地址配置

2.  配置传统IPv4 IS-IS进程

3.  配置多实例IPv6 IS-IS进程

## 测试结果：

通过display isis route ipv4查看SWA的IPv4
IS-IS路由表，可以看到路由计算的结果正确。

![](./Media//image1.png)


查看SWB的IPv4 IS-IS路由表，可以看到路由计算的结果正确。

![](./Media//image2.png)


查看SWA的IPv6 IS-IS路由表，可以看到路由计算的结果正确

![](./Media//image3.png)


查看SWB的IPv6 IS-IS路由表，可以看到路由计算的结果正确

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
