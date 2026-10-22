# 普通代理ARP基本组组网配置举例

## 需求：

Host A和Host B配置为同一网段的主机（Host
A的IP地址是192.168.10.100/16，Host
B的IP地址是192.168.20.200/16），但却被设备SwitchA分在两个不同的子网（Host
A属于VLAN 10，Host B属于VLAN 20）。

Host A和Host
B没有配置缺省网关，要求在设备Switch上开启代理ARP功能，使处在两个子网的Host
A和Host B能互通。

##  实验步骤：

1.  配置各接口的IP地址；

2.  在Switch上的interface vlan-interface 10开启普通代理ARP功能；

3.  在Switch上的interface vlan-interface 20开启普通代理ARP功能；

## 测试结果：

未在Switch上对应的vlan虚接口下配置普通代理ARP功能时，Host A和Host
B无法互访，也学不到彼此的ARP表项，以Host A为例：

![C:\\Users\\l25883\\Documents\\WXWork\\1688850877031255\\Cache\\Image\\2022-07\\企业微信截图_16584036692968.png](./Media//image1.png)


在Switch上对应的vlan虚接口下配置普通代理ARP功能后，Host A和Host
B可以互相ping通，以Host A为例：

![C:\\Users\\l25883\\Documents\\WXWork\\1688850877031255\\Cache\\Image\\2022-07\\企业微信截图_16584033683918.png](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
