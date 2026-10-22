# 工程名称
交换机RBAC配置案例


## 需求：
test角色的用户只允许display查看以及配置端口的port access vlan


## 实验步骤：
1、配置用户角色test，只允许用户视图下display命令以及系统视图下进入端口视图配置port access vlan
2、设备使能telnet允许远程登录，并将登录方式设置为用户名密码登录
3、配置用户test，设置为test用户角色


## 测试结果：
在PC上telnet登录交换机，可以看到系统视图下只能进入interface视图，其他命令无法输入。
<H3C>telnet 192.168.1.1
Trying 192.168.1.1 ...
Press CTRL+K to abort
Connected to 192.168.1.1 ...
Login: test
Password: 
******************************************************************************
* Copyright (c) 2004-2022 New H3C Technologies Co., Ltd. All rights reserved.*
* Without the owner's prior written consent,                                 *
* no decompiling or reverse-engineering shall be allowed.                    *
******************************************************************************

<SW>?
User view commands:
  display      Display current system information
  erase        Alias for 'delete'
  exit         Alias for 'quit'
  no           Alias for 'undo'
  quit         Exit from current command view
  show         Alias for 'display'
  system-view  Enter the System View
  write        Alias for 'save'

<SW>system-view 
System View: return to User View with Ctrl+Z.
[SW]?
System view commands:
  access-list  Alias for 'acl'
  display      Display current system information
  end          Alias for 'return'
  erase        Alias for 'delete'
  exit         Alias for 'quit'
  hostname     Alias for 'sysname'
  interface    Interface configuration
  logging      Alias for 'info-center'
  no           Alias for 'undo'
  quit         Exit from current command view
  return       Exit to User View
  show         Alias for 'display'
  write        Alias for 'save'


## 说明： 
本实验使用的模拟器为S6850，设置内存为默认。 
本实验使用的虚拟PC版本为默认。

