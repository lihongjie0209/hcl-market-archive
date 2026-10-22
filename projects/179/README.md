# 在接口下指定为Client端分配的IP地址配置举例

## 需求：

Router A通过PPP协商，为Router B的接口Serial2/0分配IP地址。

要求Router A用接口下指定的IP地址为Router B分配IP地址。

## 实验步骤：

1.  配置Router A

-   配置接口Serial2/0为Router B的接口分配的IP地址。

\<RouterA\> system-view

\[RouterA\] interface serial 2/1/0

\[RouterA-Serial2/1/0\] remote address 200.1.1.10

\[RouterA-Serial2/1/0\] ip address 200.1.1.1 16

2.  配置Router B

-   配置接口Serial2/0通过协商获取IP地址。

\<RouterB\> system-view

\[RouterB\] interface serial 2/1/0

\[RouterB-Serial2/1/0\] ip address ppp-negotiate

## 测试结果：

配置完成后，查看设备Router
B的接口Serial2/1/0的概要信息，可见接口Serial2/1/0通过PPP协商获取的IP地址为200.1.1.10。

![](./Media//image1.png)


在Router B上可以Ping通Router A的Serial2/0接口。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
