# 工程名称

防火墙旁路模式做负载，并且实现V4访问V6。

## 需求：
防火墙做LB，旁路实现负载，并且做V4访问V6。

交换机用vlaninterface 20/30/40/50分别对接msr3/FW/MSR4/MSR5，

防火墙做LB旁路。

MSR4和MSR5做telnet服务器，

msr3模拟外网访问。

具体地址和组网如图。

## 实验步骤：
1.配置ip和路由。

2.配置telnet服务器，

3.配置交换机。

4.配置防火墙安全策略和安全域，由于一个接口放入trust，并且V4放通trust——local，V6放通local——trust。

5.配置健康性检测和持续性。

6.配置实服务器、实服务组和虚服务。


## 测试结果：

外网telnet5.5.5.5，发现可以通，并且多次访问是不同的msr。

<H3C>

<H3C>telnet  5.5.5.5

Trying 5.5.5.5 ...

Press CTRL+K to abort

Connected to 5.5.5.5 ...


******************************************************************************

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*

* Without the owner's prior written consent,                                 *

* no decompiling or reverse-engineering shall be allowed.                    *

******************************************************************************


Login: telnet

Password:

<msr4>qu


The connection was closed by the remote host!

<H3C>telnet  5.5.5.5

Trying 5.5.5.5 ...

Press CTRL+K to abort

Connected to 5.5.5.5 ...


******************************************************************************

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*

* Without the owner's prior written consent,                                 *

* no decompiling or reverse-engineering shall be allowed.                    *

******************************************************************************


Login: telnet

Password:

<msr5>qu



## 说明： 

1.AFT必须有路由才能正常转发，因此增加了虚地址的黑洞路由。


