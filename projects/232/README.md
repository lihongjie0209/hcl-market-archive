# 6to4中继典型配置举例

## 需求：

Router A为6to4路由器，其IPv6侧的网络使用6to4地址。Router
B作为6to4中继路由器，它和IPv6网络（2001::/16）相连。要求在Router
A和Router
B之间配置6to4隧道，使得6to4网络中的主机与IPv6网络中的主机互通。

## 实验步骤：

1.  配置IP地址，并且Router A和Router B之间路由可达。

2.  创建模式为6to4隧道的接口Tunnel0。

3.  配置到纯IPv6网络的缺省路由，指定路由的下一跳地址为6to4中继路由器的6to4地址

## 测试结果：

完成以上配置之后，Host A与Host B可以互相Ping通。

![](./Media//image1.png)


报文封装格式：外层为IPv4隧道地址，内层为IPv6地址。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
