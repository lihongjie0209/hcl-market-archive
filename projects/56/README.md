# 从ISP域下关联的PPP地址池中分配IP地址配置举例

## 需求：

Router A通过PPP协商，为Router B的接口Serial2/0分配IP地址。

要求Router A从接口下指定的PPP地址池中分配IP地址。

## 实验步骤：

1.  配置Router A

配置PPP地址池aaa，IP地址范围为200.1.1.10到200.1.1.20，PPP地址池所在的组为AAA。

\<RouterA\> system-view

\[RouterA\] ip pool aaa 200.1.1.10 200.1.1.20 group AAA

\[RouterA\] ppp ip-pool route 200.1.1.1 24

为Router B创建本地用户。

\[RouterA\] local-user userb class network

\[RouterA-luser-network-userb\] password simple 123456TESTplat&!

\[RouterA-luser-network-userb\] service-type ppp

\[RouterA-luser-network-userb\] quit

创建ISP域，并在ISP域下关联PPP地址池。

\[RouterA\] domain bbb

\[RouterA-isp-bbb\] authorization-attribute ip-pool aaa

\[RouterA-isp-bbb\] quit

配置接口Serial2/1/0在ISP域bbb中采用PAP方式认证Router B。

\[RouterA\] interface serial 2/1/0

\[RouterA-Serial2/1/0\] ppp authentication-mode pap domain bbb

\[RouterA-Serial2/1/0\] ip address 200.1.1.1 16

2.  配置Router B

配置本地被Router A以PAP方式认证时Router B发送的PAP用户名和密码。

\<RouterB\> system-view

\[RouterB\] interface serial 2/1/0

\[RouterB-Serial2/1/0\] ppp pap local-user userb password simple
123456TESTplat&!

配置接口Serial2/1/0通过协商获取IP地址。

\[RouterB-Serial2/1/0\] ip address ppp-negotiate

## 测试结果：

配置完成后，查看设备Router
B的接口Serial2/1/0的概要信息，可见接口Serial2/1/0通过PPP协商获取的IP地址为200.1.1.10。

![](./Media//image2.png)


在Router B上可以Ping通Router A的Serial2/0接口。

![](./Media//image3.png)


在Router A上可以看到PPP地址池中已分配一个地址。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
