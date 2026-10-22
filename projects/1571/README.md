# 利用LDP动态建立LSP配置

**标签：**

**MPLS**

## 需求

Router A、Router B和Router C均支持MPLS。

在Router A和Router
C之间使用LDP动态建立LSP，使11.1.1.0/24和21.1.1.0/24这两个网段中互访的报文能够通过MPLS进行传输。

Router A、Router B和Router
C上只允许目的地址为1.1.1.9/32、2.2.2.9/32、3.3.3.9/32、11.1.1.0/24和21.1.1.0/24的路由表项触发LDP建立LSP，其他路由表项不能触发LDP建立LSP，以避免建立的LSP数量过多，影响设备性能。

## 实验步骤：

1、配置各接口的IP地址

2、配置OSPF，以保证各路由器之间路由可达

3、使能MPLS和LDP功能，以RTA配置为例：

配置Router A。

\#

mpls lsr-id 1.1.1.9

\#

mpls ldp

\#

interface gigabitethernet 0/0

mpls enable

mpls ldp enable

\#

4、配置LSP触发策略

在Router
A上创建IP地址前缀列表routera，并配置只有通过该列表过滤的路由表项能够触发LDP建立LSP。

\#

ip prefix-list routera index 10 permit 1.1.1.9 32

ip prefix-list routera index 20 permit 2.2.2.9 32

ip prefix-list routera index 30 permit 3.3.3.9 32

ip prefix-list routera index 40 permit 11.1.1.0 24

ip prefix-list routera index 50 permit 21.1.1.0 24

\#

mpls ldp

lsp-trigger prefix-list routera

\#

在Router
B上创建IP地址前缀列表routerb，并配置只有通过该列表过滤的路由表项能够触发LDP建立LSP。

\#

ip prefix-list routerb index 10 permit 1.1.1.9 32

ip prefix-list routerb index 20 permit 2.2.2.9 32

ip prefix-list routerb index 30 permit 3.3.3.9 32

ip prefix-list routerb index 40 permit 11.1.1.0 24

ip prefix-list routerb index 50 permit 21.1.1.0 24

\#

mpls ldp

lsp-trigger prefix-list routerb

\#

在Router
C上创建IP地址前缀列表routerc，并配置只有通过该列表过滤的路由表项能够触发LDP建立LSP。

\#

ip prefix-list routerc index 10 permit 1.1.1.9 32

ip prefix-list routerc index 20 permit 2.2.2.9 32

ip prefix-list routerc index 30 permit 3.3.3.9 32

ip prefix-list routerc index 40 permit 11.1.1.0 24

ip prefix-list routerc index 50 permit 21.1.1.0 24

\#

mpls ldp

lsp-trigger prefix-list routerc

\#

## 测试结果：

配置完成后，在各设备上执行display mpls ldp lsp命令，可以看到LDP
LSP的建立情况。以Router A为例：

![](./Media//image1.png)


在Router A上检测Router A到Router C的LDP LSP的可达性。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
