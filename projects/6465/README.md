# 工程名称

IPv6域名静态解析典型配置举例

## 需求：
为了避免记忆复杂的IPv6地址，设备希望通过便于记忆的主机名访问某一主机。在设备上手工配置IPv6地址对应的主机名，利用静态域名解析功能，就可以实现通过主机名访问该主机。
在本例中，AC访问的主机IPv6地址为1::2，主机名为test.com。


## 实验步骤：

配置主机名test.com对应的IPv6地址为1::2。
<AC> system-view
[AC] ipv6 host host.com 1::2


## 测试结果：

执行ping ipv6 test.com命令，AC通过静态域名解析可以解析到test.com对应的IPv6地址为1::2。
[AC]ping ipv6 test.com
Ping6(56 data bytes) 1::1 --> 1::2, press CTRL_C to break
56 bytes from 1::2, icmp_seq=0 hlim=64 time=1.000 ms
56 bytes from 1::2, icmp_seq=1 hlim=64 time=0.000 ms
56 bytes from 1::2, icmp_seq=2 hlim=64 time=1.000 ms
56 bytes from 1::2, icmp_seq=3 hlim=64 time=1.000 ms
56 bytes from 1::2, icmp_seq=4 hlim=64 time=1.000 ms

--- Ping6 statistics for test.com ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 0.000/0.800/1.000/0.400 ms
[AC]%Nov  9 13:56:34:893 2022 AC PING/6/PING_STATISTICS: -MDC=1; Ping6 statistics for test.com: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 0.000/0.800/1.000/0.400 ms.


## 说明： 

无
