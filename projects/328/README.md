**标签：**

OSPF v3

安全策略

**需求：**

使用防火墙和路由器搭建OSPF
V3的环境，确定防火墙上需要安全策略细化的配置。

**实验步骤：**

1.  设置F1060_1和MSR3620_2建立OSPF V3；

2.  将GigabitEthernet1/0/0加入安全域
    Untrust；配置FW上的地址2012::1/64，配置MSR上的地址是2012::2;

3.  查看FW的链路本地地址：dis ipv6 int GigabitEthernet
    1/0/0（FE80::3E1E:18FF:FE58:105）

> 查看MSR上的链路本地地址：dis ipv6 int g 0/0
>
> （FE80::3E1E:24FF:FE14:205）

4.  在防火墙创建3个地址对象组：

![](./Media//image1.png)


5.  首先应该放通的安全策略是Untrust和local之间双向互通、地址对象组1和地址对象组3之间的互访（这是基本的放通）；

![](./Media//image2.png)


6.  打开设备上的 debugging security-policy packet
    ipv6，根据deny的信息，逐步的细化安全策略。设备会打印如下的日志：

\<H3C\>\*Jan 21 17:53:43:668 2022 H3C FILTER/7/PACKET: -Context=1; The
packet is denied. Src-Zone=Local,
Dst-Zone=Untrust;If-In=InLoopBack0(1284),
If-Out=GigabitEthernet1/0/0(1); Packet
Info:Src-IP=fe80::3e1e:18ff:fe58:105, Dst-IP=ff02::5,
VPN-Instance=,Src-Port=65535, Dst-Port=65535, Protocol=OSPFIGP(89),
Application=invalid(0), ACL=none, Rule-ID=none.

> 此时就要再放通

![](./Media//image3.png)


7.  再次打开debugging security-policy packet
    ipv6，设备会打印如下的日志：

\*Jan 21 17:56:30:818 2022 H3C FILTER/7/PACKET: -Context=1; The packet
is denied. Src-Zone=Untrust,
Dst-Zone=Local;If-In=GigabitEthernet1/0/0(1), If-Out=NULL0(1283); Packet
Info:Src-IP=fe80::3e1e:24ff:fe14:205, Dst-IP=ff02::5,
VPN-Instance=,Src-Port=65535, Dst-Port=65535, Protocol=OSPFIGP(89),
Application=invalid(0), ACL=none, Rule-ID=none.

所以需要在设备上增叫一条

![](./Media//image4.png)


汇总rule 0/1/2来看

![](./Media//image5.png)


测试结果：

FW的链路本地地址：

![](./Media//image6.png)


MSR的链路本地地址：

![](./Media//image7.png)


OSPFV3的建立情况。

![](./Media//image8.png)


**说明：**

本实验需要有IPV6组播的的是实验基础，debugging security-policy packet
ipv6后面尽量跟上ACL，防止打印信息过多。
