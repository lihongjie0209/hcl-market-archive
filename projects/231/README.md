# 6to4隧道典型配置举例

## 需求：

两个6to4网络通过网络边缘6to4 router（Router A和Router
B）与IPv4网络相连。在Router A和Router
B之间建立6to4隧道，实现6to4网络中的主机Host A和Host B之间的互通。

## 实验步骤：

1.  配置IP地址，并且Router A和Router B之间路由可达。

2.  创建模式为6to4隧道的接口Tunnel0。

3.  配置到目的地址下一跳为Tunnel接口的静态路由。

## 测试结果：

完成以上配置之后，Host A与Host B可以互相Ping通。

![](./Media//image1.png)


报文封装格式：外层为IPv4隧道地址，内层为IPv6地址。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
