# 内网口外网口不同VPN NAT配置

**标签：**

**NAT**

## 需求

设备内网口与外网口处于不同的VPN实例，通过配置PBR实现跨不同VPN做NAT上网。

## 实验步骤：

1.  配置各接口的IP地址与路由

\#

ip route-static 0.0.0.0 0 vpn-instance vpn1 1.1.1.2

\#

2、NAT配置

\#

interface GigabitEthernet0/1

ip binding vpn-instance vpn1

ip address 1.1.1.1 255.255.255.252

nat outbound 3000 vpn-instance vpn1

\#

acl advanced 3000

rule 0 permit ip source 192.168.0.0 0.0.0.255

\#

3、回程路由匹配PBR，转到public处理

\#

policy-based-route aaa permit node 10

apply access-vpn public

\#

interface GigabitEthernet0/1

ip policy-based-route aaa

\#

## 测试结果：

配置完成后，PC可以访问外网：

![](./Media//image1.png)


设备存在相应的NAT会话：

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
