# 工程名称
防火墙做RBM，结合OSPF实现主备

## 需求：

防火墙做RBM，结合动态OSPF实现主备。
上下行路由器用OSPF，并且用loopback接口模拟业务。
地址如组网所示
## 实验步骤：
1.配置地址。

2.配置RBM，主备模式，并且切换后路由会变成COST1000。

3.配置安全策略和安全域，上行为trust，下行为untrust。放通trust-untrust，而且放通OSPF协商报文。

4.配置OSPF。注意防火墙的router id。

5.配置上下行设备的地址和OSPF。

6.配置track，并且补充到RBM中。




## 测试结果：

查看路由表，发现路由cost为10.
<H3C>dis ip routing-table

Destinations : 17       Routes : 17

Destination/Mask   Proto   Pre Cost        NextHop         Interface

0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0

2.2.2.0/24         Direct  0   0           2.2.2.2         GE0/0

2.2.2.2/32         Direct  0   0           127.0.0.1       InLoop0

2.2.2.255/32       Direct  0   0           2.2.2.2         GE0/0

3.3.3.0/24         Direct  0   0           3.3.3.2         GE0/1

3.3.3.2/32         Direct  0   0           127.0.0.1       InLoop0

3.3.3.255/32       Direct  0   0           3.3.3.2         GE0/1

4.4.4.0/24         O_INTRA 10  2           2.2.2.1         GE0/0

5.5.5.0/24         O_INTRA 10  3           2.2.2.1         GE0/0

10.1.1.1/32        Direct  0   0           127.0.0.1       InLoop0

20.1.1.1/32        O_INTRA 10  2           2.2.2.1         GE0/0

ping测试正常。

<H3C>ping -a 10.1.1.1 20.1.1.1

Ping 20.1.1.1 (20.1.1.1) from 10.1.1.1: 56 data bytes, press CTRL+C to break

56 bytes from 20.1.1.1: icmp_seq=0 ttl=254 time=0.000 ms


将主设备down一个接口后，再进行查看，发现路由下一跳改变。并且ping也正常。

<H3C>dis ip routing-table

Destinations : 14       Routes : 14

Destination/Mask   Proto   Pre Cost        NextHop         Interface

0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0

3.3.3.0/24         Direct  0   0           3.3.3.2         GE0/1

3.3.3.2/32         Direct  0   0           127.0.0.1       InLoop0

3.3.3.255/32       Direct  0   0           3.3.3.2         GE0/1

4.4.4.0/24         O_INTRA 10  3           3.3.3.1         GE0/1

5.5.5.0/24         O_INTRA 10  2           3.3.3.1         GE0/1

10.1.1.1/32        Direct  0   0           127.0.0.1       InLoop0

20.1.1.1/32        O_INTRA 10  2           3.3.3.1         GE0/1



<H3C>ping -a 10.1.1.1 20.1.1.1

Ping 20.1.1.1 (20.1.1.1) from 10.1.1.1: 56 data bytes, press CTRL+C to break

56 bytes from 20.1.1.1: icmp_seq=0 ttl=254 time=1.000 ms



## 说明： 


1.模拟器RBM不能会话同步，因此没测试丢包情况。