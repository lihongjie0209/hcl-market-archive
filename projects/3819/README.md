# 工程名称

防火墙RBM下二层双主

## 需求：
防火墙做RBM并且二层双主部署，实现上行访问下行设备。


## 实验步骤：
1.配置vlan和IP地址，配置如图。

2.配置RBM，由于二层双主，因此需要使用 track interface。

3.配置bridge转发。

4.测试业务


## 测试结果：

ping测试正常，并且

<H3C>ping 10.1.1.2

Ping 10.1.1.2 (10.1.1.2): 56 data bytes, press CTRL_C to break

56 bytes from 10.1.1.2: icmp_seq=0 ttl=255 time=2.000 ms

56 bytes from 10.1.1.2: icmp_seq=1 ttl=255 time=0.000 ms

56 bytes from 10.1.1.2: icmp_seq=2 ttl=255 time=3.000 ms

56 bytes from 10.1.1.2: icmp_seq=3 ttl=255 time=1.000 ms

56 bytes from 10.1.1.2: icmp_seq=4 ttl=255 time=2.000 ms


--- Ping statistics for 10.1.1.2 ---




## 说明： 

1.接口随机选择，因此双主可能不太好测试。

2.由于二层双主备机vlan 也运行业务，因此使用track vlan模式的话需要防环。

3.本例使用 桥口转发是方便双主理解，业务实际测试还是单边运行，现网中可能是其他方式解决，也可以不用桥口。
