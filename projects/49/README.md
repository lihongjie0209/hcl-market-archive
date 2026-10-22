# DHCP Relay+DRNI组网配置举例

## 需求：

DRNI组网中，DR设备使能DHCP Relay，Device D设备作为dhcp client，Device
C设备作为dhcp server，client从server获取地址。

##  实验步骤：

1.  将Device A和Device B配置为一组DRNI，上、下行均配置为DR组，与Device
    C和Device D互联；

2.  在Device C上开启DHCP服务，配置DHCP
    Server并创建地址池，用来为客户端分配IP地址；

3.  在Device A、Device B上开启DHCP服务，配置DHCP Relay；

4.  在Device D上配置通过DHCP动态获取地址。

## 测试结果：

查看的DRNI系统状态，可以看到DeviceA与DeviceB之间DRNI系统状态，DRNI正常建立。以DeviceA为例：

![](./Media//image1.png)


![](./Media//image2.png)


![](./Media//image3.png)


查看Device C DHCP服务器为客户端分配的IPv4地址

![](./Media//image4.png)


  查看Device A DHCP中继的用户地址表项信息

![](./Media//image5.png)


  查看Device D申请到的IP地址

![](./Media//image6.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
