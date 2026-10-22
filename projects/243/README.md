# BGP路径选择配置

## 需求：

所有路由器都运行BGP协议。Router A与Router B和Router
C之间运行EBGP；Router D与Router B和Router C之间运行IBGP。

AS 200中运行OSPF协议。

配置路由策略，使得Router D优选从Router C学到的1.0.0.0/8路由。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置Router B、Router C和Router D之间运行OSPF协议

3.  配置BGP连接

4.  通过配置本地优先级，使得Router D优选从Router C学到的路由。

\# 在Router C上定义编号为2000的IPv4基本ACL，允许1.0.0.0/8路由通过。

\[RouterC\] acl basic 2000

\[RouterC-acl-ipv4-basic-2000\] rule permit source 1.0.0.0 0.255.255.255

\[RouterC-acl-ipv4-basic-2000\] quit

\# 在Router
C上定义名为localpref的Route-policy，设置路由1.0.0.0/8的本地优先级为200（缺省的本地优先级为100）。

\[RouterC\] route-policy localpref permit node 10

\[RouterC-route-policy-localpref-10\] if-match ip address acl 2000

\[RouterC-route-policy-localpref-10\] apply local-preference 200

\[RouterC-route-policy-localpref-10\] quit

\# 为从BGP对等体193.1.1.1的路由应用名为localpref的Route-policy。

\[RouterC\] bgp 200

\[RouterC-bgp-default\] address-family ipv4 unicast

\[RouterC-bgp-default-ipv4\] peer 193.1.1.1 route-policy localpref
import

\[RouterC-bgp-default-ipv4\] quit

\[RouterC-bgp-default\] quit

## 测试结果：

查看Router D的BGP路由表。

![](./Media//image1.png)


可以看到，Router D从Router C学到1.0.0.0/8的路由是最优的。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
