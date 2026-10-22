# 工程名称

防火墙用vpn隔离情况下，实现V6外网访问V4服务器

## 需求：
防火墙用vpn隔离，并且v6访问v4服务器，限制地址端口。只映射23端口。


## 实验步骤：

1.配置路由器地址和路由。路由器使能telnet。

2.配置vpn实例和地址。

3.配置AFT，防火墙使用源地址动态转，目的地址用v4server仅映射TCP23端口。

4.配置安全策略和安全域，左边为untrust，右边trust，V6策略放通untrust到local，V4放通local到trust，注意放通相关的VRF。

5.测试结果
## 测试结果：
测试telnet正常。


<H3C>telnet  ipv6  2001::1

Trying 2001::1 ...

Press CTRL+K to abort

Connected to 2001::1 ...


******************************************************************************

* Copyright (c) 2004-2021 New H3C Technologies Co., Ltd. All rights reserved.*

* Without the owner's prior written consent,                                 *

* no decompiling or reverse-engineering shall be allowed.                    *

******************************************************************************


Login failed.




## 说明： 

1.这里提示login failed 是因为线程vty下没改认证方式，更改后创建本地用户是可以登陆的。
