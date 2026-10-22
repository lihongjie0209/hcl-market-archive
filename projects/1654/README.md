# 负载分担内部服务器配置

**标签：**

**NAT**

## 需求

某公司内部拥有3台FTP服务器对外提供FTP服务。

需要实现如下功能：

使用IP地址为202.38.1.1作为公司对外提供服务的IP地址。

两台FTP服务器可以同时对外提供服务，并进行负载分担。

## 实验步骤：

1、按照组网图配置各接口的IP地址。

2、配置NAT内部服务器

\#

nat server-group 0

inside ip 10.110.10.1 port 21

inside ip 10.110.10.2 port 21

\#

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ip address 202.38.1.1 255.255.255.252

nat server protocol tcp global 202.38.1.1 21 inside server-group 0

\#

## 测试结果：

以上配置完成后，外网主机可以访问内网FTP服务器组。通过查看如下显示信息，可以验证以上配置成功。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
