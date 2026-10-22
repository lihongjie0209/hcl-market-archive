**标签：**

IPSEC

FQDN

NAT 穿越

Ikev2

**需求：**

通过ikev2的方式建立ipsec隧道，其中ipsec为野蛮模式，MSR36-20_3为NAT设备，做SNAT转换源地址，F1060_1为分支设备，F1060_2为总部设备并使用模板方式。

**实验步骤：**

1.  配置所有设备的接口ip地址，路由以及nat配置。

2、配置ipsec

分支：

\#

ipsec transform-set ly

esp encryption-algorithm aes-cbc-128

esp authentication-algorithm sha1

\#

ipsec policy ly 1 isakmp

transform-set ly

security acl 3001

local-address 2.1.1.1

remote-address 3.1.1.1

ikev2-profile ly

\#

ip http enable

ip https enable

\#

ikev2 keychain ly

peer 1

address 3.1.1.1 255.255.255.0

identity address 3.1.1.1

pre-shared-key ciphertext \$c\$3\$3R37sXOyYOJ7vx9G88veM+edEXjZ1Q==

\#

ikev2 profile ly

authentication-method local pre-share

authentication-method remote pre-share

keychain ly

identity local fqdn fz

match remote identity address 3.1.1.1 255.255.255.0

\#

ikev2 proposal ly

encryption aes-cbc-128

integrity sha256

dh group24

prf sha256

\#

ikev2 policy ly

proposal ly

总部：

\#

ipsec transform-set ly

esp encryption-algorithm aes-cbc-128

esp authentication-algorithm sha1

\#

ipsec policy-template ly 1

transform-set ly

ikev2-profile ly

\#

ipsec policy ly 1 isakmp template ly

\#

ip http enable

ip https enable

\#

ikev2 keychain ly

peer 1

address 3.1.1.2 255.255.255.255

identity address 3.1.1.2

pre-shared-key ciphertext \$c\$3\$QV2h72m7Tl6e4ySOPzfM3ihRoLiEcw==

\#

ikev2 profile ly

authentication-method local pre-share

authentication-method remote pre-share

keychain ly

match remote identity fqdn fz

\#

ikev2 proposal ly

encryption aes-cbc-128

integrity sha256

dh group24

prf sha256

\#

ikev2 policy ly

proposal ly

**测试结果：**

分支侧1.1.1.1 ping 总部侧1.1.3.1

![](./Media//image1.png)


分支：

![](./Media//image2.png)


![](./Media//image3.png)


总部：

![](./Media//image4.png)


![](./Media//image5.png)

