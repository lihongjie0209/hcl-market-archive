# 通过SSH登录设备

## 需求：

用户可以通过Host上运行的Stelnet客户端软件（SSH2版本）安全地登录到Server上，并被授予用户角色network-admin进行配置管理；

Router采用scheme认证方式对Stelnet客户端进行认证，客户端的用户名和密码保存在本地。

## 实验步骤：

实验步骤：

1、配置接口IP地址，保证网络可达；

2、开启Server的SSH服务器功能；

3、创建本地用户。

## 测试结果：

用户向Server发起SSH连接，在SSH客户端按照提示输入用户名admin及密码Qwerty1234后，可成功登录Server，并具有操作权限。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
