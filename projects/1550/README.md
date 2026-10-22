# 配置MPLS L3VPN采用GRE隧道

**标签：**

**MPLS L3VPN**

## 需求

CE 1和CE 2属于VPN 1。

在运营商骨干网上，PE设备具备MPLS能力，P设备只提供纯IP功能，不具备MPLS能力。

在骨干网上使用GRE隧道封装并转发VPN报文，实现MPLS L3VPN。

在PE上配置隧道策略，指定VPN流量使用的隧道类型为GRE。

## 实验步骤：

1、在MPLS骨干网上配置IGP协议，实现骨干网PE和P的互通

2、配置MPLS L3VPN，并在PE上应用隧道策略，指定使用GRE隧道转发VPN报文

\#

ip vpn-instance vpn1

route-distinguisher 100:1

tnl-policy gre1

vpn-target 100:1 import-extcommunity

vpn-target 100:1 export-extcommunity

\#

tunnel-policy gre1

select-seq gre load-balance-number 1

\#

3、配置GRE隧道

配置PE 1

\#

interface Tunnel0 mode gre

ip address 20.1.1.1 255.255.255.0

mpls enable

source LoopBack0

destination 2.2.2.9

\#

配置PE 2

\#

interface Tunnel0 mode gre

ip address 20.1.1.2 255.255.255.0

mpls enable

source LoopBack0

destination 1.1.1.9

\#

## 测试结果：

配置完成后，CE能学到对端CE的接口路由。以CE 1为例：\
![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
