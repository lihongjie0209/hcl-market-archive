# DS-Lite B4端口块动态映射配置

## 需求：

B4设备为用户网络的网关或者运行DS-Lite客户端软件的用户主机，AFTR设备作为隧道端点设备和NAT网关负责执行隧道报文的封装、解封装以及对解封装后的IPv4地址进行转换。通过在B4和AFTR之间建立DS-Lite隧道，并在AFTR连接IPv4
network接口上配置NAT，为DS-Lite
host动态分配端口块，实现IPv4私网穿越IPv6网络访问IPv4公网。

## 实验步骤：

1、配置B4设备

2、配置AFTR设备

## 测试结果：

1、完成上述配置后，在AFTR上执行display interface
tunnel命令，可以看出Tunnel接口处于up状态

![](./Media//image1.png)


2、从Ipv4-Host-A上可以ping通公网的地址20.1.1.1。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
