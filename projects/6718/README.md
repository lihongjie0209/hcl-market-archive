# 工程名称

AC NTP典型配置举例

## 需求：

为了通过NTP实现Switch与AC的时间同步，要求：
·              在AC上设置本地时钟作为参考时钟，层数为2；
·              配置Switch工作在客户端模式，指定AC为NTP服务器

## 实验步骤：

(1)     配置各接口的IP地址，并确保路由可达，具体配置过程略。
(2)      配置AC
# 开启NTP服务。
<AC> system-view
[AC] ntp-service enable
# 设置本地时钟作为参考时钟，层数为2。
[AC] ntp-service refclock-master 2
(3)      配置Switch
# 开启NTP服务。
<Switch> system-view
[Switch] ntp-service enable
# 配置通过NTP协议获取时间。
[Switch] clock protocol ntp
# 设置AC为Switch的NTP服务器。
[Switch] ntp-service unicast-server 10.0.0.1

## 测试结果：
完成上述配置后，Switch向AC进行时间同步。同步后查看Switch的NTP状态。可以看出，Switch已经与AC同步，层数比AC的层数大1，为3。
[SW]display ntp-service status
 Clock status: synchronized
 Clock stratum: 3
 System peer: 10.0.0.1
 Local mode: client
 Reference clock ID: 10.0.0.1
 Leap indicator: 00
 Clock jitter: 0.130798 s
 Stability: 0.000 pps
 Clock precision: 2^-10
 Root delay: 0.01526 ms
 Root dispersion: 392.89856 ms
 Reference time: e71ccd51.8d11c68a  Mon, Nov 14 2022 14:21:05.551

查看Switch的NTP服务的所有IPv4会话信息，可以看到Switch与AC建立了会话。
[SW]display ntp-service sessions
       source          reference       stra reach poll  now offset  delay disper
********************************************************************************
[12345]10.0.0.1        127.127.1.0        2     3   64   42 -247.2 0.0152 1.9226
Notes: 1 source(master), 2 source(peer), 3 selected, 4 candidate, 5 configured.
 Total sessions: 1


## 说明： 


