# 工程名称

RBM+VRRP，实现主备部署，并且将上下行互通。

## 需求：
防火墙做RBM+VRRP，实现上下行交换机的loopback接口互通。并且可以做主备切换。



## 实验步骤：
1.配置IP和路由。

2.配置loopback接口。

3.配置RBM。

4.配置VRRP。

5.配置安全域和安全策略，上行为untrust域，下行为trust域。并且实现互通。


## 测试结果：

loopback接口可以互通。

ping -a 4.4.4.1 3.3.3.1

Ping 3.3.3.1 (3.3.3.1) from 4.4.4.1: 56 data bytes, press CTRL_C to break

56 bytes from 3.3.3.1: icmp_seq=0 ttl=254 time=2.000 ms

56 bytes from 3.3.3.1: icmp_seq=1 ttl=254 time=1.000 ms

56 bytes from 3.3.3.1: icmp_seq=2 ttl=254 time=1.000 ms

56 bytes from 3.3.3.1: icmp_seq=3 ttl=254 time=1.000 ms

56 bytes from 3.3.3.1: icmp_seq=4 ttl=254 time=0.000 ms


ping -a 3.3.3.1 4.4.4.1

Ping 4.4.4.1 (4.4.4.1) from 3.3.3.1: 56 data bytes, press CTRL_C to break

56 bytes from 4.4.4.1: icmp_seq=0 ttl=254 time=1.000 ms

56 bytes from 4.4.4.1: icmp_seq=1 ttl=254 time=0.000 ms

56 bytes from 4.4.4.1: icmp_seq=2 ttl=254 time=1.000 ms

56 bytes from 4.4.4.1: icmp_seq=3 ttl=254 time=0.000 ms

56 bytes from 4.4.4.1: icmp_seq=4 ttl=254 time=1.000 ms




## 说明： 
无

