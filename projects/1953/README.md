# 工程名称

防火墙做负载均衡，并且实现V6网络访问V4。

## 需求：
1.防火墙做负载均衡，负载V4网络。

2.防火墙做AFT转换，实现V6访问V4。

防火墙地址为3.3.3.2/24、4.4.4.2/24和2000::2/96,MSR4和MSR3做telnet服务器，提供telnet服务，地址分别为3.3.3.1/24和3.3.3.2/24。msr2作为终端访问。

## 实验步骤：

1.配置IP和路由，为了路由简单，防火墙直接做网关。

2.配置MSR4和MSR3，开启telnet服务，配置用户和线程。

3.配置防火墙侧的策略和安全域，由于做了AFT转换，因此流量都是本地代理，配置v6的untrust到local，v4配置local
到trust。

4.配置nqa探测和持续性。

5.配置实服务器，实服务组和虚服务器。

6.配置AFT，注意AFT转换会检测路由情况，如果转换后的地址没有路由，AFT会认为转换后的地址是无效的，因此必须手工增加一条目的地址为5.5.5.5的路由。

## 测试结果：

telnet 2001::1两次，发现负载到不同设备，确认负载正常。

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

<msr3>qu


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

<msr4>qu



## 说明： 
1.AFT转换必须有转换后地址的路由，否则设备认为转换后也不可达，AFT会丢弃。

2.四层必须AFT和LB结合。

