# 工程名称

IPv6域名代理解析典型配置举例

## 需求：

DNS代理（DNS proxy）用来在DNS client和DNS server之间转发DNS请求和应答报文。局域网内的DNS client把DNS proxy当作DNS server，将DNS请求报文发送给DNS proxy。DNS proxy将该请求报文转发到真正的DNS server，并将DNS server的应答报文返回给DNS client，从而实现域名解析。 使用DNS proxy功能后，当DNS server的地址发生变化时，只需改变DNS proxy上的配置，无需改变局域网内每个DNS client的配置，从而简化了网络管理。


## 实验步骤：

配置AC的DNS代理功能，并且主机名test.com对应的IP地址为1::1。
<AC> system-view
[AC] dns proxy enable
[AC] ipv6 host host.com 1::1


## 测试结果：

AP上执行ping ipv6 test.com命令，AC通过域名代理解析可以解析到test.com对应的IPv6地址为1::1。

[AP]ping ipv6 test.com
Ping6(56 data bytes) 1::2 --> 1::1, press CTRL_C to break
56 bytes from 1::1, icmp_seq=0 hlim=64 time=1.000 ms
56 bytes from 1::1, icmp_seq=1 hlim=64 time=1.000 ms
56 bytes from 1::1, icmp_seq=2 hlim=64 time=1.000 ms
56 bytes from 1::1, icmp_seq=3 hlim=64 time=1.000 ms
56 bytes from 1::1, icmp_seq=4 hlim=64 time=0.000 ms

--- Ping6 statistics for test.com ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 0.000/0.800/1.000/0.400 ms


%Nov  9 16:27:01:753 2022 34ca-61d9-0200 PING/6/PING_STATISTICS: Ping6 statistics for test.com: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 0.000/0.800/1.000/0.400 ms.



## 说明： 

DNS client上需要添加dns server为AC。
