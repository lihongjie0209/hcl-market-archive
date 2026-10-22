# Dot1q终结支持PPPoE Server配置举例

## 需求：

Client和Switch相连，分别属于VLAN 10、VLAN
20，客户端需要使用拨号方式访问Internet。

## 实验步骤：

1、GigabitEthernet0/0.10口配置模糊的Dot1q终结，终结由Client传上来的VLAN
TAG；

2、Router作为网络中的PPPoE
server，需要在GigabitEthernet1/0/1.10上进行PPPoE相关参数的配置。

## 测试结果：

查看Server上拨入的PPPoE用户，可见两个终端都已经成功上线。

![](./Media//image1.png)


路由表上生成到两台Client的主机路由。

![](./Media//image2.png)


Client测试可以访问外网。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
