# PPPoE使用Radius认证（IP POOL分配地址）

**标签：**

**PPPoE**

## 需求

Host PPPoE拨号接入，BRAS分配IP地址，认证由AAA实现。

## 实验步骤：

1、配置各接口的IP地址

2、配置PPPoE

\#

ip pool 1 192.168.137.2 192.168.137.254

ip pool 1 gateway 192.168.127.1

\#

interface Virtual-Template1

ppp authentication-mode pap domain pppoe

ppp ipcp dns 114.114.114.114

remote address pool 1

ppp account-statistics enable

\#

radius scheme rs

primary authentication 192.168.56.1 key cipher
\$c\$3\$Qy49WrJTyU1al9VAkD51XSpqmuc5YWf3SA==

primary accounting 192.168.56.1 key cipher
\$c\$3\$kodGWt0a57WQf9kxePuWJNs8bbAGQFtD2A==

user-name-format without-domain

nas-ip 192.168.56.2

\#

## 测试结果：

用户认证时，到AAA认证，显示已经认证成功：

![](./Media//image1.png)


BRAS查看用户已经接入：

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
