# 工程名称
旁路模式防火墙SLB+DNAT

## 需求：
防火墙旁挂核心，并且做SLB和只做DNAT。保证内网telnet服务器能负载均衡。

防火墙旁挂模式地址为1.1.1.1/24，交换机做所有设备的网关简化路由。内网msr4和msr5做telnet服务器，4.4.4.1/24和5.5.5.1/24.外网设备3.3.3.1模拟公网访问。


## 实验步骤：
1.配置ip和路由。

2.防火墙配置安全策略和安全域。由于只有一个接口，直接放入trust。策略放通同域互访和local发出的探测报文。

3.配置实服务器。实服务组和虚服务。

4.配置健康性检测和持续性。

5.telnet服务器开启相关服务和用户。并且更改默认名称用于标识。

6.由于来回都需要过LB，因此交换机配置PBR。


## 测试结果：

可以看到两次telnet分配到不同服务器，并且telnet访问正常，确认负载均衡生效。
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

DNAT旁路模式由于回程可以直接转发公网，因此必须配置PBR。
