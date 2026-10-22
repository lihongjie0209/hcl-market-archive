# 工程名称
v7_ngfw_安全策略过滤域名


## 需求：
通过配置安全策略，禁止内网用户访访问www.baidu.com


## 实验步骤：
1、配置基本网络互通
2、配置对象组匹配www.baidu.com
#
object-group ip address baidu
 0 network host name www.baidu.com
#

3、配置安全策略rule 1规则禁止访问www.baidu.com
#
security-policy ip
 rule 1 name denybaidu
  destination-ip baidu
 rule 5 name permitdns
  action pass
  service dns-tcp
  service dns-udp
 rule 10 name toInternet
  action pass
  source-zone trust
  destination-zone untrust
#

## 测试结果：
#配置前
[Client]ping www.baidu.com
Ping www.baidu.com (1.1.1.1): 56 data bytes, press CTRL_C to break
56 bytes from 1.1.1.1: icmp_seq=0 ttl=254 time=0.913 ms
56 bytes from 1.1.1.1: icmp_seq=1 ttl=254 time=1.249 ms
56 bytes from 1.1.1.1: icmp_seq=2 ttl=254 time=1.766 ms
56 bytes from 1.1.1.1: icmp_seq=3 ttl=254 time=0.957 ms
56 bytes from 1.1.1.1: icmp_seq=4 ttl=254 time=1.231 ms

--- Ping statistics for www.baidu.com ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 0.913/1.223/1.766/0.304 ms
[Client]%Mar 28 15:27:41:587 2024 Client PING/6/PING_STATISTICS: Ping statistics for www.baidu.com: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 0.913/1.223/1.766/0.304 ms.

#配置后
[Client]ping www.baidu.com
Ping www.baidu.com (1.1.1.1): 56 data bytes, press CTRL_C to break
Request time out
Request time out
Request time out
Request time out
Request time out

--- Ping statistics for www.baidu.com ---
5 packet(s) transmitted, 0 packet(s) received, 100.0% packet loss
[Client]%Mar 28 15:29:43:321 2024 Client PING/6/PING_STATISTICS: Ping statistics for www.baidu.com: 5 packet(s) transmitted, 0 packet(s) received, 100.0% packet loss.


## 说明： 
需要防火墙开启dns代理，同时终端的dns服务器指向防火墙。

