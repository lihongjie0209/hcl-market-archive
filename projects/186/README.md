# DS-Lite隧道典型配置举例

## 需求：

运行IPv4协议的私网Private IPv4 network和公网IPv4
network通过IPv6网络相连。通过在B4设备（Router A）和AFTR（Router
B）之间建立DS-Lite隧道，并在AFTR连接IPv4
network接口上配置NAT，实现IPv4私网主机穿越IPv6网络访问IPv4公网。

## 实验步骤：

1.  配置IP地址，并且Router A和Router B之间路由可达。

2.  创建模式为IPv6隧道的接口Tunnel1。

3.  配置相关路由指向Tunnel口。

## 测试结果：

完成上述配置后，在Router A和Router B上分别执行display interface
tunnel命令，可以看出Tunnel接口处于up状态。

![](./Media//image1.png)


从IPv4 host A上可以ping通IPv4 host B。

![](./Media//image2.png)


报文封装格式：

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
