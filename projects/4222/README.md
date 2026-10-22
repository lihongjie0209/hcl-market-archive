# 工程名称
V7交换机带验证的NTP时钟同步


## 需求：
配置内网核心交换机作为NTP服务器，下层接入交换机作为NTP客户端从核心交换机同步时间，同时开启NTP验证功能，确保验证成功后才可同步时间，验证密码为ntpkey（实际操作请使用复杂度高的密码）


## 实验步骤：
1、为交换机配置互联ip保证设备间可以正常通信

2、核心交换机开启NTP服务，并配置本地时钟作为参考时钟，层数为2

#
ntp-service enable
ntp-service refclock-master 2
#

3、核心交换机开启NTP验证，创建编号为1的NTP验证密钥，密钥值为ntpkey，以明文形式输入,并配置编号为1的密钥为可信密钥

#
 ntp-service authentication enable
 ntp-service authentication-keyid 1 authentication-mode md5 simple ntpkey
 ntp-service reliable authentication-keyid 1 
#


4、接入交换机开启NTP服务，配置通过NTP协议获取时间

#
 ntp-service enable
 clock protocol ntp
#

5、接入交换机开启NTP验证，创建编号为1的NTP验证密钥，密钥值为ntpkey，以明文形式输入,并配置编号为1的密钥为可信密钥。

#
 ntp-service authentication enable
 ntp-service authentication-keyid 1 authentication-mode md5 simple ntpkey
 ntp-service reliable authentication-keyid 1 
#


6、接入交换机设置192.168.1.1为NTP服务器，并将该服务器与编号为1的密钥关联。


#
 ntp-service unicast-server 192.168.1.1 authentication-keyid 1
#


## 测试结果：
1、查看接入交换机时间已成功同步

[NTP-Client]dis clock 
23:44:01 UTC Sat 09/17/2022

2、查看接入交换机NTP同步状态正常

[NTP-Client]dis ntp-service status 
 Clock status: synchronized    //synchronized表示同步成功
 Clock stratum: 3 
 System peer: 192.168.1.1 
 Local mode: client
 Reference clock ID: 192.168.1.1
 Leap indicator: 00
 Clock jitter: 0.000977 s
 Stability: 0.000 pps 
 Clock precision: 2^-10
 Root delay: 0.25940 ms 
 Root dispersion: 18.84460 ms 
 Reference time: e6d0da1f.d371b1e9  Sat, Sep 17 2022 23:43:27.825
[NTP-Client]

3、接入交换机上产生NTP同步成功的日志

%Sep 17 23:43:22:822 2022 NTP-Client NTP/5/NTP_CLOCK_CHANGE: System clock changed from 23:43:21:786 09/17/2022 to 23:43:22:821 09/17/2022, the NTP server's IP address is 192.168.1.1.

## 说明： 
1、NTP客户端和服务器之间必须可以正常通信

2、客户都端一定要配置通过NTP协议获取时间

3、客户端和服务器使用的NTP版本必须一致，V7交换机默认的NTP版本为4

4、客户端和服务器使用的NTP验证密码和加密算法必须一致



