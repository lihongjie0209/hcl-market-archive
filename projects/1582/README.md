# IP流量统计

**标签：**

**QoS**

## 需求

对1.1.1.1到3.3.3.3的ICMP流量进行统计。判断流量收发情况，在丢包的情况下辅助判断丢包位置。

## 实验步骤：

1、配置各接口的IP地址

2、使能QoS流量统计

\#

acl advanced 3000

rule 0 permit icmp source 1.1.1.1 0 destination 3.3.3.3 0

rule 5 permit icmp source 3.3.3.3 0 destination 1.1.1.1 0

\#

traffic classifier 1 operator and

if-match acl 3000

\#

traffic behavior 1

filter permit

\#

qos policy 1

classifier 1 behavior 1

\#

interface GigabitEthernet0/0

qos apply policy 1 inbound

qos apply policy 1 outbound

\#

现网实际中可能需要对多台设备沿途接口配置流统，这里仅以RTB配置为例。

MSR系列设备，在定义流行为时默认就是执行包统计（或者写filter
permit），不需要配置accounting命令；部分其他设备流统的话，按照实际情况添加accounting命令。

## 测试结果：

RTA ping 5个包测试：

![](./Media//image1.png)


查看RTB G0/0口的流统信息：

![](./Media//image2.png)


可见收了5个报文。

G0/1口同样发出去了5个包：

![](./Media//image3.png)


对于回程，使用命令查看G0/1入方向与G0/0出方向的计数即可。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
