# 二层动态聚合配置举例



## 需求：
1. Device A与Device B通过各自的二层以太网接口GigabitEthernet1/0/1 - GigabitEthernet1/0/2互相连接。
2. Device A和Device B分别配置二层动态聚合链路组，并实现设备间VLAN互通。



## 实验步骤：
1. 创建二层聚合接口1，配置该接口为动态聚合模式，将GigabitEthernet1/0/1、GigabitEthernet1/0/2加入到聚合组1中。
2. 配置聚合组1，放通VLAN。



## 测试结果：
![二层动态聚合状态](./Media/二层动态聚合状态.png) 



## 说明： 
1. 本实验使用的模拟器为S6850，设置内存为默认。
2. 本实验使用的交换机为默认。

