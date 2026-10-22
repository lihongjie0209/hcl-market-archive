# 配置IPv6 NTP对等体模式

**标签：**

**NTP**

## 需求

网络中存在时间服务器Device A。为了通过IPv6 NTP实现Device B与Device
A进行时间同步，要求：

在Device A上设置本地时钟作为参考时钟，层数为2；

配置Device A工作在对等体模式，指定Device B为被动对等体，即Device
A为主动对等体，Device B为被动对等体。

## 实验步骤：

1、配置各接口的IPv6地址

2、配置NTP

Device A配置

ntp-service enable

clock protocol ntp

ntp-service refclock-master 2

ntp-service ipv6 unicast-peer 1::2

Device B配置

ntp-service enable

clock protocol ntp

## 测试结果：

完成上述配置后，Device B选择Device A作为参考时钟，与Device
A进行时间同步。同步后查看Device B的状态。可以看出，Device B已经与Device
A同步，层数比Device A的层数大1，为3。

![](./Media//image1.png)


查看Device B的NTP服务的IPv6会话信息，可以看到Device B与Device
A建立了会话。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
