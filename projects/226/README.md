# NAS-Initiated模式L2TP隧道配置举例

## 需求：

PPP用户通过LAC接入LNS，在LAC和LNS之间建立L2TP隧道，以便用户通过该L2TP隧道访问公司总部。

## 实验步骤：

1.  配置LAC。

2.  配置LNS。

3、Host拨号接入LAC。

在Remote
host上配置PPPoE拨号连接，在拨号网络窗口中输入用户名vpdnuser和密码123456TESTplat&!进行拨号。

## 测试结果：

拨号连接成功后，在LNS端通过命令display ppp
access-user可查看在线用户的信息。

![](./Media//image1.png)


拨号连接成功后，Remote
host获取到IP地址192.168.1.10，并可以ping通LNS的私网地址192.168.1.1、10.0.0.2。

![](./Media//image2.png)


![](./Media//image3.png)


在LNS端，通过命令display l2tp tunnel可查看建立的L2TP隧道。

![](./Media//image4.png)


在LNS端，通过命令display l2tp session可查看建立的L2TP会话。

![](./Media//image5.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
