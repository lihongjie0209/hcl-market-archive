# TFTP服务器典型配置举例

## 需求：

将PC与Device通过以太口直连，配置相应IP地址，保证设备之间互通。Device作为TFTP
Server。PC登录到TFTP服务器上实现文件的上传下载。

## 实验步骤：

实验步骤：

1、配置接口IP地址，保证网络可达；

2、开启Device的TFTP服务器功能。

## 测试结果：

登录Device设备，发现设备的UDP端口69已经开启，说明TFTP服务器功能已经启动。

\<Device\>display udp

Local Addr:port Foreign Addr:port Slot PCB

0.0.0.0:69 0.0.0.0:0 0 0xffffffffffffff9d

在PC上测试文件的下载与上传。

下载文件：

![](./Media//image1.png)


上传文件：

![](./Media//image2.png)


在Device上查看，已经收到startup.cfg文件。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
