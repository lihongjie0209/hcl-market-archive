# VRRP、Track与BFD联动配置举例（监测上行链路）

# 标签：

**VRRP**

**TRACK**

## 需求： 

1.  Host A需要访问Internet上的Host B，Host
    A的缺省网关为10.1.1.111/24；当Router A正常工作时，Host A发送给Host
    B的报文通过Router A转发；当Router A出现故障时，Host A发送给Host
    B的报文通过Router B转发。

2.  在RouterA上部署track，监测上行链路，如果上行链路发生故障，将RouterA的VRRP优先级降低30，从而让RouterB为Master。

## 测试结果：

1.  显示Router A备份组信息

\[Router A\]display vrrp

IPv4 Virtual Router Information:

Running mode : Standard

Total number of virtual routers : 1

Interface VRID State Running Adver Auth Virtual

Pri Timer Type IP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE0/0 1 Master 110 100 Not supported 10.1.1.111

\[RouterB\]display vrrp

IPv4 Virtual Router Information:

Running mode : Standard

Total number of virtual routers : 1

Interface VRID State Running Adver Auth Virtual

Pri Timer Type IP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE0/0 1 Backup 100 100 Not supported 10.1.1.111

2\. 显示Router A上track信息

\[Router A\]dis track 1

Track ID: 1

**State: Positive**

Duration: 0 days 0 hours 0 minutes 14 seconds

Tracked object type: **BFD**

Notification delay: Positive 0, Negative 0 (in seconds)

Tracked object:

BFD session mode: Echo

**Outgoing interface: GigabitEthernet0/1**

VPN instance name: \--

Remote IP: 2.1.1.2

Local IP: 2.1.1.1

3.此时关闭RouterA的上行接口G0/1，。

\[Router A-GigabitEthernet0/1\]dis track 1

Track ID: 1

State: Negative

Duration: 0 days 0 hours 0 minutes 6 seconds

Tracked object type: BFD

Notification delay: Positive 0, Negative 0 (in seconds)

Tracked object:

BFD session mode: Echo

Outgoing interface: GigabitEthernet0/1

VPN instance name: \--

Remote IP: 2.1.1.2

Local IP: 2.1.1.1

此时RouterB成为master。

\<RouterB\>%May 13 17:10:25:621 2022 RouterB VRRP4/6/VRRP_STATUS_CHANGE:

The status of IPv4 virtual router 1 (configured on GigabitEthernet0/0)
changed from Backup to Master: Preempt.

\<RouterB\>dis vrrp

IPv4 Virtual Router Information:

Running mode : Standard

Total number of virtual routers : 1

Interface VRID State Running Adver Auth Virtual

Pri Timer Type IP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE0/0 1 Master 100 100 Not supported 10.1.1.111

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
