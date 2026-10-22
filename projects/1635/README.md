# IPv6 BGP 通过IPsec保护报文配置

**标签：**

**BGP**

## 需求

Router A、Router B和Router C三台路由器之间运行IPv6
BGP交互路由信息。Router A和Router B之间建立IBGP连接，Router B和Router
C之间建立EBGP连接。

为了提高安全性，配置通过IPsec对IPv6 BGP报文进行保护。

## 实验步骤：

1、配置各接口的IPv6地址

2、配置IPsec框架，并应用于BGP

以RTA为例：

\#

ipsec transform-set tran1

encapsulation-mode transport

esp encryption-algorithm des-cbc

esp authentication-algorithm sha1

\#

ipsec profile policy001 manual

transform-set tran1

sa spi inbound esp 12345

sa string-key inbound esp cipher
\$c\$3\$jH+bYZ47LE3qBwJbBcvkIa5G9eMAHC7SoHg=

sa spi outbound esp 12345

sa string-key outbound esp cipher
\$c\$3\$azrxW/WgACJq5WNqO1ExKbBr7KRrFFRb+jg=

\#

\#

bgp 65008

router-id 1.1.1.1

group ibgp internal

peer 1::2 group ibgp

peer 1::2 ipsec-profile policy001

\#

address-family ipv6 unicast

peer ibgp enable

\#

## 测试结果：

在Router B上显示IPv6
BGP对等体的详细信息。可以看出完成上述配置后IBGP、EBGP对等体能够正常建立，且发送和接收的IPv6
BGP报文都经过加密。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
