# 工程名称

AC  IPV6 ntp典型配置举例

## 需求：
为了通过IPv6 NTP实现Switch与AC的时间同步，要求：
·              在AC上设置本地时钟作为参考时钟，层数为2；
·              配置Switch工作在客户端模式，指定AC为IPv6 NTP服务器。


## 实验步骤：

(1)      配置AC和交换机的IPV6各接口的IP地址，并确保路由可达，具体配置过程略。
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
# 设置AC为Switch的IPv6 NTP服务器。
[Switch] ntp-service ipv6 unicast-server 3000::10

## 测试结果：
# 完成上述配置后（稍等一会），Switch向AC进行时间同步。同步后查看Switch的NTP状态。可以看出，Switch已经与AC同步，层数比AC的层数大1，为3。
[SW]display ntp-service status
 Clock status: synchronized
 Clock stratum: 3
 System peer: 3000::10
 Local mode: client
 Reference clock ID: 129.111.2.80
 Leap indicator: 00
 Clock jitter: 0.000977 s
 Stability: 0.000 pps
 Clock precision: 2^-10
 Root delay: 0.15259 ms
 Root dispersion: 16.86096 ms
 Reference time: e71cd3f3.08241804  Mon, Nov 14 2022 14:49:23.031

# 查看Switch的NTP服务的所有IPv6会话信息，可以看到Switch与AC建立了会话。
[SW]display ntp-service ipv6 sessions
Notes: 1 source(master), 2 source(peer), 3 selected, 4 candidate, 5 configured.

 Source: [12345]3000::10
 Reference: 127.127.1.0          Clock stratum: 2
 Reachabilities: 3               Poll interval: 64
 Last receive time: 26           Offset: -1.005
 Roundtrip delay: 0.1525         Dispersion: 1.9073

 Total sessions: 1


## 说明：



