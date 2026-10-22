# 工程名称


IPv4域名静态解析典型配置举例


## 需求：
静态域名解析就是手工建立域名和IP地址之间的对应关系。当用户使用域名进行某些应用（如telnet应用）时，系统查找静态域名解析表，从中获取指定域名对应的IP地址。

如图所示，通过配置静态域名解析功能实现主机名test.com来代替使用IP地址访问test。

## 实验步骤：

配置主机名test.com对应的IP地址为1.1.1.2。
<AC> system-view
[AC] ip host test.com 1.1.1.2

## 测试结果：

执行ping test.com命令，AC通过静态域名解析可以解析到test.com对应的IP地址为1.1.1.2。

[AC]ping test.com
Ping test.com (1.1.1.2): 56 data bytes, press CTRL_C to break
56 bytes from 1.1.1.2: icmp_seq=0 ttl=255 time=0.000 ms
56 bytes from 1.1.1.2: icmp_seq=1 ttl=255 time=1.000 ms
56 bytes from 1.1.1.2: icmp_seq=2 ttl=255 time=0.000 ms
56 bytes from 1.1.1.2: icmp_seq=3 ttl=255 time=0.000 ms
56 bytes from 1.1.1.2: icmp_seq=4 ttl=255 time=1.000 ms

--- Ping statistics for test.com ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 0.000/0.400/1.000/0.490 ms
%Nov  4 12:46:41:262 2022 H3C PING/6/PING_STATISTICS: -MDC=1; Ping statistics for test.com: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 0.000/0.400/1.000/0.490 ms.


## 说明： 

DNS client上需要添加dns server为AC。

域名解析分为静态域名解析和动态域名解析，二者可以配合使用。在解析域名时，首先采用静态域名解析（查找静态域名解析表），如果静态域名解析不成功，再采用动态域名解析。由于动态域名解析可能会花费一定的时间，且需要域名服务器的配合，因而可以将一些常用的域名放入静态域名解析表中，这样可以大大提高域名解析效率。