# MonitorLink基础配置举例

## 需求：

在Device C上通过smart link技术实现上行链路的灵活备份，并且当Device
A与Device B（或Device D）之间出现链路故障时，Device
C能够感知到这个链路故障并完成上行链路的切换。

##  实验步骤：

1.  将Device A、Device B、Device
    D端口开启接受Flush报文功能，并指定接收Flush报文的控制vlan；

2.  在Device C上进行MST域配置并激活，在端口shutdown的状态下进行undo stp
    enable和放通对应vlan的配置

3.  创建smart link组，并配置保护vlan为对应MSTI
    所映射的vlan，选定主从算口，抢占模式。

4.  开启发送flush报文的功能，并指定发送flush报文的控制vlan。

5.  完成smart link组配置之后，在Device B和Device
    D设备上开启monitor-link组，配置该组上行接口1/0/1为uplink，下行口1/0/2为downlink

## 测试结果：

正常状态下查看B，D设备的monitor link组信息

\<DB\>dis monitor-link group all

Monitor link protocol status: Enabled

Monitor link group 1 information:

Group status : UP

Downlink up delay: 0(s)

Last up time : 10:02:53 2022/09/14

Last down time : -

Up port threshold: 1

Member Role Status

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/1 UPLINK UP

GE1/0/2 DOWNLINK UP

\<DD\>dis monitor-link group all

Monitor link protocol status: Enabled

Monitor link group 1 information:

Group status : UP

Downlink up delay: 0(s)

Last up time : 10:02:56 2022/09/14

Last down time : -

Up port threshold: 1

Member Role Status

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/1 UPLINK UP

GE1/0/2 DOWNLINK UP

当A设备与B设备之间链路发生了故障，查看B和D设备的smart
link组信息，可以看出B设备下行口1/0/2在1/0/1down了之后由于monitor
link组存在也随之处于down的状态

\<DD\>dis monitor-link group all

Monitor link protocol status: Enabled

Monitor link group 1 information:

Group status : DOWN

Downlink up delay: 0(s)

Last up time : 10:02:56 2022/09/14

Last down time : 10:15:30 2022/09/14

Up port threshold: 1

Member Role Status

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/1 UPLINK DOWN

GE1/0/2 DOWNLINK DOWN (Monitor Link)

\<DB\>dis monitor-link group all

Monitor link protocol status: Enabled

Monitor link group 1 information:

Group status : UP

Downlink up delay: 0(s)

Last up time : 10:02:53 2022/09/14

Last down time : -

Up port threshold: 1

Member Role Status

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/1 UPLINK UP

GE1/0/2 DOWNLINK UP

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
