# 工程名称
防火墙单机AFT静态模式实现互访

标签
AFT


## 需求：

内网为IPV4网络，并且PC模拟服务器2.2.2.2地址对外提供服务，外网RT模拟服务器，以2000::2对外提供服务，现在需要两个服务器互相访问资源，防火墙内网地址为1.1.1.1/24，与交换机1.1.1.2/24对接，交换机作为内网网关2.2.2.1/24.同时防火墙对外网地址为2000::1/96


现场需要两个服务器能实现互访，并且过防火墙进行做地址转换。IPV6网络访问2222::2到内网2.2.2.2.IPV4内网访问200.0.0.2到IPV62000::2
## 实验步骤：

1.配置IP地址。

2.配置安全域和安全策略，外网1/0/3放入untrust域，内网1/0/2放入trust域，并且由于AFT逻辑上是防火墙本地发出，类似代理，因此策略上IPV4侧local-trust放互通，IPV6侧放local-untrust互通。

3.配置AFT，并且内外网口同时使能。

4.配置路由，RT路由访问2222::2/128指向防火墙，内网交换机配置路由200.0.0.2/32指向防火墙

## 测试结果：
IPV4访问200.0.0.2到IPV6网络，测试正常可达。

ping 200.0.0.2

Ping 200.0.0.2 (200.0.0.2): 56 data bytes, press CTRL_C to break

56 bytes from 200.0.0.2: icmp_seq=0 ttl=62 time=2.000 ms

56 bytes from 200.0.0.2: icmp_seq=1 ttl=62 time=1.000 ms

56 bytes from 200.0.0.2: icmp_seq=2 ttl=62 time=1.000 ms

56 bytes from 200.0.0.2: icmp_seq=3 ttl=62 time=1.000 ms

56 bytes from 200.0.0.2: icmp_seq=4 ttl=62 time=2.000 ms


IPV6访问2222::2到IPV4网络，测试正常可达。
[H3C]ping ipv6 2222::2

Ping6(56 data bytes) 2000::2 --> 2222::2, press CTRL+C to break

56 bytes from 2222::2, icmp_seq=0 hlim=253 time=1.000 ms


56 bytes from 2222::2, icmp_seq=1 hlim=253 time=2.000 ms

56 bytes from 2222::2, icmp_seq=2 hlim=253 time=1.000 ms

56 bytes from 2222::2, icmp_seq=3 hlim=253 time=1.000 ms

56 bytes from 2222::2, icmp_seq=4 hlim=253 time=1.000 ms




## 说明： 

防火墙路由器交换机等都使用默认内存。
