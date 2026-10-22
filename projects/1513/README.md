# 工程名称

防火墙单机AFT利用前缀模式对外提供服务

## 需求：
防火墙作为出口网关，内网网关地址为192.168.1.1/24，交换机纯二层，内网服务器用PC模拟，地址分别为192.168.1.2/24和192.168.1.3/24。外网路由器模拟IPV6外网用户，地址为2001::2/96,防火墙外网地址为2001::1/96.


需求为外网用户访问相同前缀2002::/96,跟上IPV4地址可以对应访问内部网络，并且外网地址不固定。


## 实验步骤：

1.配置IP。

2.配置安全域和安全策略，外网口1/0/2在untrust，内网口1/0/3在trust。由于只有外网访问内网需求，因此IPV6侧放通untrust到local，IPV4侧放通local到trust。

3.配置AFT及地址池，目的地址转利用general 模式的前缀转换，源地址转利用AFT地址池。并且内外网口使能。注意动态转换必须使用ACL过滤，本案例是全部匹配，实际可以根据需求更改过滤条件。

4.配置路由，IPV6侧配置到2002::/96位路由，指向防火墙。

## 测试结果：

测试IPV6网络可以直接访问两个服务器。

[H3C]ping ipv6  2002::192.168.1.2

Ping6(56 data bytes) 2001::2 --> 2002::C0A8:102, press CTRL+C to break

56 bytes from 2002::C0A8:102, icmp_seq=0 hlim=254 time=1.000 ms

56 bytes from 2002::C0A8:102, icmp_seq=1 hlim=254 time=1.000 ms

56 bytes from 2002::C0A8:102, icmp_seq=2 hlim=254 time=1.000 ms

56 bytes from 2002::C0A8:102, icmp_seq=3 hlim=254 time=5.000 ms

56 bytes from 2002::C0A8:102, icmp_seq=4 hlim=254 time=2.000 ms


[H3C]ping ipv6  2002::192.168.1.3

Ping6(56 data bytes) 2001::2 --> 2002::C0A8:103, press CTRL+C to break

56 bytes from 2002::C0A8:103, icmp_seq=0 hlim=254 time=2.000 ms

56 bytes from 2002::C0A8:103, icmp_seq=1 hlim=254 time=1.000 ms

56 bytes from 2002::C0A8:103, icmp_seq=2 hlim=254 time=2.000 ms

56 bytes from 2002::C0A8:103, icmp_seq=3 hlim=254 time=2.000 ms

56 bytes from 2002::C0A8:103, icmp_seq=4 hlim=254 time=2.000 ms




## 说明： 


