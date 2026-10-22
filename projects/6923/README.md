# 工程名称

AC NTP对等体典型配置举例

## 需求：
网络中存在时间服务器AC。为了通过NTP实现Switch与AC进行时间同步，要求：
·              在AC上设置本地时钟作为参考时钟，层数为2；
·              配置AC工作在对等体模式，指定Switch为被动对等体，即AC为主动对等体，Switch为被动对等体。


## 实验步骤：

(1)      配置各接口的IP地址，并确保路由可达，具体配置过程略。
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
# 设置本地时钟作为参考时钟，层数为2。
[AC] ntp-service refclock-master 2
# 设置Switch为被动对等体。AC处于主动对等体模式。
[AC] ntp-service unicast-peer 10.0.0.2

## 测试结果：
# 完成上述配置后，Switch选择AC作为参考时钟，与AC进行时间同步。同步后查看Switch的状态。可以看出，Switch已经与AC同步，层数比AC的层数大1，为3。

[SW]display ntp-service status
 Clock status: synchronized
 Clock stratum: 3
 System peer: 10.0.0.1
 Local mode: sym_passive
 Reference clock ID: 10.0.0.1
 Leap indicator: 00
 Clock jitter: 0.000977 s
 Stability: 0.000 pps
 Clock precision: 2^-10
 Root delay: 0.00000 ms
 Root dispersion: 0.19836 ms
 Reference time: e720bfc9.d069a672  Thu, Nov 17 2022 14:12:25.814
# 查看Switch的NTP服务的IPv4会话信息，可以看到Switch与AC建立了会话。

[SW]display ntp-service sessions
       source          reference       stra reach poll  now offset  delay disper
********************************************************************************
   [12]10.0.0.1        127.127.1.0        2     1   64   62 0.0000 0.0000  16000
Notes: 1 source(master), 2 source(peer), 3 selected, 4 candidate, 5 configured.
 Total sessions: 1



## 说明： 


