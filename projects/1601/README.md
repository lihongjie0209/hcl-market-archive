# IPv6 Internet访问IPv4网络配置

**标签：**

**AFT**

## 需求

Internet已经升级到了IPv6，但是某公司内部网络仍然是IPv4网络。而该公司仍希望为IPv6
Internet内的用户提供FTP服务。该公司访问IPv6
Internet使用的IPv6地址为2012::1。

为满足上述要求，实现方式如下：

通过IPv4到IPv6源地址静态转换策略，为IPv4网络中的FTP服务器地址指定一个对应的IPv6地址，IPv6
Internet中的主机通过访问该IPv6地址可以访问IPv4网络中的FTP服务器。Router收到发往该IPv6地址的报文时将其目的地址转换为对应的IPv4地址。

通过IPv6到IPv4源地址动态转换策略，将IPv6
Internet发送过来的IPv6报文源地址转换为IPv4地址30.1.1.1和30.1.1.2。

## 实验步骤：

1、配置各接口的IP地址

2、配置AFT

\[Router\] aft v4tov6 source 20.1.1.1 2012::1

配置地址组0包含2个IPv4地址：30.1.1.1和30.1.1.2。

\[Router\] aft address-group 0

\[Router-aft-address-group-0\] address 30.1.1.1 30.1.1.2

\[Router-aft-address-group-0\] quit

配置IPv6 ACL
2000，匹配IPv6网络到IPv4网络的报文。此处允许所有IPv6网络内主机访问IPv4
FTP Server。

\[Router\] acl ipv6 basic 2000

\[Router-acl-ipv6-basic-2000\] rule permit

\[Router-acl-ipv6-basic-2000\] quit

配置IPv6到IPv4的源地址动态转换策略，将匹配ACL
2000的IPv6报文源地址转换为地址组0中的IPv4地址30.1.1.2或30.1.1.3。

\[Router\] aft v6tov4 source acl ipv6 number 2000 address-group 0

在IPv6侧接口GigabitEthernet0/0开启AFT。

\[Router\] interface gigabitethernet 0/0

\[Router-GigabitEthernet0/0\] aft enable

\[Router-GigabitEthernet0/1\] quit

在IPv4侧接口GigabitEthernet0/1开启AFT。

\[Router\] interface gigabitethernet 0/1

\[Router-GigabitEthernet0/1\] aft enable

\[Router-GigabitEthernet0/1\] quit

## 测试结果：

以上配置完成后，检查IPv6 host与IPv4 FTP server的连通性。以IPv6 host A
ping IPv4 FTP server为例：

![](./Media//image1.png)


通过查看AFT会话，可以看到创建了一个IPv6会话和IPv4会话，分别对应转换前和转换后的报文。

![](./Media//image2.png)


![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
