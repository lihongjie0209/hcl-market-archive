# Gre over Gre配置

**标签：**

**Gre**

## 需求

总部与分支之间可以互访；分支之间不访问。PE-1、PE-2之间访问通过GRE隧道；PE-1、PE-3之间访问通过GRE
over
GRE隧道（不仅在公网实现数据封装，在私网也实现数据封装），即PE-1访问PE-3时，PE-1到PE-2之间的流量是双层GRE。

## 实验步骤：

配置参考如下。

PE-1:

\#

sysname PE-1

\#

interface LoopBack0

ip address 1.1.1.1 255.255.255.255

\#

interface GigabitEthernet0/0

ip address 10.1.1.1 255.255.255.252

\#

interface GigabitEthernet0/1

ip address 192.168.1.1 255.255.255.0

\#

interface Tunnel0 mode gre

ip address 172.16.1.1 255.255.255.252

source 10.1.1.1

destination 10.1.1.2

\#

interface Tunnel1 mode gre

ip address 172.17.1.1 255.255.255.252

source 1.1.1.1

destination 2.2.2.2

\#

PE-2:

\#

sysname PE-2

\#

interface GigabitEthernet0/0

ip address 10.1.1.2 255.255.255.252

\#

interface GigabitEthernet0/1

ip address 10.1.2.2 255.255.255.252

\#

interface GigabitEthernet0/2

ip address 192.168.2.1 255.255.255.0

\#

interface Tunnel0 mode gre

ip address 172.16.1.2 255.255.255.252

source 10.1.1.2

destination 10.1.1.1

\#

ip route-static 1.1.1.1 32 Tunnel0

ip route-static 2.2.2.2 32 10.1.2.1

ip route-static 192.168.1.0 24 Tunnel0

\#

PE-3:

\#

sysname PE-3

\#

interface LoopBack0

ip address 2.2.2.2 255.255.255.255

\#

interface GigabitEthernet0/0

ip address 10.1.2.1 255.255.255.252

\#

interface GigabitEthernet0/1

ip address 192.168.3.1 255.255.255.0

\#

interface Tunnel0 mode gre

ip address 172.17.1.2 255.255.255.252

source 2.2.2.2

destination 1.1.1.1

\#

ip route-static 1.1.1.1 32 10.1.2.2

ip route-static 192.168.1.0 24 Tunnel0

\#

## 测试结果：

配置完成后ZongBu可以访问分支。

\<ZongBu\>ping 192.168.3.2

Ping 192.168.3.2 (192.168.3.2): 56 data bytes, press CTRL+C to break

56 bytes from 192.168.3.2: icmp_seq=0 ttl=253 time=4.000 ms

56 bytes from 192.168.3.2: icmp_seq=1 ttl=253 time=2.000 ms

![https://zhiliao.h3c.com/uploads/t/20220630/16565725637229.png](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
