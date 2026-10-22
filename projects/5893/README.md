# 工程名称

V7交换机作为Telnet server，限制可登陆的源地址

## 需求：
1、配置交换机作为Telnet server，使运维人员可以通过内网口地址ssh远程登陆设备，并具有超级管理员权限

2、仅允许源地址10.0.12.2可以telnet到交换机


## 实验步骤：
1、配置接口ip

2、开启telnet服务，配置用户线认证模式为用户名密码认证，同时配置用户线仅支持ssh协议
#
telnet server enable
#
line vty 0 4
authentication-mode scheme
#
3、配置名为telnet的本地用户，服务类型为telnet，密码为1qaz2wsx3edc，权限为network-admin
#
local-user telnet class manage
password simple 1qaz2wsx3edc
service-type telnet
authorization-attribute user-role network-admin
authorization-attribute user-role network-operator
#

4、配置基本acl 2000，匹配源地址为10.0.12.2的流量(如果管理口绑定了VPN实例，那么acl的rule也需要携带vpn实例参数)

#
acl basic 2000
 rule 0 permit source 10.0.12.2 0
#


5、telnet server关联acl 2000
#
 telnet server acl 2000
#


## 测试结果：
1、PC1可以telnet登陆SW1
<PC1>telnet 10.0.12.1
Trying 10.0.12.1 ...
Press CTRL+K to abort
Connected to 10.0.12.1 ...
Login: telnet
Password: 
******************************************************************************
* Copyright (c) 2004-2022 New H3C Technologies Co., Ltd. All rights reserved.*
* Without the owner's prior written consent,                                 *
* no decompiling or reverse-engineering shall be allowed.                    *
******************************************************************************

<SW1>
<SW1>qu


## 说明： 

CLI登录用户的访问行为需要由用户线管理、限制，即网络管理员可以给每个用户线配置一系列参数，比如用户登录时是否需要认证、用户登录后的角色等。当用户通过CLI登录到设备的时候，系统会给用户分配一个用户线，登录用户将受到该用户线下配置参数的约束。

