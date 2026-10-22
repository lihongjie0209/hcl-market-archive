# IPv6基本组网配置举例

## 需求：

Host、Switch 1和Switch
2之间通过以太网端口相连，将以太网端口分别加入相应的VLAN里，在VLAN接口上配置IPv6地址，验证它们之间的互通性。

· Switch 2有可以到Host的路由。

·
在Host上配置接口地址为自动获取，根据IPv6邻居发现协议自动配置IPv6地址，有可以到Switch
B的路由。

##  实验步骤：

1.  在Switch
    1 手工指定VLAN接口1和2的全球单播地址，并在连接Host的vlan接口1上配置允许其发布RA消息；

2.  在Switch
    2手工指定vlan接口2的全球单播地址，并配置IPv6静态路由，该路由的目的地址为2001::/64，下一跳地址为3001::1

3.  在Host上配置根据IPv6邻居发现协议自动配置IPv6地址，并配置到3001：：网段的静态路由，下一跳为2001：：1。

## 测试结果：

显示Switch 1的接口信息，可以看到各接口配置的IPv6全球单播地址：

![](./Media//image1.png)


![](./Media//image2.png)


 显示Switch 2的接口信息，可以看到接口配置的IPv6全球单播地址：

![](./Media//image3.png)


在Host上查看接口下自动学习的IPv6全球单播地址：

![](./Media//image4.png)


在Host上使用Ping测试和Switch 1及Switch 2的互通性：

![](./Media//image5.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
