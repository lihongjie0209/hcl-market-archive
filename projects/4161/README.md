# 多Smartlink组负载分担组网配置举例

## 需求：

Vlan1-100的流量经过Device C上Smart Link组1的主端口向Device A转发，VLAN
101～200的流量经Device C上Smart Link组2的主端向Device
A转发；在DeviceC上实现双上行链路的灵活备份和负载分担。

##  实验步骤：

1.  将Device A、Device B、Device
    D端口开启接受Flush报文功能，并指定接收Flush报文的控制vlan；

2.  在Device C上进行MST域配置并激活，在端口shutdown的状态下进行undo stp
    enable和放通对应vlan的配置

3.  创建smart link组，并配置保护vlan为MSTI
    1所映射的vlan，选定主从算口，抢占模式。

4.  开启发送flush报文的功能，并指定发送flush报文的控制vlan。

5.  配置完成后开启端口

## 测试结果：

配置完成后在device C上查看smart link组的信息。可以刊出： Smart
Link组1的主端口为GigabitEthernet1/0/1，Smart
Link组2的主端口为GigabitEthernet1/0/2

\<DeviceC\>dis smart-link group all

Smart link group 1 information:

Device ID : 5ccd-dfc8-0300

Preemption mode : Role

Preemption delay: 1(s)

Control VLAN : 10

Protected VLAN : Reference Instance 1

Member Role State Flush-count Last-flush-time

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/1 PRIMARY ACTIVE 2 09:47:24 2022/09/14

GE1/0/2 SECONDARY STANDBY 0 NA

Smart link group 2 information:

Device ID : 5ccd-dfc8-0300

Preemption mode : Role

Preemption delay: 1(s)

Control VLAN : 110

Protected VLAN : Reference Instance 2

Member Role State Flush-count Last-flush-time

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/2 PRIMARY ACTIVE 1 09:47:35 2022/09/14

GE1/0/1 SECONDARY STANDBY 0 NA

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
