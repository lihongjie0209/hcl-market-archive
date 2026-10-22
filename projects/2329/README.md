# 工程名称
V7交换机作为SSH server


## 需求：
1、配置交换机作为ssh server，使运维人员可以通过内网口地址ssh远程登陆设备，并具有超级管理员权限

2、修改ssh服务端口号为1122


## 实验步骤：
**1、配置接口ip**

**2、开启ssh服务，修改SSH端口号为1122，配置用户线认证模式为用户名密码认证，同时配置用户线仅支持ssh协议**
#
 ssh server enable
 ssh server port 1122
#
line vty 0 4
 authentication-mode scheme
 protocol inbound ssh
#

**3、配置名为ssh的本地用户，服务类型为ssh，密码为1qaz2wsx3edc，权限为network-admin**
#
local-user ssh class manage
 password simple 1qaz2wsx3edc
 service-type ssh
 authorization-attribute user-role network-admin
 authorization-attribute user-role network-operator
#

## 测试结果：
1、PC1可以ssh登陆SW1
<PC1>ssh 10.0.12.1 1122
Username: ssh
Press CTRL+C to abort.
Connecting to 10.0.12.1 port 1122.
The server is not authenticated. Continue? [Y/N]:y
Do you want to save the server public key? [Y/N]:n
ssh@10.0.12.1's password: 
Enter a character ~ and a dot to abort.
******************************************************************************
* Copyright (c) 2004-2022 New H3C Technologies Co., Ltd. All rights reserved.*
* Without the owner's prior written consent,                                 *
* no decompiling or reverse-engineering shall be allowed.                    *
******************************************************************************

<SW1>
<SW1>

## 说明： 
CLI登录用户的访问行为需要由用户线管理、限制，即网络管理员可以给每个用户线配置一系列参数，比如用户登录时是否需要认证、用户登录后的角色等。当用户通过CLI登录到设备的时候，系统会给用户分配一个用户线，登录用户将受到该用户线下配置参数的约束。

