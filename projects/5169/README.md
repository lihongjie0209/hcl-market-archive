# Telnet配置方式

**标签：**

**telnet**

## 需求

Telnet三种配置方式总结。

## 实验步骤：

telnet的三种配置方式。

（1）none

\#

telnet server enable

\#

line vty 0 63

authentication-mode none

user-role network-admin

user-role network-operator

\#

（2）password

\#

telnet server enable

\#

line vty 0 63

user-role level-9

set authentication password simple 1234abcd

undo user-role network-admin

undo user-role network-operator

\#

（3）scheme

\#

local-user h3c class manage

password simple 1234abcd

service-type telnet

authorization-attribute user-role network-admin

undo authorization-attribute user-role network-operator

\#

telnet server enable

\#

line vty 0 63

authentication-mode scheme

user-role network-operator

\#

## 测试结果

Client可以telnet到Server上。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
