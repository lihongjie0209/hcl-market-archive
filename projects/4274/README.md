# 工程名称

防火墙实现V4网络访问V6服务器。

## 需求：

防火墙做VPN实例隔离内外网，并且通过AFT实现外网V4访问内网V6。源地址用动态前缀转换，目的地址静态转换。

## 实验步骤：

1.配置路由器IP和默认路由。

2.配置防火墙vpn实例。

3.配置IP。

4.配置AFT，目的地址静态转换，源地址前缀方式。

5.配置安全策略安全域，V4为外网untrust，V6为内网trust，策略v4放untrust到local，注意放通vrf。

6.接口使能


## 测试结果：

[H3C]ping 2.2.2.2

Ping 2.2.2.2 (2.2.2.2): 56 data bytes, press CTRL+C to break

56 bytes from 2.2.2.2: icmp_seq=0 ttl=63 time=1.000 ms

56 bytes from 2.2.2.2: icmp_seq=1 ttl=63 time=3.000 ms

56 bytes from 2.2.2.2: icmp_seq=2 ttl=63 time=1.000 ms

56 bytes from 2.2.2.2: icmp_seq=3 ttl=63 time=1.000 ms

56 bytes from 2.2.2.2: icmp_seq=4 ttl=63 time=3.000 ms



## 说明： 


