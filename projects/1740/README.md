# 工程名称

防火墙串联模式做负载均衡，SNAT+DNAT模式。

## 需求：
防火墙做负载均衡设备，映射内网telnet服务器，并且使用SNAT+DNAT方式。
防火墙做LB设备，vsip5.5.5.5 23，地址池为6.6.6.6.内网用3.3.3.1和4.4.4.1做telnet服务器，外网2.2.2.1模拟访问客户端。


## 实验步骤：
1.配置地址和路由，注意telnet服务器只写到6.6.6.6的路由，不写其他路由，确认SNAT的成功。

2.配置安全策略和安全域。外网口放入untrust，内网口放入trust，并且放通本地发trust的探测报文。

3.开启telnet服务和用户配置。

4.配置实服务器和实服务组，并且开启虚服务。

5.配置持续性组和源地址池。持续性选择地址端口。


## 测试结果：


telnet5.5.5.5两次，确认是分配到不同设备上。并且正常访问。

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


<msr4> qu

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

<msr3> qu


## 说明： 

无
