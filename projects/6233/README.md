# 工程名称


IPv4域名代理解析典型配置举例


## 需求：
DNS代理（DNS proxy）用来在DNS client和DNS server之间转发DNS请求和应答报文。局域网内的DNS client把DNS proxy当作DNS server，将DNS请求报文发送给DNS proxy。DNS proxy将该请求报文转发到真正的DNS server，并将DNS server的应答报文返回给DNS client，从而实现域名解析。
使用DNS proxy功能后，当DNS server的地址发生变化时，只需改变DNS proxy上的配置，无需改变局域网内每个DNS client的配置，从而简化了网络管理。

## 实验步骤：

配置AC的DNS代理功能，并且主机名test.com对应的IP地址为1.1.1.1。

<AC> system-view
[AC] dns proxy enable
[AC] ip host test.com 1.1.1.1

## 测试结果：


在DNS client上执行ping test.com命令，AC通过静态域名解析可以解析到test.com对应的IP地址为1.1.1.1。

<AP>ping test.com
Ping test.com (1.1.1.1): 56 data bytes, press CTRL_C to break
56 bytes from 1.1.1.1: icmp_seq=0 ttl=255 time=1.000 ms
56 bytes from 1.1.1.1: icmp_seq=1 ttl=255 time=0.000 ms
56 bytes from 1.1.1.1: icmp_seq=2 ttl=255 time=1.000 ms
56 bytes from 1.1.1.1: icmp_seq=3 ttl=255 time=1.000 ms
56 bytes from 1.1.1.1: icmp_seq=4 ttl=255 time=1.000 ms

--- Ping statistics for test.com ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 0.000/0.800/1.000/0.400 ms

%Nov  4 13:01:57:401 2022 ap1 PING/6/PING_STATISTICS: Ping statistics for test.com: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 0.000/0.800/1.000/0.400 ms.



## 说明： 


DNS代理的工作过程如下：
(1)        DNS client把DNS proxy当作DNS server，将DNS请求报文发送给DNS proxy，即请求报文的目的地址为DNS proxy的IP地址。
(2)        DNS proxy收到请求报文后，首先查找本地的静态域名解析表和动态域名解析表，如果存在请求的信息，则DNS proxy直接通过DNS应答报文将域名解析结果返回给DNS client。
(3)        如果不存在请求的信息，则DNS proxy将报文转发给DNS server，通过DNS server进行域名解析。
(4)        DNS proxy收到DNS server的应答报文后，记录域名解析的结果，并将报文转发给DNS client。DNS client利用域名解析的结果进行相应的处理。

只有DNS proxy上存在域名服务器地址，并存在到达域名服务器的路由，DNS proxy才会向DNS server发送域名解析请求。否则，DNS proxy不会向DNS server发送域名解析请求，也不会应答DNS client的请求。