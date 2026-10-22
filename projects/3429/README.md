# 工程名称

防火墙做RBM结合VRRP实现主备

## 需求：
防火墙做RBM，利用VRRP实现主备，让上下行交换机访问。


## 实验步骤：

1.配置地址，如组网图。

2.交换机配置到虚地址的默认路由。

3.防火墙配置RBM。

4.防火墙配置安全策略和安全域，由于有VRRP,安全策略中放通VRRP，安全域上行为trust，下行为untrust，可以互通，本实验只放通trust-untrust。

5.配置VRRP。


## 测试结果：
测试上下行访问可以ping通即可。
[H3C]ping 4.4.4.3

Ping 4.4.4.3 (4.4.4.3): 56 data bytes, press CTRL_C to break

56 bytes from 4.4.4.3: icmp_seq=0 ttl=254 time=2.000 ms

56 bytes from 4.4.4.3: icmp_seq=1 ttl=254 time=2.000 ms

56 bytes from 4.4.4.3: icmp_seq=2 ttl=254 time=2.000 ms

56 bytes from 4.4.4.3: icmp_seq=3 ttl=254 time=1.000 ms

56 bytes from 4.4.4.3: icmp_seq=4 ttl=254 time=1.000 ms




## 说明： 

1.安全策略放VRRP是防止RBM断开后VRRP无法正常协商导致双主，RBM正常时放不放都可以。
