# 二层动态聚合组网配置举例

## 需求：

Device A与Device B通过各自的二层以太网接口相互连接。在Device A和Device
B上分别配置二层动态链路聚合组，并实现设备间VLAN 10互通。

##  实验步骤：

1.  在Device C与Device D上创建VLAN
    10，并将GigabitEthernet1/0/1加入到该VLAN中；

2.  在Device A与Device B上创建VLAN
    10，并将GigabitEthernet1/0/5加入到该VLAN中；

3.  创建二层聚合接口，并配置该接口为动态聚合模式，将对应端口GigabitEthernet1/0/1和GigabitEthernet1/0/3加入到聚合组6中；

4.  配置二层聚合接口6为Trunk端口，并允许VLAN 10通过。

## 测试结果：

查看设备上所有聚合组的详细信息。以DeviceA为例，如下信息表明，聚合组6为负载分担类型的二层动态聚合组，包含有两个选中端口：

![C:\\Users\\l25883\\AppData\\Local\\Temp\\企业微信截图_165875166270.png](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
