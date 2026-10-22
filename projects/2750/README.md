# 工程名称

防火墙做LLB，并且实现LLB的选路

## 需求：

防火墙做LLB，并且实现选路，10.1.1.1只能通过2.2.2.1访问，20.1.1.1只能通过3.3.3.1访问。
PC模拟终端
地址如图，注意为了保证走错路径无法访问，路由必须如图。

## 实验步骤：
1.配置地址和路由，注意路由MSR3只有10.1.1.1的，MSR4只有20.1.1.1的，防火墙不需要路由。

2.配置安全策略和安全域，内网trust，外网untrust，放通trust-untrust，并且放通检测的流量，local-untrust。

3.配置nqa探测，注意配置出接口。

4.配置链路，链路组和虚服务。由于需要分开选路，因此创建两个链路组。

5.配置负载均衡类，负载均衡动作和负载均衡策略。

6.配置NAT。


## 测试结果：
直接在PC上ping两个地址，防火墙没有路由也能通，说明LLB正常，并且是按照要求选路。
ping 10.1.1.1

Ping 10.1.1.1 (10.1.1.1): 56 data bytes, press CTRL_C to break

56 bytes from 10.1.1.1: icmp_seq=0 ttl=254 time=3.000 ms

56 bytes from 10.1.1.1: icmp_seq=1 ttl=254 time=3.000 ms

56 bytes from 10.1.1.1: icmp_seq=2 ttl=254 time=1.000 ms

56 bytes from 10.1.1.1: icmp_seq=3 ttl=254 time=1.000 ms

56 bytes from 10.1.1.1: icmp_seq=4 ttl=254 time=1.000 ms



ping 20.1.1.1

Ping 20.1.1.1 (20.1.1.1): 56 data bytes, press CTRL_C to break

56 bytes from 20.1.1.1: icmp_seq=0 ttl=254 time=12.000 ms

56 bytes from 20.1.1.1: icmp_seq=1 ttl=254 time=0.000 ms

56 bytes from 20.1.1.1: icmp_seq=2 ttl=254 time=4.000 ms

56 bytes from 20.1.1.1: icmp_seq=3 ttl=254 time=4.000 ms

56 bytes from 20.1.1.1: icmp_seq=4 ttl=254 time=4.000 ms



## 说明： 

正常情况一个链路可以加多个链路组，但是由于模拟器版本问题，只能测试选路，现网可以加一个默认链路组放入所有链路或者随机选一个做默认链路组。
