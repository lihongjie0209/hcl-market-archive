# 工程名称
V7防火墙作为telnet server


## 需求：
配置防火墙作为telnet server，使运维人员可以通过内网口地址telnet远程登陆设备，并具有超级管理员权限


## 实验步骤：
**1、配置接口ip**

**2、内网接口加入trust域，内网接口允许telnet**
#
interface GigabitEthernet1/0/1
 port link-mode route
 ip address 10.0.12.1 255.255.255.0
 manage telnet inbound
#
security-zone name Trust
 import interface GigabitEthernet1/0/1
#

**3、开启telnet服务，配置用户线认证模式为用户名密码认证**
#              
 telnet server enable
#
#
line vty 0 63
 authentication-mode scheme
 user-role network-admin
#  

**4、配置名为telnet的本地用户，服务类型为telnet，密码为1qaz2wsx3edc，权限为network-admin**
#
local-user ssh class manage
 password simple 1qaz2wsx3edc
 service-type telnet
 authorization-attribute user-role network-admin
 authorization-attribute user-role network-operator
#  
## 测试结果：

1、PC1可以telnet登陆FW1
<PC1>telnet 10.0.12.1
Trying 10.0.12.1 ...
Press CTRL+K to abort
Connected to 10.0.12.1 ...

******************************************************************************
* Copyright (c) 2004-2022 New H3C Technologies Co., Ltd. All rights reserved.*
* Without the owner's prior written consent,                                 *
* no decompiling or reverse-engineering shall be allowed.                    *
******************************************************************************

Login: telnet
Password: 
<FW1>

## 说明： 

1、配置安全策略放行内网接口到local安全域的策略，或者直接在接口下允许telnet管理

2、CLI登录用户的访问行为需要由用户线管理、限制，即网络管理员可以给每个用户线配置一系列参数，比如用户登录时是否需要认证、用户登录后的角色等。当用户通过CLI登录到设备的时候，系统会给用户分配一个用户线，登录用户将受到该用户线下配置参数的约束。
