# 工程名称
NGFW单机模式AFT动态加前缀实现映射V6内部服务器

标签
AFT

## 需求：

防火墙作为网关，内网网关地址为2000::1/96，内部交换机纯二层，内部服务器地址为2000::2/96和2000::3/96.同时防火墙对接IPV4外部服务器，地址为220.1.1.1/24,RT模拟外网设备，外网设备220.1.1.2/24.

AFT映射利用V6server，220.1.2.2映射2000::2,220.1.2.3映射2000::3.
源地址利用前缀动态转换，模式为General。

需求为内部IPV6服务器映射到IPV4公网上。

## 实验步骤：
1.配置IP。

2.防火墙配置安全策略和安全域，外网口1/0/3放入untrust，内网口1/0/2放入trust。同时AFT单向访问，逻辑代理，因此IPV6放通untrust-local，IPV4放通local-trust。

3.配置AFT，内网映射为一对一映射， 并且只映射23端口对外提供服务。源地址改变为前缀动态转换。

4.配置路由，外网配置到220.1.2.0/24位路由指向防火墙，内网设备网关指向防火墙。

5.内网设备开启telnet功能，并创建用户，该工程用户名密码为test/asdfqwer1234


## 测试结果：
外网分别访问220.1.2.2 和220.1.2.3测试，telnet可以访问成功，确认正常。
<H3C>telnet  220.1.2.2  23

Trying 220.1.2.2 ...

Press CTRL+K to abort

Connected to 220.1.2.2 ...


******************************************************************************

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*

* Without the owner's prior written consent,                                 *

* no decompiling or reverse-engineering shall be allowed.                    *

******************************************************************************


Login: test





<H3C>telnet  220.1.2.3  23

Trying 220.1.2.3 ...

Press CTRL+K to abort

Connected to 220.1.2.3 ...


******************************************************************************

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*

* Without the owner's prior written consent,                                 *

* no decompiling or reverse-engineering shall be allowed.                    *

******************************************************************************


Login:



## 说明： 


