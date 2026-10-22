# BGP Add-Path组网配置举例

## 需求：

所有交换机运行BGP协议，Switch A与Switch B和Switch C建立EBGP连接，Switch
B、Switch C和Switch D之间建立IBGP连接，Route D与Route E建立IBGP连接。

Switch D作为路由反射器，Switch E为Switch D的客户机。

配置Add-Path功能，使Switch E通过Switch D学到Switch B和Switch
C转发的前缀相同下一跳不同的路由信息。

##  实验步骤：

1.  配置各接口的IP地址；

2.  配置BGP连接；

3.  在Switch A上配置发布本地路由；同时在Switch B和Switch
    C将下一跳的属性修改成自身的地址;

4.  配置Switch
    D使能Add-Path发送能力，配置Add-Path优选路由的最大条数为2，配置向对等体50.1.1.2发送Add-Path优选路由的最大条数为2;

5.  验证配置。

## 测试结果：

查看Switch E的BGP路由信息，可以看到从Switch
D学到的两条前缀相同下一跳不同的路由信息：

![C:\\Users\\l25883\\AppData\\Local\\Temp\\企业微信截图_16576259387575.png](./Media//image1.png)


 

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
