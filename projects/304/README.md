# VRRP、Track与BFD联动配置举例（Backup监视Master）

# 标签：

**VRRP**

**TRACK**

## 需求： 

1.  Host A需要访问Internet上的Host B，Host
    A的缺省网关为10.1.1.111/24；当Router A正常工作时，Host A发送给Host
    B的报文通过Router A转发；当Router A出现故障时，Host A发送给Host
    B的报文通过Router B转发。

2.  在RouterB上部署BFD
    echo模式来快速监控Master运行情况，一旦Master出现问题，RouterB能够快速切换，成为master
    。

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

2\. 显示Router B上track信息

\[RouterB\]dis track 1

Track ID: 1

State: **Positive**

Duration: 0 days 0 hours 4 minutes 31 seconds

Tracked object type: BFD

Notification delay: Positive 0, Negative 0 (in seconds)

Tracked object:

BFD session mode: Echo

Outgoing interface: GigabitEthernet0/0

VPN instance name: \--

**Remote IP: 10.1.1.1**

**Local IP: 10.1.1.2**

3.此时打开Router B上的BFD和VRRP模块调试信息，然后关闭VRRP的相关接口。

%May 13 16:46:57:445 2022 RouterB BFD/5/BFD_CHANGE_FSM:
Sess\[10.1.1.2/10.1.1.1, LD/RD:33793/33793, Interface:GE0/0,
SessType:Echo, LinkType:INET\], **Ver:1, Sta: UP-\>DOWN,** Diag: 2 (Echo
Function Failed)

\*May 13 16:46:57:446 2022 RouterB BFD/7/DEBUG: **Notify
application:TRACK State:DOWN**

\<RouterB\>display vrrp

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
