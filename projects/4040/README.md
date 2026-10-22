# 工程名称

防火墙跨VRF实现nat server功能

## 需求：
防火墙配置NAT server访问内部服务器，并且内外网口的VRF不同进行隔离。


## 实验步骤：
1.配置PC的IP。

2.配置VRF。

3.接口绑定vrf,配置IP。

4.配置NAT server。

5.配置安全策略和安全域，外网口为untrust，内网为trust，放通untrust到trust，并且由于nat server转换了VRF，因此策略只用放通vrf vpn2的，路由也只用考虑回程路由。

6测试


## 测试结果：
测试ping正常。

ping 3.3.3.3

Ping 3.3.3.3 (3.3.3.3): 56 data bytes, press CTRL_C to break

56 bytes from 3.3.3.3: icmp_seq=0 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=1 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=2 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=3 ttl=254 time=1.000 ms

56 bytes from 3.3.3.3: icmp_seq=4 ttl=254 time=1.000 ms


## 说明： 
nat server在接口转换，并且是转换VRF实例的，因此进入安全策略时就只有vpn2了，路由也会自动去vpn2查，因此只用考虑回程路由即可。回程需要路由指到接口后， 设备才会做nat server以及vrf的转换。
