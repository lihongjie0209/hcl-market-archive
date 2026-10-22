# IPv4网络访问IPv6 Internet中的服务器配置

**标签：**

**AFT**

## 需求

Internet已经升级到了IPv6，但是某公司内部网络仍然是IPv4网络。而该公司内部网络的10.1.1.0/24网段的用户仍需要访问IPv6
Internet中的服务器，其他用户不能访问。

为满足上述要求，本例中使用如下方式实现：

使用IPv4到IPv6源地址动态地址转换策略，将IPv4报文的源地址转换为IPv6地址。

通过IPv6到IPv4的源地址静态转换策略为IPv6
Internet上服务器的IPv6地址指定一个对应的IPv4地址，Router收到发往该IPv4地址的报文时将其转换为对应的IPv6地址。

## 实验步骤：

1、配置各接口的IP地址

2、配置AFT

配置ACL 2000，仅允许IPv4网络中10.1.1.0/24网段的用户可以访问IPv6
Internet。

\[NAT\] acl basic 2000

\[NAT-acl-ipv4-basic-2000\] rule permit source 10.1.1.0 0.0.0.255

\[NAT-acl-ipv4-basic-2000\] rule deny

\[NAT-acl-ipv4-basic-2000\] quit

配置NAT64前缀，此前缀将在IPv4到IPv6源地址动态转换策略中被调用，将报文的源地址转换为IPv6地址。

\[NAT\] aft prefix-nat64 2012:: 96

配置IPv4到IPv6源地址动态转换策略，将匹配ACL
2000报文的源地址根据NAT64前缀转换为IPv6地址。

\[NAT\] aft v4tov6 source acl number 2000 prefix-nat64 2012:: 96

配置IPv6到IPv4的源地址静态转换策略，用于将报文的目的地址转换为IPv6地址。

\[NAT\] aft v6tov4 source 2013:0:ff14:0101:100:: 20.1.1.1

在IPv4侧接口GigabitEthernet0/0开启AFT。

\[NAT\] interface gigabitethernet 0/0

\[NAT-GigabitEthernet0/0\] aft enable

\[NAT-GigabitEthernet0/0\] quit

在IPv6侧接口GigabitEthernet0/1开启AFT。

\[NAT\] interface gigabitethernet 0/1

\[NAT-GigabitEthernet0/1\] aft enable

\[NAT-GigabitEthernet0/1\] quit

## 测试结果：

以上配置完成后，检查IPv4 host与IPv6 server的连通性。以IPv4 host A ping
IPv6 server为例：

![](./Media//image1.png)


通过查看AFT会话，可以看到创建了一个IPv4会话和IPv6会话，分别对应转换前和转换后的报文。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
