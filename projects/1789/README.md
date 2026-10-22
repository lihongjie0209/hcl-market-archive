# ARP测试配置举例

**标签：**

**NQA**

## 需求

使用NQA的ARP测试功能，测试本端（Device
A）发出的ARP请求报文到接收目的端Device
B的ARP响应报文以及报文的往返时间。

## 实验步骤：

1、配置各接口的IP地址。

2、配置Device A

创建ARP类型的NQA测试组（管理员为admin，操作标签为test1）。

\<DeviceA\> system-view

\[DeviceA\] nqa entry admin test1

\[DeviceA-nqa-admin-test1\] type arp

配置测试操作的探测报文的目的IP地址为10.1.1.2。

\[DeviceA-nqa-admin-test1-arp\] destination ip 10.1.1.2

配置可选参数：一次NQA测试中探测的次数为10，探测的超时时间为500毫秒，测试组连续两次测试开始时间的时间间隔为5000毫秒。

\[DeviceA-nqa-admin-test1-arp\] probe count 10

\[DeviceA-nqa-admin-test1-arp\] probe timeout 500

\[DeviceA-nqa-admin-test1-arp\] frequency 5000

开启NQA历史记录保存功能，并配置一个测试组中能够保存的最大历史记录个数为10。

\[DeviceA-nqa-admin-test1-arp\] history-record enable

\[DeviceA-nqa-admin-test1-arp\] history-record number 10

\[DeviceA-nqa-admin-test1-arp\] quit

启动ARP测试操作，并一直进行测试。

\[DeviceA\] nqa schedule admin test1 start-time now lifetime forever

测试执行一段时间后，停止ARP测试操作。

\[DeviceA\] undo nqa schedule admin test1

## 测试结果：

显示ARP测试中最后一次测试的当前结果。

![](./Media//image1.png)


显示ARP测试的历史记录。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
