# 工程名称

串联模式防火墙做SLB+DNAT。

## 需求：

防火墙做SLB，并且只做DNAT模式，串联组网。
防火墙做所有设备网关，简化路由问题，并且内网是telnet服务器，地址为2.2.2.1/24和3.3.3.1/24，对应MSR2和MSR3。
外网4.4.4.1/24，模拟外网telnet访问。

## 实验步骤：
1.配置IP和路由。

2.防火墙配置安全域和安全策略。外网为untrust，内网为trust。

3.配置telnet服务器，开启telnet功能和用户相关配置。并且更改设备默认命名，用于后续测试区分。

4.配置SLB配置，实服务器，实服务组和虚服务，并且使用源地址端口的持续性保证登录正常。

5.配置TCP类型的持续性，并且放通持续性的策略。






## 测试结果：
设备telnet两次，源端口会出现变化，因此会被调度到不同设备。由此判断负载均衡成功。


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

Login: telnet

Password:


<msr3>qu


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

<msr2>

<msr2>qu



## 说明： 

DNAT默认开启，不需要特殊配置。
