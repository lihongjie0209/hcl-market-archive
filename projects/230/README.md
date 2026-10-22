# GRE over IPv6隧道配置举例

## 需求：

运行IPv4协议的两个子网Group 1和Group 2通过IPv6网络相连。

通过在Router A和Router B之间建立GRE over
IPv6隧道，实现两个子网穿越IPv6网络互联。

## 实验步骤：

1.  配置IP\\IPv6地址，并且Router A和Router B之间路由可达。

2.  创建Gre口，配置静态路由指向tunnel口。

## 测试结果：

查看Router A的Tunnel接口状态。

![](./Media//image1.png)


查看Router B的Tunnel接口状态。

![](./Media//image2.png)


从Router B可以Ping通Router A内网口的地址。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
