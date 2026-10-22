# Smartlink与Track联动配置举例（交换）

## 需求：

Vlan1-100的流量经过Device C上Smart
Link组1的主端口GigabitEthernet1/0/1向Device A转发，VLAN
101～200的流量经Device C上Smart
Link组2的主端口GigabitEthernet1/0/2向Device A转发；当Device C与Device
A之间的链路发生故障时，原本由各Smart
Link组的主端口转发的流量能够快速切换到从端口，并在故障排除后再切换回主端口。

##  实验步骤：

1.  将Device A、Device B、Device
    D端口开启接受Flush报文功能，并指定接收Flush报文的控制vlan；

2.  在Device C上进行MST域配置并激活，在端口shutdown的状态下进行undo stp
    enable和放通对应vlan的配置

3.  创建smart link组，并配置保护vlan为对应MSTI
    所映射的vlan，选定主从算口，抢占模式。

4.  开启发送flush报文的功能，并指定发送flush报文的控制vlan。

5.  开启CFD功能，进行CFD功能相关配置。

6.  创建与CFD链路性检测功能关联的Track项，随后再端口配置track项与CFD连续性检测功能联动，并重新开启端口。

## 测试结果：

正常状态下查看C设备的smart link组信息

\<DeviceC\>dis smart-link group all

Smart link group 1 information:

Device ID : 5ccd-dfc8-0300

Preemption mode : Role

Preemption delay: 1(s)

Control VLAN : 10

Protected VLAN : Reference Instance 1

Member Role State Flush-count Last-flush-time

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/1 PRIMARY ACTIVE 2 09:54:06 2022/09/14

GE1/0/2 SECONDARY STANDBY 0 NA

Smart link group 2 information:

Device ID : 5ccd-dfc8-0300

Preemption mode : Role

Preemption delay: 1(s)

Control VLAN : 110

Protected VLAN : Reference Instance 2

Member Role State Flush-count Last-flush-time

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/2 PRIMARY ACTIVE 1 09:54:15 2022/09/14

GE1/0/1 SECONDARY STANDBY 0 NA

当A设备与B设备之间链路发生了故障，查看C设备的smart
link组信息，可以看出此时smart
link组1的主端口GE1/0/1处于故障状态，从端口处于转发状态。

%Sep 14 09:56:13:799 2022 DeviceC CFD/6/CFD_LOST_CCM: MEP 1001 in SI 1
failed to receive CCMs from RMEP 1002.

%Sep 14 09:56:13:800 2022 DeviceC TRACK/6/TRACK_STATE_CHANGE: The state
of track entry 1 changed from Positive to Negative.

%Sep 14 09:56:13:801 2022 DeviceC SMLK/4/SMLK_LINK_SWITCH: Status of
port GigabitEthernet1/0/2 in smart link group 1 changes to active.

\<DeviceC\>dis smart-link group all

Smart link group 1 information:

Device ID : 5ccd-dfc8-0300

Preemption mode : Role

Preemption delay: 1(s)

Control VLAN : 10

Protected VLAN : Reference Instance 1

Member Role State Flush-count Last-flush-time

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/1 PRIMARY DOWN 2 09:54:06 2022/09/14

GE1/0/2 SECONDARY ACTIVE 1 09:56:13 2022/09/14

Smart link group 2 information:

Device ID : 5ccd-dfc8-0300

Preemption mode : Role

Preemption delay: 1(s)

Control VLAN : 110

Protected VLAN : Reference Instance 2

Member Role State Flush-count Last-flush-time

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE1/0/2 PRIMARY ACTIVE 1 09:54:15 2022/09/14

GE1/0/1 SECONDARY STANDBY 0 NA

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
