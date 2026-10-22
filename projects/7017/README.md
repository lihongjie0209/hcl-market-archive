# 工程名称
AC IPv6 NTP对等体模式
## 需求：
网络中存在时间服务器AC。为了通过IPv6 NTP实现Switch与AC进行时间同步，要求：
·              在AC上设置本地时钟作为参考时钟，层数为2；
·              配置AC工作在对等体模式，指定Switch为被动对等体，即AC为主动对等体，Switch为被动对等体


## 实验步骤：
(1)     配置各接口的IP地址，并确保路由可达，具体配置过程略。
(2)      配置Switch
# 开启NTP服务。
<Switch> system-view
[Switch] ntp-service enable
# 配置通过NTP协议获取时间。
[Switch] clock protocol ntp 
(3)      配置AC
# 开启NTP服务。
<AC> system-view
[AC] ntp-service enable
# 配置通过NTP协议获取时间。
[AC] clock protocol ntp 
# 设置本地时钟作为参考时钟，层数为2。
[AC] ntp-service refclock-master 2
# 设置Switch为IPv6被动对等体。AC处于主动对等体模式。
[AC] ntp-service ipv6 unicast-peer 3000::5


## 测试结果：
# 完成上述配置后，Switch选择AC作为参考时钟，与AC进行时间同步。同步后查看Switch的状态。可以看出，Switch已经与AC同步，层数比AC的层数大1，为3。
[SW]display ntp-service status
 Clock status: synchronized
 Clock stratum: 3
 System peer: 3000::5
 Local mode: client
 Reference clock ID: 15.132.201.34
 Leap indicator: 00
 Clock jitter: 0.001053 s
 Stability: 0.000 pps
 Clock precision: 2^-10
 Root delay: 0.12207 ms
 Root dispersion: 16.52527 ms
 Reference time: e725d31a.ab9010b4  Mon, Nov 21 2022 10:36:10.670
# 查看Switch的NTP服务的IPv6会话信息，可以看到Switch与AC建立了会话。
[SW]display ntp-service ipv6 sessions
Notes: 1 source(master), 2 source(peer), 3 selected, 4 candidate, 5 configured.

 Source: [12345]3000::5
 Reference: 127.127.1.0          Clock stratum: 2
 Reachabilities: 3               Poll interval: 64
 Last receive time: 21           Offset: 0.7784
 Roundtrip delay: 0.1220         Dispersion: 1.9073

 Total sessions: 1


## 说明： 


