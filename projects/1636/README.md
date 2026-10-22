# IPv6 BGP与BFD联动配置

**标签：**

**BGP**

## 需求

在AS 200内使用OSPFv3作为IGP协议，实现AS内的互通。

Router A与Router C之间建立两条IBGP连接。当Router A与Router
C之间的两条路径均连通时，Router C与1200::0/64之间的报文使用Router
A\<－\>Router B\<－\>Router C这条路径转发；当Router A\<－\>Router
B\<－\>Router C这条路径发生故障时，BFD能够快速检测并通告IPv6
BGP协议，使得Router A\<－\>Router D\<－\>Router C这条路径能够迅速生效。

## 实验步骤：

1、配置各接口的IPv6地址

2、配置OSPFv3，保证RTA和RTC之间的路由可达。

3、配置BGP，并应用BFD

以RTA为例：

\#

bgp 200

router-id 1.1.1.1

peer 2002::2 as-number 200

peer 3002::2 as-number 200

peer 3002::2 bfd

\#

address-family ipv6 unicast

network 1200:: 64

peer 2002::2 enable

peer 2002::2 route-policy apply_med_100 export

peer 3002::2 enable

peer 3002::2 route-policy apply_med_50 export

\#

route-policy apply_med_100 permit node 10

if-match ipv6 address acl 2000

apply cost 100

\#

route-policy apply_med_50 permit node 10

if-match ipv6 address acl 2000

apply cost 50

\#

\#

acl ipv6 basic 2000

rule 0 permit source 1200::/64

\#

配置路由策略的目的：配置当Router A与Router
C之间的两条路径均连通时，Router C与1200::0/64之间的报文使用Router
A\<－\>Router B\<－\>Router C这条路径转发。

## 测试结果：

显示Router C的BFD信息。可以看出，Router A和Router
C之间已经建立了BFD会话，而且BFD协议运行正常。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
