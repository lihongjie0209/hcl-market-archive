## 需求：

1.  Telnet用户主机与Switch相连，需要实现Switch对Telnet用户进行本地认证并授权用户角色。Telnet用户的登录用户名为user1@bbb，认证通过后被授权的用户角色为role1；

2.  role1具有如下用户权限：

-   允许用户执行所有特性中读类型的命令；

-   允许用户执行创建VLAN以及进入VLAN视图后的相关命令，并只具有操作VLAN
    10～VLAN 20的权限。

## 实验步骤：

A.  \# 配置VLAN接口2的IP地址，Telnet用户将通过该地址连接Switch；

B.  \# 开启Switch的Telnet服务器功能；

C.  \# 配置Telnet用户登录采用AAA认证方式；

D.  \# 配置ISP域bbb的AAA方法为本地认证和本地授权；

E.  \# 创建用户角色role1；

F.  \# 配置用户角色规则1，允许用户执行所有特性中读类型的命令；

G.  \#
    配置用户角色规则2，允许用户执行创建VLAN以及进入VLAN视图后的相关命令；

H.  \# 进入VLAN策略视图，允许用户具有操作VLAN 10～VLAN 20的权限；

I.  \# 创建设备管理类本地用户user1；

J.  \# 配置用户的密码是明文的123456TESTplat!；

K.  \# 指定用户的服务类型是Telnet；

L.  \# 指定用户user1的授权角色为role1；

M.  \#
    为保证用户仅使用授权的用户角色role1，删除用户user1具有的缺省用户角色network-operator。

## 测试结果：

用户向Switch发起Telnet连接，在Telnet客户端按照提示输入用户名user1@bbb及正确的密码后，可成功登录Switch，并被授予用户角色role1，具有相应的命令行执行权限。

![](./Media//image1.png)


可通过如下步骤验证用户的权限：

•     可操作VLAN 10～VLAN 20。（以创建VLAN 10为例）

•     不能操作其它VLAN。（以创建VLAN 30为例）

•     可执行所有特性中读类型的命令。（以**display clock**为例）

•     不能执行特性中写类型和执行类型的命令。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
