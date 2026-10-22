# 工程名称

防火墙旁路模式做负载均衡，并且SNAT+DNAT

## 需求：
防火墙做LB，负载内部的telnet服务器，并且使用SNAT+DNAT方式，旁路组网。
内网4.4.4.1和5.5.5.1作为telnet服务器，交换机用vlan interface来做隔离，并且作为网关。外网用3.3.3.1设备模拟客户端。
防火墙vsip为7.7.7.7，地址池为6.6.6.6.


## 实验步骤：
1.配置IP和路由。

2.配置安全策略和安全域，只有一个接口放入trust，放通同域互访和本地发出的探测报文。

3.配置telnet服务器。

4.配置实服务器，实服务组和虚服务器。

5.配置持续性和源地址池，以及健康性检测。


## 测试结果：
终端探测两次，发现访问到不同设备，并且访问正常，确认负载成功。


<H3C>telnet  7.7.7.7

Trying 7.7.7.7 ...

Press CTRL+K to abort

Connected to 7.7.7.7 ...


******************************************************************************

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*

* Without the owner's prior written consent,                                 *

* no decompiling or reverse-engineering shall be allowed.                    *

******************************************************************************


Login: telnet

Password:

<msr5>qu


The connection was closed by the remote host!

<H3C>telnet  7.7.7.7

Trying 7.7.7.7 ...

Press CTRL+K to abort

Connected to 7.7.7.7 ...


******************************************************************************

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*

* Without the owner's prior written consent,                                 *

* no decompiling or reverse-engineering shall be allowed.                    *

******************************************************************************


Login: telnet

Password:

<msr4>qu



## 说明： 

无
