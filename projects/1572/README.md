# 静态LSP通用配置

**标签：**

**MPLS**

## 需求

Router A、Router B和Router C均支持MPLS。

在Router A和Router
C之间建立静态LSP，使11.1.1.0/24和21.1.1.0/24这两个网段中互访的报文能够通过MPLS进行传输。

## 实验步骤：

1、在Ingress上配置到达FEC目的地址的静态路由

在Router A上配置到达21.1.1.0/24网段的静态路由。

ip route-static 21.1.1.0 24 10.1.1.2

在Router C上配置到达11.1.1.0/24网段的静态路由。

ip route-static 11.1.1.0 24 20.1.1.1

2、使能MPLS功能

配置Router A。

\#

mpls lsr-id 1.1.1.9

\#

interface GigabitEthernet0/0

ip address 10.1.1.1 255.255.255.0

mpls enable

\#

配置Router B。

\#

mpls lsr-id 2.2.2.9

\#

interface GigabitEthernet0/0

ip address 10.1.1.2 255.255.255.0

mpls enable

\#

interface GigabitEthernet0/1

ip address 20.1.1.1 255.255.255.0

mpls enable

\#

配置Router C。

\#

mpls lsr-id 3.3.3.9

\#

interface GigabitEthernet0/0

ip address 20.1.1.2 255.255.255.0

mpls enable

\#

3、创建从Router A到Router C的静态LSP

配置Ingress Router A。

static-lsp ingress AtoC destination 21.1.1.0 24 nexthop 10.1.1.2
out-label 30

配置Transit Router B

static-lsp transit AtoC in-label 30 nexthop 20.1.1.2 out-label 50

配置Egress Router C。

static-lsp egress AtoC in-label 50

4、创建从Router C到Router A的静态LSP

配置Ingress Router C。

static-lsp ingress CtoA destination 11.1.1.0 24 nexthop 20.1.1.1
out-label 40

配置Transit Router B。

static-lsp transit CtoA in-label 40 nexthop 10.1.1.1 out-label 70

配置Egress Router A。

static-lsp egress CtoA in-label 70

## 测试结果：

配置完成后，可以在各路由器上通过display mpls
static-lsp命令查看静态LSP的信息。以Router A的显示信息为例。

![](./Media//image1.png)


在Router A上检测Router A到Router C静态LSP的可达性。

![](./Media//image2.png)


在Router C上检测Router C到Router A静态LSP的可达性。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
