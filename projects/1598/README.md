# SNTP基本组网配置举例

**标签：**

**SNTP**

## 需求

Device B对时间精度要求不高。为了实现Device B与Device A的时间同步，要求：

在Device A上设置本地时钟作为参考时钟，层数为2；

Device B工作在SNTP客户端模式，指定Device A为NTP服务器。

Device B要求对NTP服务器进行验证，以保证时间同步的安全性。

## 实验步骤：

1、配置各接口的IP地址

2、配置NTP\\SNTP

配置Device A

\[DeviceA\] ntp-service enable

\[DeviceA\] clock protocol ntp

\[DeviceA\] ntp-service refclock-master 2

\[DeviceA\] ntp-service authentication enable

\[DeviceA\] ntp-service authentication-keyid 10 authentication-mode md5
simple aNiceKey

\[DeviceA\] ntp-service reliable authentication-keyid 10

配置Device B

\[DeviceB\] sntp enable

\[DeviceB\] clock protocol ntp

\[DeviceB\] sntp authentication enable

\[DeviceB\] sntp authentication-keyid 10 authentication-mode md5 simple
aNiceKey

\[DeviceB\] sntp reliable authentication-keyid 10

\[DeviceB\] sntp unicast-server 1.0.1.11 authentication-keyid 10

## 测试结果：

查看Device B的SNTP会话信息，可以看到Device B与Device
A建立了会话，并且处于已同步状态。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
