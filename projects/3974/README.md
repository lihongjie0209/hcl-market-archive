# 工程名称

防火墙二层聚合双主

## 需求：
防火墙做二层部署，并且使用堆叠双主，接口使用聚合模式。


## 实验步骤：
1.配置交换机的vlan和地址。

2.配置防火墙堆叠。

3.配置防火墙二层口。

4.配置防火墙聚合。

5.配置策略和安全域，上行为trust，下行为trust，策略放通trust-untrust。


## 测试结果：
ping可以通即可。


ping 1.1.1.2

Ping 1.1.1.2 (1.1.1.2): 56 data bytes, press CTRL_C to break

56 bytes from 1.1.1.2: icmp_seq=0 ttl=255 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=1 ttl=255 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=2 ttl=255 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=3 ttl=255 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=4 ttl=255 time=1.000 ms





## 说明： 

1.会话同步有问题，所以如果跨框可能不同，真机不存在这个问题。
