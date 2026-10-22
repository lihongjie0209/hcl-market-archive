# 工程名称

防火墙二层聚合口模式主备部署

## 需求：
防火墙做二层聚合口，并且通过最大选中数配置，实现主备部署。


## 实验步骤：
1.配置上下行交换机的接口和地址。

2.配置防火墙堆叠。

3.配置接口聚合并且配置最大选中数为1.

4.配置track。

5.配置冗余组，并且使用node-member来关联接口。

7.配置安全策略和安全域，上行为trust，下行为untrust，放通trust-untrust。



## 测试结果：

ping测试正常。主备切换后依旧正常。

[H3C]ping 1.1.1.2

Ping 1.1.1.2 (1.1.1.2): 56 data bytes, press CTRL_C to break

56 bytes from 1.1.1.2: icmp_seq=0 ttl=255 time=2.000 ms

56 bytes from 1.1.1.2: icmp_seq=1 ttl=255 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=2 ttl=255 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=3 ttl=255 time=1.000 ms

56 bytes from 1.1.1.2: icmp_seq=4 ttl=255 time=0.000 ms




## 说明： 

1.由于模拟器会话同步有问题，切换会导致丢包较多，真机不会这么多。
