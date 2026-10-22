# 工程名称
V7交换机作为Telnet server,登陆时仅验证密码


## 需求：
1、配置交换机作为Telnet server，使运维人员可以通过内网口地址ssh远程登陆设备，并具有超级管理员权限

2、Telnet登陆时仅使用密码完成验证


## 实验步骤：
1、配置接口ip

2、开启telnet服务
#
 telnet server enable
#

3、配置用户线认证模式为密码认证、用户线权限为network-admin，并配置登陆密码为1qaz2wsx3edc
#
line vty 0 4
 user-role network-admin
 authentication-mode password
 set authentication password simple 1qaz2wsx3edc
#



## 测试结果：
1、PC1可以telnet登陆SW1

<PC1>telnet 10.0.12.1
Trying 10.0.12.1 ...
Press CTRL+K to abort
Connected to 10.0.12.1 ...
Password: 
******************************************************************************
* Copyright (c) 2004-2022 New H3C Technologies Co., Ltd. All rights reserved.*
* Without the owner's prior written consent,                                 *
* no decompiling or reverse-engineering shall be allowed.                    *
******************************************************************************

<SW1>quit


## 说明： 
CLI登录用户的访问行为需要由用户线管理、限制，即网络管理员可以给每个用户线配置一系列参数，比如用户登录时是否需要认证、用户登录后的角色等。当用户通过CLI登录到设备的时候，系统会给用户分配一个用户线，登录用户将受到该用户线下配置参数的约束。



