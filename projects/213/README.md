# CHAP单向认证配置举例

## 需求：

Router A和Router B之间用接口Serial2/0互连，要求设备Router
A用CHAP方式认证设备Router B。

## 实验步骤：

1.  配置Router A

-   配置接口的IP地址。

-   为Router B创建本地用户。

2.  配置Router B

-   配置接口的IP地址。

-   配置本地被Router A以CHAP方式认证时Router B发送的CHAP用户名和密码。

## 测试结果：

通过display interface
serial命令，查看接口Serial2/0的信息，发现接口的物理层和链路层的状态都是up状态，并且PPP的LCP和IPCP都是opened状态，说明链路的PPP协商已经成功，并且Router
A和Router B可以互相ping通对方。

![](./Media//image1.png)


![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
