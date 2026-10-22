# MSTP典型配置举例

## 需求：

网络中所有设备都属于同一个MST域。Device A和Device B为汇聚层设备，Device
C和Device
D为接入层设备。通过配置MSTP，使不同VLAN的报文按照不同的MSTI转发。

##  实验步骤：

1.  配置vlan和端口

2.  配置MST域中参数，包括域名、修订级别、vlan映射

## 测试结果：

通过使用display stp
brief命令可以查看各设备上生成树的简要信息，比如deviceA上生成树信息

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
