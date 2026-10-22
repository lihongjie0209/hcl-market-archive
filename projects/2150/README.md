# 工程名称
V7防火墙配置黑名单功能实现封禁指定ip地址


## 需求：
某企业网络管理员监测到内网vlan10内两台PC 172.16.10.5和172.16.10.6存在对server交换机sw2的报力破解行为，因某些原因暂时无法找到pc的使用人员，要求在防火墙上配置黑名单封禁上述ip地址


## 实验步骤：
**1、配置接口ip及路由，保证基础网络互通**

**2、配置防火墙接口加入安全域，g1/0/1加入trust域，g1/0/2加入server域**
#
security-zone name Trust
 import interface GigabitEthernet1/0/1
#
security-zone name server
 import interface GigabitEthernet1/0/2
#

**3、配置安全策略放行trust到server区域的流量**
#
security-policy ip
 rule 1 name trusttoserver
  action pass
  source-zone trust
  destination-zone server
#

**4、开启全局黑名单功能，将异常ip加入黑名单列表**
#
blacklist global enable
blacklist ip 172.16.10.5
#
object-group ip address blacklist
 0 network host address 172.16.10.6
#
blacklist object-group blacklist

## 测试结果：
**1、配置黑名单之前，172.16.10.5和172.16.10.6可以访问sw2上的10.0.23.3**
[SW1]ping -a 172.16.10.4 10.0.23.3
Ping 10.0.23.3 (10.0.23.3) from 172.16.10.4: 56 data bytes, press CTRL_C to break
56 bytes from 10.0.23.3: icmp_seq=0 ttl=254 time=1.000 ms
56 bytes from 10.0.23.3: icmp_seq=1 ttl=254 time=2.000 ms
56 bytes from 10.0.23.3: icmp_seq=2 ttl=254 time=4.000 ms
56 bytes from 10.0.23.3: icmp_seq=3 ttl=254 time=2.000 ms
56 bytes from 10.0.23.3: icmp_seq=4 ttl=254 time=2.000 ms

--- Ping statistics for 10.0.23.3 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss

[SW1]ping -a 172.16.10.5 10.0.23.3
Ping 10.0.23.3 (10.0.23.3) from 172.16.10.5: 56 data bytes, press CTRL_C to break
56 bytes from 10.0.23.3: icmp_seq=0 ttl=254 time=1.000 ms
56 bytes from 10.0.23.3: icmp_seq=1 ttl=254 time=1.000 ms
56 bytes from 10.0.23.3: icmp_seq=2 ttl=254 time=0.000 ms
56 bytes from 10.0.23.3: icmp_seq=3 ttl=254 time=0.000 ms
56 bytes from 10.0.23.3: icmp_seq=4 ttl=254 time=0.000 ms

--- Ping statistics for 10.0.23.3 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss

[SW1]
[SW1]ping -a 172.16.10.6 10.0.23.3
Ping 10.0.23.3 (10.0.23.3) from 172.16.10.6: 56 data bytes, press CTRL_C to break
56 bytes from 10.0.23.3: icmp_seq=0 ttl=254 time=2.000 ms
56 bytes from 10.0.23.3: icmp_seq=1 ttl=254 time=1.000 ms
56 bytes from 10.0.23.3: icmp_seq=2 ttl=254 time=2.000 ms
56 bytes from 10.0.23.3: icmp_seq=3 ttl=254 time=2.000 ms
56 bytes from 10.0.23.3: icmp_seq=4 ttl=254 time=1.000 ms

--- Ping statistics for 10.0.23.3 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss

**2、配置黑名单后，172.16.10.5和172.16.10.6无法经过FW访问任何资源**
[SW1]ping -a 172.16.10.4 10.0.23.3
Ping 10.0.23.3 (10.0.23.3) from 172.16.10.4: 56 data bytes, press CTRL_C to break
56 bytes from 10.0.23.3: icmp_seq=0 ttl=254 time=1.000 ms
56 bytes from 10.0.23.3: icmp_seq=1 ttl=254 time=1.000 ms
56 bytes from 10.0.23.3: icmp_seq=2 ttl=254 time=1.000 ms
56 bytes from 10.0.23.3: icmp_seq=3 ttl=254 time=1.000 ms
56 bytes from 10.0.23.3: icmp_seq=4 ttl=254 time=1.000 ms

--- Ping statistics for 10.0.23.3 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.000/1.000/0.000 ms
[SW1]%Jul 30 13:04:54:372 2022 SW1 PING/6/PING_STATISTICS: Ping statistics for 10.0.23.3: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/1.000/1.000/0.000 ms.

[SW1]
[SW1]ping -a 172.16.10.5 10.0.23.3
Ping 10.0.23.3 (10.0.23.3) from 172.16.10.5: 56 data bytes, press CTRL_C to break
Request time out
Request time out
Request time out
Request time out
Request time out

--- Ping statistics for 10.0.23.3 ---
5 packet(s) transmitted, 0 packet(s) received, 100.0% packet loss
[SW1]%Jul 30 13:05:07:231 2022 SW1 PING/6/PING_STATISTICS: Ping statistics for 10.0.23.3: 5 packet(s) transmitted, 0 packet(s) received, 100.0% packet loss.

[SW1]
[SW1]ping -a 172.16.10.6 10.0.23.3
Ping 10.0.23.3 (10.0.23.3) from 172.16.10.6: 56 data bytes, press CTRL_C to break
Request time out
Request time out
Request time out
Request time out
Request time out

--- Ping statistics for 10.0.23.3 ---
5 packet(s) transmitted, 0 packet(s) received, 100.0% packet loss

## 说明： 
**1、黑名单的配置方式有：IP黑名单、用户黑名单、地址对象组黑名单

2、IP黑名单根据报文过滤条件的不同，该特性可分为源IP黑名单和目的IP黑名单。源IP黑名单根据报文的源IP地址进行报文过滤，目的IP黑名单根据报文的目的IP地址进行报文过滤

3、地址对象组黑名单地是基于地址对象组进行报文过滤的一种攻击防范特性。该特性需要和地址对象组功能配合使用，由后者为其提供地址对象组和IP地址的对应关系。同IP黑名单的包过滤功能相比，地址组黑名单可以对网段进行访问控制，提高了易用性

4、若全局的黑名单过滤功能处于开启状态，则所有安全域上的IP黑名单过滤功能均处于开启状态。若全局的黑名单过滤功能处于关闭状态，则需要开启指定安全域上的黑名单过滤功能。添加IP黑名单表项的同时可以选择配置IP黑名单表项的老化时间，若不配置，那么该IP黑名单表项永不老化，除非用户手动将其删除

5、没有在黑名单里的ip地址会正常匹配安全策略，由安全策略决定是否放行**



