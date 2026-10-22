# L2TP隧道交换配置举例

## 需求：

在LAC和LTS、LTS和LNS之间分别建立L2TP隧道，PPP用户通过多跳L2TP隧道访问公司总部。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置静态路由或动态路由，LAC与LTS、LNS网络互通

3.  配置LAC、LTS与LNS

4.  在Remote host上配置PPPoE拨号

## 测试结果：

1.  LNS端

拨号连接成功后，在LNS端通过命令display ppp
access-user可查看在线用户的信息。

![](./Media//image1.png)


拨号连接成功后，Remote host获取到IP地址192.168.1.10。

在LNS端，通过命令display l2tp tunnel可查看建立的L2TP隧道。

![](./Media//image2.png)


在LNS端，通过命令display l2tp session可查看建立的L2TP会话。

![](./Media//image3.png)


2.  LTS设备

在LTS设备上查看建立的L2TP隧道。

![](./Media//image4.png)


在LTS设备上查看建立的L2TP会话。

![](./Media//image5.png)


3.  LAC端

在LAC端查看建立的L2TP隧道。

![](./Media//image6.png)


在LAC端查看建立的L2TP会话。

![](./Media//image7.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
