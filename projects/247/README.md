# OSPFv3 IPsec安全框架配置

## 需求：

1.  所有的路由器都运行OSPFv3，整个自治系统划分为2个区域。

2.  要求配置IPsec安全框架对Router A、Router B和Router
    C之间的OSPFv3报文进行有效性检查和验证。

## 实验步骤：

1.  配置各接口的IPv6地址

2.  配置OSPFv3基本功能

3.  配置OSPFv3 IPsec安全框架

4.  配置OSPFv3区域上应用IPsec安全框架

以RTA配置为例：

\#

ospfv3 1

router-id 1.1.1.1

area 0.0.0.1

enable ipsec-profile profile001

\#

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ospfv3 1 area 0.0.0.1

ipv6 address 2001:1::2/64

\#

ipsec transform-set trans

encapsulation-mode transport

esp encryption-algorithm aes-cbc-128

esp authentication-algorithm sha1

\#

ipsec profile profile001 manual

transform-set trans

sa spi inbound esp 123456

sa string-key inbound esp cipher
\$c\$3\$0z1ITmmyecUF/gmxw8Y5S48nQbkWolVmJnk=

sa spi outbound esp 123456

sa string-key outbound esp cipher
\$c\$3\$wkAJmTB9d7ju9VSbhVIUV9ByOnJpENSVwPA=

\#

## 测试结果：

以上配置完成后，区域1中应用了IPsec profile profile001。

![](./Media//image1.png)


Router A、Router B和Router C之间的OSPFv3报文将被加密传输。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
