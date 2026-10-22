# 工程名称

DHCPv6服务器典型配置例


## 需求：
1. 作为DHCPv6服务器的AC为AP分配1::1:0:0:0/96网段、客户端分配1::2:0:0:0/96网段的IPv6地址；

2. AC的两个VLAN接口Vlan-interface10和Vlan-interface20的地址分别为1::1:0:0:1/96和1::2:0:0:1/96。

## 实验步骤：
组网图：

![1](./Media/图片1.png) 

【AC配置过程】

1. 配置DHCPv6 server各接口的IPv6地址。取消设备发布RA消息的抑制。配置被管理地址的配置标志位为1，即主机通过DHCPv6服务器获取IPv6地址。配置其他信息配置标志位为1，即主机通过DHCPv6服务器获取除IPv6地址以外的其他信息；
2. 配置端口属于VLAN及对应VLAN接口的IP地址，将与AP连接的接口加入VLAN10中；
3. 配置无线服务,配置无线服务模板并把服务模板加入VLAN20中；
4. 配置DHCPv6服务，配置接口Vlan-interface10和Vlan-interface20工作在DHCPv6服务器模式，配置DHCPv6地址池1，为1::1:0:0:0/96网段的客户端分配IPv6地址等参数，配置DHCPv6地址池2，为1::2:0:0:0/96网段的客户端分配IPv6地址等参数。

【交换机配置】

交换机和AC及AP的端口都配置trunk口，放通管理vlan 10和业务vlan 20，pvid打vlan 10，同时交换机也从AC的DHCPv6获取地址。

## 测试结果：
1. 查看AP在AC上线情况；
2. 查看AP从AC获取的IPv6地址；
3. 查看AC分配出去的IPv6地址；
4. AC ping AP的ipv6地址可以通。

![2](./Media/图片2.png) 

## 说明： 


