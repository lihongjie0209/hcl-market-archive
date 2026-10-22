# LAC-Auto-Initiated模式L2TP隧道配置举例

## 需求：

PPP用户接入之前，在LAC和LNS之间采用LAC-Auto-Initiated模式建立L2TP隧道。PPP用户接入后，通过已经建立的L2TP隧道访问公司总部。

## 实验步骤：

1.  配置LAC。

2.  配置LNS

3.  配置Remote Host。

在Remote host上应将LAC设置为网关。

## 测试结果：

拨号连接成功后，在LNS端通过命令display ppp
access-user可查看在线用户的信息。

![](./Media//image1.png)


Remote host可以ping通LNS的私网地址192.168.0.1、10.1.0.2。

![](./Media//image2.png)


![](./Media//image3.png)


LNS也可以ping通Remote Host的地址（即LAC的私网地址网段）：

![](./Media//image4.png)


在LNS端，通过命令display l2tp tunnel可查看建立的L2TP隧道。

![](./Media//image5.png)


在LNS端，通过命令display l2tp session可查看建立的L2TP会话。

![](./Media//image6.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
