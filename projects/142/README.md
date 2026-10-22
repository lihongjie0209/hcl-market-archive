**标签：**

IPSEC

Ikev2

主模式

**需求：**

通过ikev2的方式建立ipsec隧道，其中ipsec为主模式。

**实验步骤：**

1.  配置所有设备的接口ip地址，路由。

2、配置ipsec

FW1:

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

pre-shared-key ciphertext \$c\$3\$JGzs6r29cbUWnZu7BHvbWLkS50GfOQ==

\#

ikev2 profile ly

authentication-method local pre-share

authentication-method remote pre-share

keychain ly

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

FW2:

\#

ipsec transform-set ly

esp encryption-algorithm aes-cbc-128

esp authentication-algorithm sha1

\#

ipsec policy ly 1 isakmp

transform-set ly

security acl 3001

local-address 3.1.1.1

remote-address 2.1.1.1

ikev2-profile ly

\#

ip http enable

ip https enable

\#

ikev2 keychain ly

peer 1

address 2.1.1.1 255.255.255.0

identity address 2.1.1.1

pre-shared-key ciphertext \$c\$3\$jI6RVpjPfYPASUAOQEuJeUpZk//k8A==

\#

ikev2 profile ly

authentication-method local pre-share

authentication-method remote pre-share

keychain ly

match remote identity address 2.1.1.1 255.255.255.0

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

1.1.1.1 ping 1.1.3.1

![](./Media//image1.png)


FW1：

![](./Media//image2.png)


![](./Media//image3.png)


FW2：

![](./Media//image4.png)


![](./Media//image5.png)

