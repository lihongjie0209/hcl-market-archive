# 工程名称

防火墙实现负载均衡，并且进行AFT转换实现V6访问V4。

## 需求：

1.防火墙做负载均衡。负载V4服务器、

2.防火墙做AFT，实现V6访问V4网络。

3.防火墙单接口旁路，接口使用双栈。

防火墙使用双栈，地址为2.2.2.1/24和2002::1/96，网关为交换机，VSIP为6.6.6.6,2001::1映射6.6.6.6.。

MSR1使用IPV6地址2000::1/96模拟访问客户端。

MSR4和MSR5配置telnet服务，模拟服务器，地址为4.4.4.1/24和5.5.5.1/24.

交换机做所有设备网关，简化路由配置，使用vlan interface做三层口，1口vlan10,2口vlan20,4口vlan40，5口vlan50.

## 实验步骤：
1.配置IP和路由。

2.配置MSR4和MSR5的telnet服务，用户和线程。

3.配置交换机，使用不同vlan进行隔离。

4.配置防火墙的安全策略和安全域，由于单接口，因此只放入trust，配置V6策略放通trust到local，V4策略放通local到trust。

5.配置nqa探测和持续性组。

6.配置实服务器，实服务组和虚服务。

7.配置AFT，由于AFT必须含有路由，因此增加了一个到6.6.6.6的黑洞路由。


## 测试结果：
通过telnet 2001:：1 23，发现能正常访问，并且两次访问不同的主机，确认配置准确。

<H3C>telnet  ipv6  2001::1 23

Trying 2001::1 ...

Press CTRL+K to abort

Connected to 2001::1 ...


******************************************************************************

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*

* Without the owner's prior written consent,                                 *

* no decompiling or reverse-engineering shall be allowed.                    *

******************************************************************************


Login: telnet

Password:

<msr5>

<msr5>qu


The connection was closed by the remote host!

<H3C>telnet  ipv6  2001::1 23

Trying 2001::1 ...

Press CTRL+K to abort

Connected to 2001::1 ...


******************************************************************************

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*

* Without the owner's prior written consent,                                 *

* no decompiling or reverse-engineering shall be allowed.                    *

******************************************************************************


Login: telnet

Password:

<msr4>

<msr4>qu



## 说明： 

1.AFT转换后会进行路由检查，如果发现没路由就会丢包，因此必须包含转换后的路由，因此如果路由不对无法进行AFT转换。

2.由于做了AFT转换，因此不存在SNAT的问题。