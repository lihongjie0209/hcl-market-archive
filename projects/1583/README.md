# 工程名称

防火墙NAT66前缀转换，实现内网服务器映射

## 需求：
内网IPV6服务器映射到IPV6网络，并且隐藏服务器真实地址。
外网地址2000::2/96对接防火墙2000::1/96，内网地址2001::2/96防火墙作为网关，地址2001::1/96


## 实验步骤：
1.配置IPV6地址。

2.防火墙配置安全域和安全策略，1/0/2是外网口放入untrust，1/0/3是内网口放入trust，安全策略上直接放通外网到内网即可。

3.配置NAT66前缀映射。

4.配置外网路由。


## 测试结果：

测试ping 2002::2可以通到内网。

<H3C>ping ipv6  2002::2

Ping6(56 data bytes) 2000::2 --> 2002::2, press CTRL+C to break

56 bytes from 2002::2, icmp_seq=0 hlim=63 time=3.000 ms

56 bytes from 2002::2, icmp_seq=1 hlim=63 time=1.000 ms

56 bytes from 2002::2, icmp_seq=2 hlim=63 time=2.000 ms

56 bytes from 2002::2, icmp_seq=3 hlim=63 time=0.000 ms

56 bytes from 2002::2, icmp_seq=4 hlim=63 time=1.000 ms




## 说明： 

NAT66前缀映射，由于需要满足RFC要求，保持一个ip校验核不变，因此设备会自动计算填充，所以内网映射到公网必须是128位，如果是其他位数设备计算填充后，转换后的地址可能不是完全相同。
