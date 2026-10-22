# 工程名称
V7交换机NTP时钟同步


## 需求：
配置内网核心交换机作为NTP服务器，下层接入交换机作为NTP客户端从核心交换机同步时间



## 实验步骤：
1、为交换机配置互联ip保证设备间可以正常通信

2、核心交换机开启NTP服务，并配置本地时钟作为参考时钟，层数为2

#
 ntp-service enable
 ntp-service refclock-master 2
#


3、接入交换机开启NTP服务，配置通过NTP协议获取时间，同时指定核心交换机192.168.1.1为NTP服务器

#
 ntp-service enable
 ntp-service unicast-server 192.168.1.1
 clock protocol ntp
#


## 测试结果：
1、查看接入交换机时间已成功同步

[NTP-Client]dis clock
22:50:39 UTC Sat 09/17/2022


2、查看接入交换机NTP同步状态正常

[NTP-Client]dis ntp-service status 
 Clock status: synchronized	//synchronized表示同步成功
 Clock stratum: 3 
 System peer: 192.168.1.1 
 Local mode: client
 Reference clock ID: 192.168.1.1
 Leap indicator: 00
 Clock jitter: 0.006088 s
 Stability: 0.000 pps 
 Clock precision: 2^-10
 Root delay: 0.50354 ms 
 Root dispersion: 23.11707 ms 
 Reference time: e6d0cd9f.95ac7401  Sat, Sep 17 2022 22:50:07.584
[NTP-Client]

3、接入交换机上产生NTP同步成功的日志

[NTP-Client]
%Sep 17 22:50:02:581 2022 NTP-Client NTP/5/NTP_CLOCK_CHANGE: System clock changed from 22:50:01:704 09/17/2022 to 22:50:02:580 09/17/2022, the NTP server's IP address is 192.168.1.1.



## 说明： 
1、NTP客户端和服务器之间必须可以正常通信

2、客户都端一定要配置通过NTP协议获取时间

3、客户端和服务器使用的NTP版本必须一致，V7交换机默认的NTP版本为4


