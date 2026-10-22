# 工程名称

防火墙堆叠情况下irf双主。

## 需求：
防火墙做堆叠，并且要求双主运行。


## 实验步骤：
1.配置聚合接口。

2.配置地址和路由。

3.防火墙配置堆叠。

4.防火墙配置聚合口，并且放入安全域，上面放入trust，下面是untrust。放通策略trust-untrust。

5.防火墙配置会话同步。


## 测试结果：

测试能通即可。

[H3C]ping 2.2.2.1

Ping 2.2.2.1 (2.2.2.1): 56 data bytes, press CTRL_C to break

56 bytes from 2.2.2.1: icmp_seq=0 ttl=254 time=1.000 ms

56 bytes from 2.2.2.1: icmp_seq=1 ttl=254 time=1.000 ms

56 bytes from 2.2.2.1: icmp_seq=2 ttl=254 time=0.000 ms

56 bytes from 2.2.2.1: icmp_seq=3 ttl=254 time=1.000 ms

56 bytes from 2.2.2.1: icmp_seq=4 ttl=254 time=1.000 ms


## 说明： 


1.模拟器会话同步有问题，所以如果流量跨框会不通，而聚合情况下是随机选端口的，所以如果测试不通就多测测，真机不会出现这种情况。

2.现网也不推荐使用堆叠双主部署。