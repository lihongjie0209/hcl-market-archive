# 工程名称
接口通过DHCPv6协议无状态获取IP地址配置举例


## 需求：
AP1和AP2分别通过无状态获取方式获取vlan 100和200网段的IP地址，然后使用此地址与AC建立CAPWAP隧道。


## 实验步骤：
组网图：

![1](./Media/图片1.png) 


1. AC上配置vlan 100和200，在int vlan 100和200虚接口分别配置对应网段的IPv6地址，关闭抑制发布RA消息，AC和SWA的端口为配置为trunk口，放通vlan 100和200；
2. SWA上配置vlan 100和200接口，分别和AP1和AP2的接口配置access vlan 100和200，让AP1和AP2分别从vlan 100和200获取IPv6地址，SWA的int vlan 100和200分别配置为ipv6 address auto，即开启端口的无状态地址获取功能。
3. 在AP1和AP2的int vlan 1接口上配置ipv6 address auto，即开启端口的无状态地址获取功能。

## 测试结果：
1. SWA通过无状态方式获取了ipv6地址如下：
2. AC上查看AP1和AP2已经注册上线，两个AP分别通过无状态方式获取了vlan 100 和 200的地址：

![2](./Media/图片2.png) 

3. SWA和AP1接口抓取的AP1通过无状态方式获取IPv6地址的过程。

![3](./Media/图片3.png) 

## 说明： 


