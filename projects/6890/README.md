# 工程名称
定时执行任务典型配置举例


## 需求：

Client访问无线网络，AC直接连接AP，AC充当DHCP服务器，为AP和Client分配IP地址。现要求：配置定时执行任务功能，每天8：00开启AC上关联AP的Radio1接口，每天20：00关闭AC上关联AP的Radio1接口。

## 实验步骤：
(1)      有关Client接入无线网络的相关配置请参见“WLAN接入配置指导”中的“WLAN接入”。 
  
(2)      配置定时执行任务 
  
# 进入系统视图。 
  
<AC> system-view 
  
# 创建关闭射频接口1的Job。 
  
[AC] scheduler job test
  
[AC-job-radio_disable] command 1 system-view 
  
[AC-job-radio_disable] command 2 wlan ap ap1 
  
[AC-job-radio_disable] command 3 radio 1 
  
[AC-job-radio_disable] command 4 radio disable 
  
[AC-job-radio_disable] quit 
  
# 配置定时执行任务，使设备在每天20：00关闭射频接口1。 
  
[AC] scheduler schedule stop_radio 
  
[AC-schedule-stop_radio] job test 
  
[AC-schedule-stop_radio] time repeating at 20:00 
  
[AC-schedule-stop_radio] quit 
  
# 创建开启射频接口1的Job。 
  
[AC] scheduler job test123 
  
[AC-job-radio_enable] command 1 system-view 
  
[AC-job-radio_enable] command 2 wlan ap ap1 model WA6320 
  
[AC-job-radio_enable] command 3 radio 1 
  
[AC-job-radio_enable] command 4 radio enable 
  
[AC-job-radio_enable] quit 
  
# 配置定时执行任务，使设备在每天8：00开启射频接口1。 
  
[AC] scheduler schedule start_radio 
  
[AC-schedule-start_radio] job test123
  
[AC-schedule-start_radio] time repeating at 8:00 
  
[AC-schedule-start_radio] quit 
  


## 测试结果：
# 在AC上通过命令行display wlan ap name ap1 verbose查看ap1 radio的管理状态 State，在8:00~20:00，radio的管理状态为UP，在其它时间radio的管理状态为DOWN。
[AC]display wlan ap name ap1 verbose
AP name                       : ap1
AP ID                         : 1
AP group name                 : default-group
State                         : Run
Backup type                   : Master
Online time                   : 0 days 0 hours 11 minutes 14 seconds
System uptime                 : 0 days 0 hours 12 minutes 2 seconds
Model                         : WA6320-HCL
Region code                   : CN
Region code lock              : Disabled
Serial ID                     : H3C_5C-FF-52-F1-02-00
MAC address                   : 5cff-52f1-0200
IP address                    : 2.0.0.2
UDP control port number       : 57088
UDP data port number          : 57088
H/W version                   : Ver.A
S/W version                   : R2442
Boot version                  : 2.17
USB state                     : N/A
Power level                   : N/A
Power info                    : N/A
Description                   : Not configured
Priority                      : 4
Echo interval                 : 10 seconds
Echo count                    : 3 counts
Keepalive interval            : 10 seconds
Discovery-response wait-time  : 2 seconds
Statistics report interval    : 50 seconds
Fragment size (data)          : 1500
Fragment size (control)       : 1450
MAC type                      : Local MAC & Split MAC
Tunnel mode                   : Local Bridging & 802.3 Frame & Native Frame
CAPWAP data-tunnel status     : Up
Discovery type                : Unknown
Retransmission count          : 3
Retransmission interval       : 5 seconds
Firmware upgrade              : Enabled
Sent control packets          : 207
Received control packets      : 207
Echo requests                 : 62
Lost echo responses           : 0
Average echo delay            : 0
Last reboot reason            : User reboot
Latest IP address             : 2.0.0.2
Current AC IP                 : 2.0.0.1
Tunnel down reason            : N/A
Connection count              : 1
Backup IPv4                   : Not configured
Backup IPv6                   : Not configured
Ctrl-tunnel encryption        : Disabled
Ctrl-tunnel encryption state  : Not encrypted
Data-tunnel encryption        : Disabled
Data-tunnel encryption state  : Not encrypted
LED mode                      : Normal
Remote configuration          : Disabled
EnergySaving Level            : 0
AP type                       : Normal AP
Radio 1:
    BSSID                     : 5cff-52f1-0210
    State                     : Up
    Type                      : 802.11ax
    Antenna type              : internal
    Client dot11ac-only       : Disabled
    Client dot11n-only        : Disabled
    Channel bandwidth         : 20/40/80MHz
    Operating bandwidth       : 20/40/80MHz
    Secondary channel mode    : SCA
    Short GI for 20MHz        : Supported
    Short GI for 40MHz        : Supported
    Short GI for 80MHz        : Supported
    Short GI for 160MHz       : Not supported
    MIMO                      : Not Config
    Green-Energy-Management   : Disabled
    A-MSDU                    : Enabled
    A-MPDU                    : Enabled
    LDPC                      : Supported
    STBC                      : Supported
    Operational VHT-MCS set:
        Mandatory             : Not configured
        Supported             : NSS1 0,1,2,3,4,5,6,7,8,9
                                NSS2 0,1,2,3,4,5,6,7,8,9
        Multicast             : Not configured
    Operational HT MCS set:
        Mandatory             : Not configured
        Supported             : 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                                10, 11, 12, 13, 14, 15
        Multicast             : Not configured
    Channel                   : 36(auto)
    Channel usage(%)          : 0
    Max power                 : 20 dBm
    Operational rate:
        Mandatory             : 6, 12, 24 Mbps
        Multicast             : Auto
        Supported             : 9, 18, 36, 48, 54 Mbps
        Disabled              : Not configured
    Distance                  : 1 km
    ANI                       : Enabled
    Fragmentation threshold   : 2346 bytes
    Beacon interval           : 100 TU
    Protection threshold      : 2346 bytes
    Long retry threshold      : 4
    Short retry threshold     : 7
    Frame aging time in cache : 2000 ms
    Noise floor               : 0 dBm
    Protection mode           : cts-to-self
    MU-TxBF                   : Disabled
    SU-TxBF                   : Disabled
    Continuous mode           : N/A
    Client dot11ax-only       : Disabled
    Operational HE-MCS Set:
        Mandatory             : Not configured
        Supported             : NSS1 0,1,2,3,4,5,6,7,8,9,10,11
                                NSS2 0,1,2,3,4,5,6,7,8,9,10,11
        Multicast             : Not configured
    OFDMA random access RUs   : Not Supported
    Channel Width Set         : 0x02
    DL-OFDMA                  : Disabled
    UL-OFDMA                  : Disabled
    UL-MU-MIMO                : Disabled
    BSS-COLOR                 : Disabled
    TWT negotiation           : Disabled
    HT protection mode        : No protection
Radio 2:
    BSSID                     : 5cff-52f1-0220
    State                     : Down
    Type                      : 802.11gax
    Antenna type              : internal
    Client dot11ac-only       : Disabled
    Client dot11n-only        : Disabled
    Channel bandwidth         : 20MHz
    Operating bandwidth       : 20MHz
    Secondary channel mode    : SCN
    Short GI for 20MHz        : Supported
    Short GI for 40MHz        : Supported
    Short GI for 80MHz        : Not supported
    Short GI for 160MHz       : Not supported
    MIMO                      : Not Config
    Green-Energy-Management   : Disabled
    A-MSDU                    : Enabled
    A-MPDU                    : Enabled
    LDPC                      : Supported
    STBC                      : Supported
    Operational VHT-MCS set:
        Mandatory             : Not configured
        Supported             : Not configured
        Multicast             : Not configured
    Operational HT MCS set:
        Mandatory             : Not configured
        Supported             : 0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
                                10, 11, 12, 13, 14, 15
        Multicast             : Not configured
    Channel                   : 1(auto)
    Channel usage(%)          : 0
    Max power                 : 20 dBm
    Operational rate:
        Mandatory             : 1, 2, 5.5, 11 Mbps
        Multicast             : Auto
        Supported             : 6, 9, 12, 18, 24, 36, 48, 54 Mbps
        Disabled              : Not configured
    Distance                  : 1 km
    ANI                       : Enabled
    Fragmentation threshold   : 2346 bytes
    Beacon interval           : 100 TU
    Protection threshold      : 2346 bytes
    Long retry threshold      : 4
    Short retry threshold     : 7
    Frame aging time in cache : 2000 ms
    Noise floor               : 0 dBm
    Protection mode           : cts-to-self
    SU-TxBF                   : Disabled
    Continuous mode           : N/A
    Client dot11ax-only       : Disabled
    Operational HE-MCS Set:
        Mandatory             : Not configured
        Supported             : NSS1 0,1,2,3,4,5,6,7,8,9,10,11
                                NSS2 0,1,2,3,4,5,6,7,8,9,10,11
        Multicast             : Not configured
    OFDMA random access RUs   : Not Supported
    Channel Width Set         : 0x01
    DL-OFDMA                  : Disabled
    UL-OFDMA                  : Disabled
    UL-MU-MIMO                : Disabled
    BSS-COLOR                 : Disabled
    TWT negotiation           : Disabled
    HT protection mode        : No protection


## 说明： 


