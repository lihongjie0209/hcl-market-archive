# 工程名称
通过ssh登录AC设备典型配置举例


## 需求：
配置AC作为ssh server，使运维人员可以通过内网口地址ssh远程登陆设备

## 实验步骤：
1、AC1上开启ssh功能
 ssh server enable
#
line vty 0 4
 authentication-mode scheme
 user-role network-operator
 protocol inbound ssh

2、AC1上配置ssh用户名为admin，认证密码为h3c123456789，服务类型为ssh
local-user admin class manage
 password hash $h$6$Mw1heoL2svQ5eGGx$edXy8watfComPU/jFJaWPY4UxZeBF+MjaBpvP3cLTxtZhNTIf8L2kT3qG7CSAujTJbbFLeWHSBSSlh9rjPM2lA==
 service-type ssh telnet http https
 authorization-attribute user-role network-admin
 authorization-attribute user-role network-operator
#
3、连接其他AC2设备，配置AC同网段地址192.168.1.2

## 测试结果：
在其他设备AC2的命令行内ssh登录AC2设备的命令行成功：
![企业微信截图_16678876014392.png](./Media/企业微信截图_16678876014392.png)

![企业微信截图_16678876321507.png](./Media/企业微信截图_16678876321507.png)
## 说明： 
