# DHCPv6实验

**标签：**

**DHCPv6**

## 需求

服务器给Client分发IPv6地址，同时下发IPv6前缀2001:410::/48。Client接口引用前缀生成IPv6地址，Host使用无状态获取IPv6地址。

## 实验步骤：

配置IPv6前缀池：

\#

ipv6 dhcp prefix-pool 1 prefix 2001:4001::/32 assign-len 48

\#

配置IPv6地址池：

\#

ipv6 dhcp pool 1

network 1::/64

prefix-pool 1

\#

配置有状态分配地址：

\#

interface GigabitEthernet0/0

ipv6 dhcp select server

ipv6 address 1::1/64

ipv6 nd autoconfig managed-address-flag

ipv6 nd autoconfig other-flag

undo ipv6 nd ra halt

\#

## 测试结果

Client可以获取到IPv6地址与前缀。

\[Client\]dis ipv6 int b

\*down: administratively down

(s): spoofing

Interface Physical Protocol IPv6 Address

GigabitEthernet0/0 up up 2001:4001::2

GigabitEthernet0/1 up up 1::2

GigabitEthernet0/2 down down Unassigned

GigabitEthernet5/0 down down Unassigned

GigabitEthernet5/1 down down Unassigned

GigabitEthernet6/0 down down Unassigned

GigabitEthernet6/1 down down Unassigned

Serial1/0 down down Unassigned

Serial2/0 down down Unassigned

Serial3/0 down down Unassigned

Serial4/0 down down Unassigned

\[Client\]dis ipv6 dhcp client

GigabitEthernet0/1:

Type: Stateful client requesting prefix

State: OPEN

Client DUID: 000300013aad36a20200

Preferred server:

Reachable via address: FE80::38AD:34FF:FE1F:105

Server DUID: 000300013aad341f0100

IA_PD: IAID 0x00000002, T1 302400 sec, T2 483840 sec

Prefix: 2001:4001::/48

Preferred lifetime 604800 sec, valid lifetime 2592000 sec

Will expire on Nov 12 2022 at 16:50:42 (2591422 seconds left)

Type: Stateful client requesting address

State: OPEN

Client DUID: 000300013aad36a20200

Preferred server:

Reachable via address: FE80::38AD:34FF:FE1F:105

Server DUID: 000300013aad341f0100

IA_NA: IAID 0x00000002, T1 302400 sec, T2 483840 sec

Address: 1::2

Preferred lifetime 604800 sec, valid lifetime 2592000 sec

Will expire on Nov 12 2022 at 16:50:42 (2591422 seconds left)

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
