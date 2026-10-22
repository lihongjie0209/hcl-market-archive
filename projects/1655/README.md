# 地址重叠的两个VPN之间互访配置

**标签：**

**NAT**

## 需求

某公司两个部门由于需要业务隔而分属不同的VPN实例，且两个部门内部使用了相同的子网地址空间。现在要求这两个部门的主机Host
A 和Host B之间能够通过NAT地址互相访问。

## 实验步骤：

1、按照组网图配置各接口的IP地址。

2、配置NAT

配置VPN 1内的IP地址192.168.1.2到VPN
2内的IP地址172.16.1.2之间的静态地址转换映射。

nat static outbound 192.168.1.2 vpn-instance vpn1 172.16.1.2
vpn-instance vpn2

配置VPN 2内的IP地址192.168.1.2到VPN
1内的IP地址172.16.2.2之间的静态地址转换映射。

nat static outbound 192.168.1.2 vpn-instance vpn2 172.16.2.2
vpn-instance vpn1

在接口GigabitEthernet0/0上配置静态地址转换。

\#

interface GigabitEthernet0/0

ip binding vpn-instance vpn1

ip address 192.168.1.1 255.255.255.0

nat static enable

\#

在接口GigabitEthernet0/1上配置静态地址转换。

\#

interface GigabitEthernet0/1

ip binding vpn-instance vpn2

ip address 192.168.1.1 255.255.255.0

nat static enable

\#

## 测试结果：

通过以下显示命令，可以看到Host A访问Host B时生成NAT会话信息。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
