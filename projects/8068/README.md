# 工程名称
带验证功能的NTP客户端/服务器模式典型配置举例


## 需求：
为了通过NTP实现Switch与AC的时间同步，并保证时间同步的安全性，要求：
·              在AC上设置本地时钟作为参考时钟，层数为2；
·              Switch工作在客户端模式，指定AC为NTP服务器；
·              AC和Switch上同时配置NTP验证。


## 实验步骤：
(1)      配置各接口的IP地址，并确保路由可达，具体配置过程略。
(2)      配置AC的本地时钟作为参考时钟
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
# 在Switch上启动NTP验证功能。
[Switch] ntp-service authentication enable
# 创建编号为42的NTP验证密钥，密钥值为aNiceKey，以明文形式输入。
[Switch] ntp-service authentication-keyid 42 authentication-mode md5 simple aNiceKey
# 配置编号为42的密钥为可信密钥。
[Switch] ntp-service reliable authentication-keyid 42
# 设置AC为Switch的NTP服务器，并将该服务器与编号为42的密钥关联。
[Switch] ntp-service unicast-server 10.0.0.1 authentication-keyid 42
以上配置将使得Switch与AC进行时间同步，但由于AC没有使能NTP身份验证，所以，Switch还是无法与AC同步。
(4)      在AC上配置NTP验证功能。
# 在AC上启动NTP验证功能。
[AC] ntp-service authentication enable
# 创建编号为42的NTP验证密钥，密钥值为aNiceKey，以明文形式输入。
[AC] ntp-service authentication-keyid 42 authentication-mode md5 simple aNiceKey
# 配置编号为42的密钥为可信密钥。
[AC] ntp-service reliable authentication-keyid 42


## 测试结果：
完成上述配置后，Switch可以与AC的时间同步。同步后查看Switch的状态。可以看出，Switch已经与AC同步，层数比AC的层数大1，为3。
[SW]display ntp-service status
 Clock status: synchronized
 Clock stratum: 3
 System peer: 10.0.0.1
 Local mode: client
 Reference clock ID: 10.0.0.1
 Leap indicator: 00
 Clock jitter: 0.001236 s
 Stability: 0.000 pps
 Clock precision: 2^-10
 Root delay: 0.12207 ms
 Root dispersion: 18.00537 ms
 Reference time: e7432c82.b42e8622  Tue, Dec 13 2022 16:53:22.703
# 查看Switch的NTP服务的所有IPv4会话信息，可以看到Switch与AC建立了会话。
[SW]display ntp-service sessions
       source          reference       stra reach poll  now offset  delay disper
********************************************************************************
[12345]10.0.0.1        127.127.1.0        2     1   64   18 -1.765 0.1220 1.9073
Notes: 1 source(master), 2 source(peer), 3 selected, 4 candidate, 5 configured.
 Total sessions: 1

## 说明： 


