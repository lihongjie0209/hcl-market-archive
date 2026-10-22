# Telnet用户的本地用户角色授权配置

## 需求：

Telnet用户主机与Router相连，需要实现Router对Telnet用户进行本地认证并授权用户角色。Telnet用户的登录用户名为user1@bbb，密码为Qwerty1234，认证通过后被授权的用户角色为role1。

role1具有如下用户权限：

-   允许用户执行所有特性中读类型的命令；

-   允许用户执行进入接口视图以及接口视图下的相关命令，并具有操作接口GigabitEthernet0/1～GigabitEthernet0/2的权限。

## 实验步骤：

实验步骤：

1、配置接口IP地址，保证网络可达；

2、开启Router的Telnet服务器功能；

3、创建用户角色role1，并配置用户角色规则。

## 测试结果：

用户向Router发起Telnet连接，在Telnet客户端按照提示输入用户名user1@bbb及正确的密码后，可成功登录Router，并被授予用户角色role1，具有相应的命令行执行权限。

1、查看登录用户的被授予用户角色role1。

![](./Media//image1.png)


2、可以操作接口GigabitEthernet 0/1、GigabitEthernet
0/2。（以接口GigabitEthernet 0/1为例）

![](./Media//image2.png)


其他接口不能操作。（以接口GigabitEthernet 0/0为例）

![](./Media//image3.png)


3、可执行所有特性中读类型的命令。（以display clock为例）

![](./Media//image4.png)


![](./Media//image5.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
