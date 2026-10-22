**标签：**

IPSEC

GRE

VPN

FQDN

**需求：**

搭建gre over
ipsec的隧道，其中ipsec为野蛮模式，MSR36-20_3为NAT设备，做SNAT转换源地址，F1060_1为分支设备，F1060_2为总部设备并使用模板方式。

**实验步骤：**

1.  配置所有设备的接口ip地址，路由以及nat配置。

2.  配置gre隧道

分支：

创建LoopBack0作为gre隧道的源地址

\#

interface LoopBack0

ip address 6.6.6.6 255.255.255.255

\#

interface Tunnel0 mode gre

ip address 5.5.5.1 255.255.255.0

source 6.6.6.6

destination 3.1.1.1

总部：

使用公网接口ip作为gre隧道的源地址

\#

interface Tunnel0 mode gre

ip address 5.5.5.2 255.255.255.0

source 3.1.1.1

destination 6.6.6.6

3、配置ipsec

分支：

\#

ipsec transform-set ly

esp encryption-algorithm aes-cbc-128

esp authentication-algorithm sha1

\#

ipsec policy ly 1 isakmp

transform-set ly

security acl 3001

remote-address 3.1.1.1

ike-profile ly

\#

ike profile ly

keychain ly

exchange-mode aggressive

local-identity user-fqdn fz

match remote identity address 3.1.1.1 255.255.255.0

\#

ike keychain ly

pre-shared-key address 3.1.1.1 255.255.255.255 key cipher
\$c\$3\$nThNx89WMTwCTqNNp/xrGOZ9QvNx2A==

总部：

\#

ipsec transform-set ly

esp encryption-algorithm aes-cbc-128

esp authentication-algorithm sha1

\#

ipsec policy-template ly 1

transform-set ly

ike-profile ly

\#

ipsec policy ly 1 isakmp template ly

\#

ike profile ly

keychain ly

exchange-mode aggressive

match remote identity user-fqdn fz

\#

ike keychain ly

pre-shared-key address 3.1.1.2 255.255.255.255 key cipher
\$c\$3\$E9lniiqZINr1fcEfEdwuYGUtJ/Av5A==

**测试结果：**

分支侧1.1.1.1 ping 总部侧1.1.3.1

![](./Media//image1.png)


分支：

![](./Media//image2.png)


![](./Media//image3.png)


总部：

![](./Media//image4.png)


![](./Media//image5.png)


**说明：**

模拟拨号口公网ip地址不固定，所以采用野蛮模式，配合nat穿越，需要保证中间nat设备有到loopback
0的路由。而且ipsec响应方的gre隧道目的地址为发起方固定的loopback 0地址。
