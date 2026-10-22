# L2TP多域接入典型配置举例

**标签：**

**L2TP**

## 需求

不同地区的主机Host A和Host B上通过L2TP隧道传输数据。具体应用需求如下：

LNS 上设置两个域，分别为属于不同区域的用户提供接入服务；

不同域的用户获得不同网段的 IP 地址，实现与 LNS 互通。

## 实验步骤：

为了保证合法用户可以正常接入从而建立 Client-Initiated 模式 L2TP 隧道，在
LNS 上配置 L2TP 用户侧认证，并创建 PPP 用户和用户所属的域，在 Host
侧需要使用设备上配置的用户名来发起隧道建立请求。

1、配置各接口的IP地址

2、配置LNS

\# 使能 L2TP。

\<LNS\> system-view

\[LNS\] l2tp enable

\# 配置两个地址池，为不同域的用户分配不同网段的 IP 地址。

\[LNS\] ip pool 1 10.0.1.2 10.0.1.10

\[LNS\] ip pool 2 10.0.2.2 10.0.2.10

\# 配置域 abc.com 关联地址池 1，并且配置 PPP 的认证方式为本地认证。

\[LNS\] domain abc.com

\[LNS-isp-abc.com\] authorization-attribute ip-pool 1

\[LNS-isp-abc.com\] authentication ppp local

\[LNS-isp-abc.com\] quit

\# 配置域 abc2.com 关联地址池 2，并且配置 PPP 的认证方式为本地认证。

\[LNS\] domain abc2.com

\[LNS-isp-abc2.com\] authorization-attribute ip-pool 2

\[LNS-isp-abc2.com\] authentication ppp local

\[LNS-isp-abc2.com\] quit

\# 创建接口 Virtual-Template1，配置接口的 IP 地址为 10.0.1.1/24， PPP
认证方式为 CHAP，并指

定从 pool1 为 PPP 用户分配的 IP 地址。

\[LNS\] interface virtual-template1

\[LNS-Virtual-Template1\] ppp authentication-mode chap domain abc.com

\[LNS-Virtual-Template1\] remote address pool 1

\[LNS-Virtual-Template1\] ip address 10.0.1.1 255.255.255.0

\[LNS-Virtual-Template1\] quit

\# 创建接口 Virtual-Template2，配置接口的 IP 地址为 10.0.2.1/24， PPP
认证方式为 CHAP，并指定从 pool2 为 PPP 用户分配的 IP 地址。

\[LNS\] interface virtual-template2

\[LNS-Virtual-Template2\] ppp authentication-mode chap domain abc2.com

\[LNS-Virtual-Template2\] remote address pool 2

\[LNS-Virtual-Template2\] ip address 10.0.2.1 255.255.255.0

\[LNS-Virtual-Template2\] quit

\# 配置接口 GigabitEthernet0/0。

\[LNS\] interface gigabitethernet0/0

\[LNS-GigabitEthernet0/0\] port link-mode route

\[LNS-GigabitEthernet0/0\] ip address 172.31.123.101 255.255.255.0

\[LNS-GigabitEthernet0/0\] quit

\# 创建用户 user1，密码为 hello，服务类型为 ppp。

\[LNS\] local-user user1 class network

\[LNS-luser-network-user1\] password simple hello

\[LNS-luser-network-user1\] service-type ppp

\[LNS-luser-network-user1\] quit

\# 创建用户 user2，密码为 hello，服务类型为 ppp。

\[LNS\] local-user user2 class network

\[LNS-luser-network-user2\] password simple hello

\[LNS-luser-network-user2\] service-type ppp

\[LNS-luser-network-user2\] quit

\# 创建 L2TP 组，模式为 LNS，关闭隧道验证。

\[LNS\] l2tp-group 1 mode lns

\[LNS-l2tp1\] allow l2tp virtual-template 1 remote user1.abc.com

\[LNS-l2tp1\] undo tunnel authentication

\[LNS-l2tp1\] quit

\# 创建 L2TP 组，模式为 LNS，关闭隧道验证。

\[LNS\] l2tp-group 2 mode lns

\[LNS-l2tp2\] allow l2tp virtual-template 2 remote user2.abc2.com

\[LNS-l2tp2\] undo tunnel authentication

\[LNS-l2tp2\] quit

Host实际中是PC类终端，这里使用Router替代，使用LAC-Auto-Initiated配置。

## 测试结果：

在 LNS 侧，通过命令 display l2tp tunnel 查看建立的 L2TP 隧道。

![](./Media//image1.png)


在 LNS 侧，通过命令 display l2tp session 可查看已建立的 L2TP 会话。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
