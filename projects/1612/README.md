# OSPF database-filter配置

**标签：**

**OSPF**

## 需求

当两台路由器之间存在多条链路时，根据过滤策略，通过命令ospf
filter-lsa-out配置本地路由器在某些链路上对LSA的过滤，减少不必要的重传，节省带宽资源。

## 实验步骤：

1、配置各接口的IP地址

2、配置OSPF

3、配置ospf database-filter

通过对OSPF接口出方向的LSA进行过滤可以不向邻居发送无用的LSA，从而减少邻居LSDB的大小，提高网络收敛速度。

ospf database-filter命令用来对接口出方向的LSA进行过滤。

all：对接口出方向的所有LSA（除了Grace LSA）进行过滤。

ase：对接口出方向的Type-5 LSA进行过滤。

nssa：对接口出方向的Type-7 LSA进行过滤。

summary：对接口出方向的Type-3 LSA进行过滤。

acl ipv4-acl-number：指定基本或高级IPv4
ACL编号用于过滤，ipv4-acl-number的取值范围为2000～3999。#
配置在接口GigabitEthernet1/0/1上对出方向的所有LSA进行过滤。

其中，source用来过滤LSA的链路状态ID，destination用来过滤LSA的掩码，配置的掩码应该是连续的（当配置的掩码不连续时该过滤掩码的规则不生效）。

## 测试结果：

过滤三类LSA示例：

原先RTA的路由：

![](./Media//image1.png)


RTB配置：

\#

acl basic 2000

rule 5 deny source 3.3.3.3 0

rule 10 permit #过滤，缺省都是拒绝，最后一条务必放通。

\#

interface GigabitEthernet0/0

ip address 10.1.1.2 255.255.255.252

ospf database-filter summary acl 2000

\#

注意：配置后邻居会重新建立。

\[RTB-GigabitEthernet0/0\]ospf database-filter summary acl 2000

\[RTB-GigabitEthernet0/0\]%Jul 15 14:28:11:567 2022 RTB
OSPF/5/OSPF_NBR_CHG: OSPF 1 Neighbor 10.1.1.1(GigabitEthernet0/0)
changed from FULL to DOWN.

RTA重启OSPF进程，此时发现关于3.3.3.3的LSA与路由消失。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
