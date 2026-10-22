# 工程名称

防火墙实现VPN实例场景下的IPSEC互通。

## 需求：

防火墙配置VRF，对应内网不同租户，并且需要防火墙建立IPSEC，实现不同地方的租户互访。

## 实验步骤：
1.配置路由器的IP和路由。

2.配置防火墙的VPN实例。

3.接口绑定VPN实例，配置地址和路由。

4.配置ike keychain，注意必须带上VRF，并且keychain是外网协商用的，所以带出接口的VRF，也是就VPN2。

5.配置ike profile，注意对端地址必须带上外网口的VRF，也就是VPN2，但是下面还需要加一条inside-vpn 标识实际业务流量从什么VRF上来，因此必须配置为VPN1。

6.配置transform和ipsec策略，这里没特殊的，直接配置即可。

7.配置安全策略和安全域，内网口为trust，外网口为untrust，并且IPSEC分为协商流量和实际业务流量，因此策略需要两条，第一个协商为ipseclocal，由于互通，因此外网到本地和本地到外网的，这个只涉及外网VRF。第二个为flow，由于感兴趣流也是互通，所以安全域也是untrust到trust，和trust到untrust，注意感兴趣流一定是从vpn1上来的，所以配置vrf1.

8.接口使能。


## 测试结果：
测试结果正常互访可以通。

ping 192.168.1.1

Ping 192.168.1.1 (192.168.1.1): 56 data bytes, press CTRL+C to break

Request time out

56 bytes from 192.168.1.1: icmp_seq=1 ttl=253 time=3.000 ms

56 bytes from 192.168.1.1: icmp_seq=2 ttl=253 time=2.000 ms

56 bytes from 192.168.1.1: icmp_seq=3 ttl=253 time=1.000 ms

56 bytes from 192.168.1.1: icmp_seq=4 ttl=253 time=2.000 ms


<H3C>ping 192.168.0.1

Ping 192.168.0.1 (192.168.0.1): 56 data bytes, press CTRL+C to break

56 bytes from 192.168.0.1: icmp_seq=0 ttl=253 time=1.000 ms

56 bytes from 192.168.0.1: icmp_seq=1 ttl=253 time=2.000 ms

56 bytes from 192.168.0.1: icmp_seq=2 ttl=253 time=2.000 ms

56 bytes from 192.168.0.1: icmp_seq=3 ttl=253 time=2.000 ms

56 bytes from 192.168.0.1: icmp_seq=4 ttl=253 time=3.000 ms


## 说明： 

1.带VRF后，如果是内访外是VRF1，但是很多人认为接受方，就应该是untrust-trust，并且放通VRF2，因为流量是从VRF2上来的，实际对IPSEC来说，封装前后不仅仅是加解封装，还会转换VRF，因此可以理解为外网流量过来解封装后，直接变为VRF1。
