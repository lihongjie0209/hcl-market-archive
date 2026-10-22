# IPV4 VRRP单备份组配置举例

## 需求： 

 Host A需要访问Internet上的Host B，Host
A的缺省网关为10.1.1.111/24；当Router A正常工作时，Host A发送给Host
B的报文通过Router A转发；当Router A出现故障时，Host A发送给Host
B的报文通过Router B转发。

## 测试结果：

1.  显示Router A备份组信息

\[Router A\]display vrrp

IPv4 Virtual Router Information:

Running mode : Standard

Total number of virtual routers : 1

Interface VRID State Running Adver Auth Virtual

Pri Timer Type IP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE0/0 1 Master 110 100 Not supported 10.1.1.111

\[RouterB\]display vrrp

IPv4 Virtual Router Information:

Running mode : Standard

Total number of virtual routers : 1

Interface VRID State Running Adver Auth Virtual

Pri Timer Type IP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE0/0 1 Backup 100 100 Not supported 10.1.1.111

此时将ROUTER A的上下行接口均关闭，

\[H3C\]ping 5.1.1.1

Ping 5.1.1.1 (5.1.1.1): 56 data bytes, press CTRL+C to break

56 bytes from 5.1.1.1: icmp_seq=0 ttl=254 time=2.000 ms

56 bytes from 5.1.1.1: icmp_seq=1 ttl=254 time=1.000 ms

56 bytes from 5.1.1.1: icmp_seq=2 ttl=254 time=0.000 ms

56 bytes from 5.1.1.1: icmp_seq=3 ttl=254 time=0.000 ms

56 bytes from 5.1.1.1: icmp_seq=4 ttl=254 time=2.000 ms

\[RouterB\]%May 13 15:18:23:250 2022 RouterB VRRP6/6/VRRP_STATUS_CHANGE:

The status of IPv6 virtual router 1 (configured on GigabitEthernet0/0)
changed from Backup to Master: Zero priority packet received.

此时，VRRP发生了主备切换。

\[RouterB\]dis vrrp

IPv4 Virtual Router Information:

Running mode : Standard

Total number of virtual routers : 1

Interface VRID State Running Adver Auth Virtual

Pri Timer Type IP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

GE0/0 1 Master 100 100 Not supported 10.1.1.111

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
