# QoS流量过滤

**标签：**

**QoS**

## 需求

流量过滤可以使用包过滤或者QoS过滤，这里演示使用QoS过滤的情况。在RTB上配置QoS过滤，抑制RTA
1.1.1.1访问RTC 2.2.2.2的ICMP流量。

## 实验步骤：

1、配置各接口的IP地址

2、使能QoS流量过滤

\#

acl advanced 3000

rule 0 permit icmp source 1.1.1.1 0 destination 2.2.2.2 0

\#

traffic classifier 1 operator and

if-match acl 3000

\#

traffic behavior 1

filter deny

\#

qos policy 1

classifier 1 behavior 1

\#

后续在接口调用QoS。

## 测试结果：

配置前可以访问：

![](./Media//image1.png)


RTB接口调用QoS过滤：

\#

interface GigabitEthernet0/0

qos apply policy 1 inbound

\#

此时访问超时：

![](./Media//image2.png)


查看RTB接口的QoS统计，可见报文已经被拒绝：

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
