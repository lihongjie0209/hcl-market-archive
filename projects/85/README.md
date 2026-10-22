# 基于报文协议类型的本地策略路由配置

## 需求：

Router A分别与Router B和Router C直连（保证Router B和Router
C之间路由完全不可达）。通过策略路由控制Router A产生的报文：

1.  指定所有TCP报文的下一跳为1.1.2.2；

2.  其它报文仍然按照查找路由表的方式进行转发。

## 实验步骤：

1.  配置各接口的IP地址

2.  创建本地策略路由并全局应用

\#

policy-based-route aaa permit node 5

if-match acl 3000

apply next-hop 1.1.2.2

\#

ip local policy-based-route aaa

\#

acl advanced 3000

rule 0 permit tcp

\#

## 测试结果：

从Router A上通过Telnet方式登录Router B（1.1.2.2/24），结果成功。

![](./Media//image2.png)


从Router A上通过Telnet方式登录Router C（1.1.3.2/24），结果失败。

![](./Media//image3.png)


从Router A上ping Router C（1.1.3.2/24），结果成功。

![](./Media//image4.png)


由于Telnet使用的是TCP协议，ping使用的是ICMP协议，所以由以上结果可证明：Router
A产生的TCP报文的下一跳为1.1.2.2，接口GigabitEthernet1/0/2不发送TCP报文，但可以发送非TCP报文，策略路由设置成功。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
