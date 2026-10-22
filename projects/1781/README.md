# 全局开启DHCP Snooping配置举例

## 需求：

Switch
1通过以太网端口GigE1/0/1连接到合法DHCP服务器，通过以太网端口GigE1/0/2连接到非法DHCP服务器，通过GigE1/0/3连接到DHCP客户端。要求：

-   法DHCP服务器相连的端口可以转发DHCP服务器的响应报文，而其他端口不转发DHCP服务器的响应报文。

-   记录DHCP-REQUEST报文和信任端口收到的DHCP-ACK报文中DHCP客户端IP地址及MAC地址的绑定信息。

##  实验步骤：

1.  在Switch 2开启dhcp服务，配置dhcp server，分配10.1.1.0/24网段地址；

2.  在Switch 3开启dhcp服务，配置dhcp server，分配10.10.1.0/24网段地址

3.  在Switch 1开启DHCP
    Snooping，配置1/0/1口为信任端口，在1/0/2口开启DHCP
    Snooping表项功能；

4.  在Client上配置通过DHCP动态获取地址。

## 测试结果：

查看DHCP Server，可以看到成功分配出10.1.1.0/24网段的地址：

![](./Media//image1.png)


查看DHCP Snooping表项，可以看到DHCP客户端IP地址及MAC地址的绑定信息：

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
