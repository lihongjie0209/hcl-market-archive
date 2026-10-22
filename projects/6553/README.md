# 基于报文协议类型的本地策略路由组网配置举例

## 需求：

Switch A分别与Switch B和Switch C直连（保证Switch B和Switch
C之间路由完全不可达）。通过策略路由控制Switch
A产生的报文：指定所有TCP报文的下一跳为1.1.2.2；其它报文仍然按照查找路由表的方式进行转发。

##  实验步骤：

1.  Switch A创建VLAN 10和VLAN
    20，配置接口Vlan-interface10和Vlan-interface20的IP地址；

2.  分别配置Switch B和Switch C上的vlan-interface 10和vlan-interface
    20的IP地址

3.  Switch A上定义访问控制列表ACL
    3101，用来匹配TCP报文，定义5号节点，指定所有TCP报文的下一跳为1.1.2.2；

4.  在Switch A上应用本地策略路由。

## 测试结果：

从Switch A可以ping通Switch B（1.1.2.2/24）和Switch C（1.1.3.2/24）：

![C:\\Users\\l25883\\AppData\\Local\\Temp\\企业微信截图_16602162178776.png](./Media//image1.png)


但是从Switch A通过Telnet方式仅能成功登录Switch B，无法登录Switch
C。由于Telnet使用的是TCP协议，ping使用的是ICMP协议，所以由以上结果可证明：Switch
A发出的TCP报文的下一跳为1.1.2.2，策略路由设置成功。

![C:\\Users\\l25883\\AppData\\Local\\Temp\\企业微信截图_16602162779410.png](./Media//image2.png)


![C:\\Users\\l25883\\AppData\\Local\\Temp\\企业微信截图_16602163205062.png](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
