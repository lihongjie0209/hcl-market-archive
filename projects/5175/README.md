# GRE Over IPSec配置示例

**标签：**

**GRE**

**IPSec**

## 需求

RTA与RTC之间建立GRE隧道，同时需要对GRE数据流进行加密，这里采用GRE Over
IPSec的配置。

## 实验步骤：

1、配置各接口的IP地址

2、配置GRE基本功能，配置keepalive进行保活，检测隧道状况

3、配置IPsec保护GRE源、目的地址网段

以RTA为例：

\#

interface LoopBack0

ip address 192.168.1.1 255.255.255.255

\#

interface GigabitEthernet0/0

ip address 1.1.1.1 255.255.255.0

ipsec apply policy 1

\#

interface Tunnel0 mode gre

ip address 192.168.3.1 255.255.255.0

source 1.1.1.1

destination 2.2.2.1

keepalive 10 3

\#

ip route-static 0.0.0.0 0 1.1.1.2

ip route-static 192.168.2.0 24 Tunnel0

#保护流是Gre的源、目的地址

acl advanced 3000

rule 0 permit gre source 1.1.1.1 0 destination 2.2.2.1 0

\#

ipsec transform-set tran1

esp encryption-algorithm aes-cbc-128

esp authentication-algorithm sha1

\#

ipsec policy 1 1 isakmp

transform-set tran1

security acl 3000

remote-address 2.2.2.1

ike-profile 1

\#

ike profile 1

keychain 1

local-identity address 1.1.1.1

match remote identity address 2.2.2.1 255.255.255.0

proposal 1

\#

ike proposal 1

\#

ike keychain 1

pre-shared-key address 2.2.2.1 255.255.255.255 key cipher
\$c\$3\$hkBK0QaK54Q9QRjgZYb4egw3lW9Y/Q==

\#

## 测试结果

流量触发后，IPSec隧道已经建立：

\<RTA\>dis ike sa

Connection-ID Local Remote Flag DOI

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

1 1.1.1.1 2.2.2.1 RD IPsec

Flags:

RD\--READY RL\--REPLACED FD-FADING RK-REKEY

\<RTA\>dis ipsec sa

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Interface: GigabitEthernet0/0

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

IPsec policy: 1

Sequence number: 1

Mode: ISAKMP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Tunnel id: 0

Encapsulation mode: tunnel

Perfect Forward Secrecy:

Inside VPN:

Extended Sequence Numbers enable: N

Traffic Flow Confidentiality enable: N

Transmitting entity: Initiator

Path MTU: 1428

Tunnel:

local address: 1.1.1.1

remote address: 2.2.2.1

Flow:

sour addr: 1.1.1.1/255.255.255.255 port: 0 protocol: gre

dest addr: 2.2.2.1/255.255.255.255 port: 0 protocol: gre

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
