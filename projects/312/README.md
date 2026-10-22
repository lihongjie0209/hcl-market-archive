**IPv6 VRRP单备份组配置举例**

**标签：**

**IPV6**

**VRRP**

**需求：**

•   Router A和Router B属于虚拟IPv6地址为1::10/64和FE80::10的备份组1；

•   Host A需要访问Internet上的Host B；Host
A通过路由器发送的RA消息学习到缺省网关地址为1::10/64；

• 当Router A正常工作时，Host A发送给Host B的报文通过Router
A转发；当Router A出现故障时，Host A发送给Host B的报文通过Router B转发。

**实验步骤：**

1.  配置各个设备的地址。保证路由互通。

2.  配置RouterA 和RouterB接口下IPV6
    VRRP的虚拟地址FE80：：10和1：：10，并配置

Router A在备份组1中的优先级为110，高于Router B的优先级100，以保证Router
A成为Master负责转发流量。其中，配置Router A工作在抢占方式，以保证Router
A故障恢复后，能再次抢占成为Master，即只要Router A正常工作，就由Router
A负责转发流量。为了避免频繁地进行状态切换，配置抢占延迟时间为5000厘秒。

**测试结果：**

配置完成后，在Host A上可以ping通Host B。通过display vrrp ipv6
verbose命令查看配置后的结果。

\[Router A\]display vrrp ipv6

IPv6 Virtual Router Information:

Running mode : Standard

Total number of virtual routers : 1

Interface VRID State Running Adver Auth Virtual

Pri Timer Type IP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE0/0 1 Master 110 100 None FE80::10

\[RouterB\]display vrrp ipv6

IPv6 Virtual Router Information:

Running mode : Standard

Total number of virtual routers : 1

Interface VRID State Running Adver Auth Virtual

Pri Timer Type IP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE0/0 1 Backup 100 100 None FE80::10

此时在HOST A上ping HOST B回环口地址5：：1可以通：

\[H3C\]ping ipv6 5::1

Ping6(56 data bytes) 1::111 \--\> 5::1, press CTRL+C to break

56 bytes from 5::1, icmp_seq=0 hlim=63 time=3.000 ms

56 bytes from 5::1, icmp_seq=1 hlim=63 time=1.000 ms

56 bytes from 5::1, icmp_seq=2 hlim=63 time=1.000 ms

56 bytes from 5::1, icmp_seq=3 hlim=63 time=2.000 ms

56 bytes from 5::1, icmp_seq=4 hlim=63 time=2.000 ms

此时，模拟Router A故障，对Router A进行关机

**\<Router A\>reboot**

Start to check configuration with next startup configuration file,
please wait\...\...\...DONE!

This command will reboot the device. Continue? \[Y/N\]:y

Now rebooting, please wait\...

%May 11 10:47:26:713 2022 Router A DEV/5/SYSTEM_REBOOT: System is
rebooting now.

**设备B切换了VRRP状态**

\[RouterB\]%May 11 10:42:40:985 2022 RouterB VRRP6/6/VRRP_STATUS_CHANGE:

The status of IPv6 virtual router 1 (configured on GigabitEthernet0/0)
changed **from Backup to Master: Master-down-timer expired.**

**\<RouterB\>dis vrrp ipv6**

IPv6 Virtual Router Information:

Running mode : Standard

Total number of virtual routers : 1

Interface VRID State Running Adver Auth Virtual

Pri Timer Type IP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE0/0 1 Master 100 100 None FE80::10

\<RouterB\>

此时可以继续ping通HOST B

\[H3C\]ping ipv6 5::1

Ping6(56 data bytes) 1::111 \--\> 5::1, press CTRL+C to break

56 bytes from 5::1, icmp_seq=0 hlim=63 time=2.000 ms

56 bytes from 5::1, icmp_seq=1 hlim=63 time=2.000 ms

56 bytes from 5::1, icmp_seq=2 hlim=63 time=2.000 ms

56 bytes from 5::1, icmp_seq=3 hlim=63 time=2.000 ms

56 bytes from 5::1, icmp_seq=4 hlim=63 time=1.000 ms

**说明：**

1、本实验用的模拟器为MSR36-20，设置内存为默认。

（如果用的是vsr-88或其他需要自己调整内存的设备，请注明设备所设置的内存是多少。）

2、本实验用的路由器版本为默认。

（默认是B75分支，如果所用的vmdk版本是B59或者其他定制版本，请说明，并告知vmdk放在什么地方可共享，如：本实验所用设备vmdk版本为B59，vmdk文件及更换版本操作方法均放在ftp，路径为：新版本已上传FTP：/01-IP网络产品/03-中低端路由器（AR、MSR、ICG、VG、LA）/99
临时目录/模拟器/模拟器版本/）

3、建议工程模拟器设备名称为体统默认。
