**标签：**

NAT server

VPN instance

安全策略

**需求：**

防火墙FW1位于外网区域，FW2为NAT设备，入接口配置了VPN实例v1,内网口设置为三种情况：VPN实例v2,无VPN实例以及VPN实例v1

FW3、4、5作为内网服务器提供服务。

根据该实验学习VPN实例场景下进行NAT转发的配置

**实验步骤：**

1.  防火墙配置（FW１、３、４、５）

    a.  根据组网规划，配置接口的IP地址

    b.  安全域和安全策略，保证互通

2.  防火墙配置（FW２）

    a.  创建VPN实例

    b.  接口下配置VPN实例，配置IP地址

    c.  安全策略

    d.  接口下NAT　server配置

**测试结果：**

在FW１上验证网络是否畅通：

![](./Media//image1.png)


FW２上查看NAT会话，发现映射正常

\[H3C\]dis nat session verbose

Slot 1:

Initiator:

Source IP/port: 1.1.1.1/420

Destination IP/port: 1.1.1.4/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: v1/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/0

Source security zone: Untrust

Responder:

Source IP/port: 10.3.3.5/420

Destination IP/port: 1.1.1.1/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: v1/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/3

Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 3

Rule name: t3

Start time: 2022-01-24 16:50:59 TTL: 20s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

Initiator:

Source IP/port: 1.1.1.1/418

Destination IP/port: 1.1.1.2/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: v1/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/0

Source security zone: Untrust

Responder:

Source IP/port: 10.1.1.3/418

Destination IP/port: 1.1.1.1/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: v2/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/1

Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 1

Rule name: u2t

Start time: 2022-01-24 16:50:53 TTL: 14s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

Initiator:

Source IP/port: 1.1.1.1/419

Destination IP/port: 1.1.1.3/2048

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: v1/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/0

Source security zone: Untrust

Responder:

Source IP/port: 10.2.2.4/419

Destination IP/port: 1.1.1.1/0

DS-Lite tunnel peer: -

VPN instance/VLAN ID/Inline ID: -/-/-

Protocol: ICMP(1)

Inbound interface: GigabitEthernet1/0/2

Source security zone: Trust

State: ICMP_REPLY

Application: ICMP

Rule ID: 2

Rule name: t2

Start time: 2022-01-24 16:50:56 TTL: 17s

Initiator-\>Responder: 5 packets 420 bytes

Responder-\>Initiator: 5 packets 420 bytes

Total sessions found: 3

**说明：**

1、本实验用的模拟器为F10６０，内存为800M。

2、本实验用的路由器版本为默认。

（默认是B75分支，如果所用的vmdk版本是B59或者其他定制版本，请说明，并告知vmdk放在什么地方可共享，如：本实验所用设备vmdk版本为B59，vmdk文件及更换版本操作方法均放在ftp，路径为：新版本已上传FTP：/01-IP网络产品/03-中低端路由器（AR、MSR、ICG、VG、LA）/99
临时目录/模拟器/模拟器版本/）
