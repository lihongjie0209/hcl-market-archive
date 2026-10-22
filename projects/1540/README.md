# UDP-jitter测试配置

## 需求：

使用NQA的UDP-jitter测试功能，测试本端（Device A）和指定目的端（Device
B）的端口9000之间传送报文的抖动时间。

## 实验步骤：

1.  配置各接口的IP地址。

2.  配置静态路由或动态路由协议，确保各设备之间路由可达。

3.  创建UDP-jitter类型的NQA测试组，并启动探测。

配置Device B

使能NQA服务器，配置监听的IP地址为10.2.2.2，UDP端口号为9000。

\#

nqa server enable

nqa server udp-echo 1.1.1.2 9000

\#

配置Device A

创建UDP-jitter类型的NQA测试组（管理员为admin，操作标签为test1）。

\#

nqa entry admin test1

type udp-jitter

destination ip 1.1.1.2

destination port 9000

frequency 1000

\#

nqa schedule admin test1 start-time now lifetime forever

\#

## 测试结果：

显示UDP-jitter测试中最后一次测试的当前结果。

![](./Media//image1.png)


显示UDP-jitter测试的统计结果。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
