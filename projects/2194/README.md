# 工程名称

防火墙做LB，并且配合AFT实现V4网络访问V6服务器

## 需求：
防火墙做LB功能，并且完成V4网络访问V6服务器。

防火墙做LB，地址为2.2.2.2/24、2003::2/96和2004::2/96.并且实现AFT转换，源地址动态转换，前缀为2000:: /96，目的地址5.5.5.5映射VSIP2005::1

MSR3和MSR4做telnet服务器，地址为2003::1/96和2004::1/96.

MSR2模拟外网设备访问。地址2.2.2.1/24

## 实验步骤：

1.配置地址和路由。

2.配置安全策略和安全域，外网口做untrust，内网口做trust域，并且放通本地到trust的探测流量，和外网到本地的流量。

3.配置msr3和msr4的telnet。

4.配置nqa探测和持续性。

5.配置实服务器，实服务组和虚服务器。



## 测试结果：
从msr2telnet 5.5.5.5两次，都能访问到msr并且是不同的msr，确认配置无误。
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

<msr3>



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

<msr4>



## 说明： 

1.AFT情况下可以不配置IPV6策略。但是要放通NQA探测的流量。

