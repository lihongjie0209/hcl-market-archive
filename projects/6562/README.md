# RBAC典型配置举例

## 需求：

1.  设备A模拟 telnet server，设备B模拟telnet client
    ，需要实现设备A对Telnet用户进行本地认证并授权用户角色。Telnet用户的登录用户名为admin，认证通过后被授权的用户角色为role1。

2.  role1具有如下用户权限：

允许用户执行所有特性中读类型的命令

允许用户执行进入接口视图以及接口视图下配置入方向包过滤功能

## 实验步骤

1.  配置互联IP地址；

2.  开启Device A的Telnet服务器功能；

> ![](./Media//image1.png)
> 

3.  配置Telnet用户登录采用AAA认证方式；

> ![](./Media//image2.png)
> 

4.  创建用户角色role1；

> ![](./Media//image3.png)
> 

5.  创建设备管理类本地用户；

> ![](./Media//image4.png)
> 

## 测试结果：

DeviceB
向DeviceA发起Telnet连接，在Telnet客户端按照提示输入用户名admin及正确的密码后，可成功登录DeviceA，并被授予用户角色role1，具有相应的命令行执行权限。

![](./Media//image5.png)


![](./Media//image6.png)


![](./Media//image7.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
