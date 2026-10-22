# 工程名称
V7防火墙RBM结合OSPF路由主备部署


## 需求：
两台防火墙通过RBM实现主备部署，同时要求结合OSPF实现路由层面的主备


## 实验步骤：
1、配置上下行接口以及HA控制通道所在接口的ip地址，以FW1为例

#
interface GigabitEthernet1/0/1
 port link-mode route
 ip address 10.0.12.2 255.255.255.0
#
interface GigabitEthernet1/0/2
 port link-mode route
 ip address 10.0.24.2 255.255.255.0
#
interface GigabitEthernet1/0/23
 port link-mode route
 ip address 1.1.1.1 255.255.255.252
#

2、两台设备配置RBM

FW1:
RBM_P[FW1]dis cu conf remote-backup-group 
#
remote-backup group
 data-channel interface GigabitEthernet1/0/23  -----------配置数据通道对应接口为g1/0/23
 local-ip 1.1.1.1		-----配置本端控制通道ip地址为1.1.1.1
 remote-ip 1.1.1.2		-----配置对端控制通道ip地址为1.1.1.2
 device-role primary		-----配置本设备管理角色为主
 track interface GigabitEthernet1/0/1	-----配置RBM监控接口g1/0/1的状态，该接口down会触发rbm切换
 track interface GigabitEthernet1/0/2
 adjust-cost ospf enable absolute 1000  -----配置HA调整备设备上OSPF协议开销值功能，也就是指定备设备上OSPF协议对外通告的链路开销值
#


FW2:
RBM_A[FW2]dis cu conf remote-backup-group 
#
remote-backup group
 data-channel interface GigabitEthernet1/0/23  -----------配置数据通道对应接口为g1/0/23
 local-ip 1.1.1.2		-----配置本端控制通道ip地址为1.1.1.2
 remote-ip 1.1.1.1		-----配置对端控制通道ip地址为1.1.1.1
 device-role secondary		-----配置本设备管理角色为备
 track interface GigabitEthernet1/0/1	-----配置RBM监控接口g1/0/1的状态，该接口down会触发rbm切换
 track interface GigabitEthernet1/0/2
 adjust-cost ospf enable absolute 1000  -----配置HA调整备设备上OSPF协议开销值功能，也就是指定备设备上OSPF协议对外通告的链路开销值
#


3、配置OSPF，以FW1为例
RBM_P[FW1]dis cu conf ospf
#
ospf 1
 area 0.0.0.0
  network 10.0.12.2 0.0.0.0
  network 10.0.24.2 0.0.0.0
#

4、配置安全域，RBM通道接口可以不加入安全域(管理状态为主的设备上配置即可)
#
security-zone name Trust
 import interface GigabitEthernet1/0/2
#
security-zone name Untrust
 import interface GigabitEthernet1/0/1
#

5、配置安全策略规则，本工程因测试目的做了全部放通，实际生产环境还请配置明细的安全策略规则(管理状态为主的设备上配置即可)
注意：OSPF协议需要和防火墙本地交互协议报文，需要放行互联接口所在安全域与local域的策略
#
security-policy ip
 rule 1 name test
  action pass
#



## 测试结果：
1、查看防火墙RBM状态
RBM_P<FW1>dis remote-backup-group status 
Remote backup group information:
  Backup mode: Active/standby
  Device management role: Primary
  Device running status: Active-------FW1当前运行状态为主
  Data channel interface: GigabitEthernet1/0/23
  Local IP: 1.1.1.1
  Remote IP: 1.1.1.2    Destination port: 60064
  Control channel status: Connected
  Keepalive interval: 1s
  Keepalive count: 10
  Configuration consistency check interval: 24 hour
  Configuration consistency check result: Not Performed
  Configuration backup status: Auto sync enabled
  Session backup status: Hot backup enabled
  Uptime since last switchover: 0 days, 3 hours, 20 minutes
  Switchover records:
    Time                  Status change        Cause
    2022-11-17 10:46:13   Standby to Active    Interface status changed
    2022-11-17 10:43:38   Active to Standby    Interface status changed
    2022-11-17 10:14:52   Active to Active     Keepalive link established
    2022-11-17 10:09:35   Initial to Active    HA Configuration changed
RBM_P<FW1> 

RBM_S<FW2>dis remote-backup-group status 
Remote backup group information:
  Backup mode: Active/standby
  Device management role: Secondary
  Device running status: Standby-------FW2当前运行状态为备
  Data channel interface: GigabitEthernet1/0/23
  Local IP: 1.1.1.2
  Remote IP: 1.1.1.1    Destination port: 60064
  Control channel status: Connected
  Keepalive interval: 1s
  Keepalive count: 10
  Configuration consistency check interval: 24 hour
  Configuration consistency check result: Not Performed
  Configuration backup status: Auto sync enabled
  Session backup status: Hot backup enabled
  Uptime since last switchover: 0 days, 3 hours, 21 minutes
  Switchover records:
    Time                  Status change        Cause
    2022-11-17 10:46:03   Active to Standby    Interface status changed
    2022-11-17 10:43:59   Standby to Active    Interface status changed
    2022-11-17 10:14:52   Active to Standby    Keepalive link established
    2022-11-17 10:14:52   Initial to Active    HA Configuration changed
RBM_S<FW2>


2、查看FW接口OSPF cost值

RBM_P<FW1>dis ospf interface 


         OSPF Process 1 with Router ID 10.0.24.2
                 Interfaces 

 Area: 0.0.0.0        
 IP Address      Type      State    Cost  Pri   DR              BDR 
 10.0.12.2       Broadcast DR       1     1     10.0.12.2       10.0.12.1
 10.0.24.2       Broadcast BDR      1     1     10.0.24.4       10.0.24.2
RBM_P<FW1>

RBM_S<FW2>dis ospf interface 


         OSPF Process 1 with Router ID 10.0.24.3
                 Interfaces 

 Area: 0.0.0.0        
 IP Address      Type      State    Cost  Pri   DR              BDR 
 10.0.13.3       Broadcast DR       1000  1     10.0.13.3       10.0.13.1
 10.0.34.3       Broadcast BDR      1000  1     10.0.34.4       10.0.34.3
RBM_S<FW2>


3、查看SW2路由学习情况

<SW2>dis ip routing-table 
Destinations : 19       Routes : 19
Destination/Mask   Proto   Pre Cost        NextHop         Interface
.。。。。。
100.0.0.1/32       O_INTRA 10  2           10.0.24.2       GE1/0/1		-----路由是从主防火墙学到的
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
。。。。。。
<SW2>          


4、当FW主备切换后，查看SW2路由学习情况
RBM_P[FW1]dis remote-backup-group status 
Remote backup group information:
  Backup mode: Active/standby
  Device management role: Primary
  Device running status: Standby-------FW1当前运行状态为备
  Data channel interface: GigabitEthernet1/0/23
  Local IP: 1.1.1.1
  Remote IP: 1.1.1.2    Destination port: 60064
  Control channel status: Connected
  Keepalive interval: 1s
  Keepalive count: 10
  Configuration consistency check interval: 24 hour
  Configuration consistency check result: Not Performed
  Configuration backup status: Auto sync enabled
  Session backup status: Hot backup enabled
  Uptime since last switchover: 0 days, 0 hours, 0 minutes
  Switchover records:
    Time                  Status change        Cause
    2022-11-17 14:09:51   Active to Standby    Interface status changed
    2022-11-17 10:46:13   Standby to Active    Interface status changed
    2022-11-17 10:43:38   Active to Standby    Interface status changed
    2022-11-17 10:14:52   Active to Active     Keepalive link established
    2022-11-17 10:09:35   Initial to Active    HA Configuration changed
RBM_P[FW1]  
RBM_P[FW1]dis ospf interface 


         OSPF Process 1 with Router ID 10.0.24.2
                 Interfaces 

 Area: 0.0.0.0        
 IP Address      Type      State    Cost  Pri   DR              BDR 
 10.0.12.2       Broadcast Down     1000  1     0.0.0.0         0.0.0.0
 10.0.24.2       Broadcast Down     1000  1     0.0.0.0         0.0.0.0
RBM_P[FW1] 

RBM_S<FW2>dis remote-backup-group status 
Remote backup group information:
  Backup mode: Active/standby
  Device management role: Secondary
  Device running status: Active-------FW2当前运行状态为主
  Data channel interface: GigabitEthernet1/0/23
  Local IP: 1.1.1.2
  Remote IP: 1.1.1.1    Destination port: 60064
  Control channel status: Connected
  Keepalive interval: 1s
  Keepalive count: 10
  Configuration consistency check interval: 24 hour
  Configuration consistency check result: Not Performed
  Configuration backup status: Auto sync enabled
  Session backup status: Hot backup enabled
  Uptime since last switchover: 0 days, 0 hours, 0 minutes
  Switchover records:
    Time                  Status change        Cause
    2022-11-17 14:10:01   Standby to Active    Interface status changed
    2022-11-17 10:46:03   Active to Standby    Interface status changed
    2022-11-17 10:43:59   Standby to Active    Interface status changed
    2022-11-17 10:14:52   Active to Standby    Keepalive link established
    2022-11-17 10:14:52   Initial to Active    HA Configuration changed
RBM_S<FW2> 
RBM_S<FW2>dis ospf interface 


         OSPF Process 1 with Router ID 10.0.24.3
                 Interfaces 

 Area: 0.0.0.0        
 IP Address      Type      State    Cost  Pri   DR              BDR 
 10.0.13.3       Broadcast DR       1     1     10.0.13.3       10.0.13.1
 10.0.34.3       Broadcast BDR      1     1     10.0.34.4       10.0.34.3
RBM_S<FW2> 

<SW2>dis ip routing-table 

Destinations : 14       Routes : 14

Destination/Mask   Proto   Pre Cost        NextHop         Interface
。。。
100.0.0.1/32       O_INTRA 10  2           10.0.34.3       GE1/0/2		-------路由是从备防火墙学到的
。。。
<SW2>  


## 说明： 
1、防火墙默认用户名/密码：admin/admin
2、防火墙RBM默认不回切，如果需要主设备故障恢复后主备状态回切，需要在两台防火墙RBM视图下配置delay-time xx,xx代表回切的延迟时间，单位为分钟


