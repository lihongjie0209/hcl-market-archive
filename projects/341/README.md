# N比1 VLAN映射配置举例

## 需求：

网络中从DEVICEA过来的不同vlan的业务流需要在DEVICEB上进行转化为特定某一vlan送给DEVICEC。

##  实验步骤：

1.  创建原始vlan和转换后的vlan

2.  在vlan上使能ARP detection功能

3.  在连接原始vlan的接口上使能dhcp snooping并配置N:1 vlan映射

4.  在下行口配置允许转换后vlan并配置dhcp snooping信任端口和arp信任端口

## 测试结果：

通过display vlan mapping查看devicec上的VLAN映射配置信息

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
