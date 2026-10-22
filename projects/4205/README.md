# 工程名称
V7交换机开启web登陆


## 需求
交换机管理vlan为vlan1，需要使用vlan10的ip地址登陆交换机web界面


## 实验步骤：
1、交换机vlan1配置地址
#
interface Vlan-interface1
 ip address 192.168.1.1 255.255.255.0
#

2、开启web登陆
#
 ip http enable
 ip https enable
#


3、配置登陆用户admin,密码为1qaz!QAZ（现网设备请配置高复杂度密码）
#
local-user admin
 password simple 1qaz!QAZ
 service-type http https
 authorization-attribute user-role network-admin
#

## 测试结果：
PC可以访问交换机vlan-int1的地址登陆web页面



## 说明： 
1、交换机通过ip http enable和ip https enable开启web登陆

3、登陆web需要配置服务类型为http、https的用户，并赋予用户权限，其中network-admin是最高权限


