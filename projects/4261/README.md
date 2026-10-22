# 工程名称

防火墙在vpn实例场景下，映射V4服务器到V6网络

## 需求：

防火墙做VPN实例隔离，但是需要V6网络能访问V4服务器。

## 实验步骤：
1.配置路由器的地址和路由。

2.配置防火墙vpn实例。

3.配置防火墙IP和vpn实例绑定。

4.配置AFT。源地址动态转换，目的地址用静态一对一映射

5.配置安全策略和安全域，左边为untrust，右边为trust，V6放通untrust到local，v4放通local到trust。注意对应的VPN实例。


## 测试结果：

ping测试可以通即可。


ping ipv6  2001::1

Ping6(56 data bytes) 2000::1 --> 2001::1, press CTRL+C to break

56 bytes from 2001::1, icmp_seq=0 hlim=254 time=2.000 ms

56 bytes from 2001::1, icmp_seq=1 hlim=254 time=1.000 ms

56 bytes from 2001::1, icmp_seq=2 hlim=254 time=1.000 ms

56 bytes from 2001::1, icmp_seq=3 hlim=254 time=1.000 ms

56 bytes from 2001::1, icmp_seq=4 hlim=254 time=0.000 ms



## 说明： 

