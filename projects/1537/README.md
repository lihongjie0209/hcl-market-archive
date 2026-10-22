# RIPng IPsec安全框架配置

**标签：**

**RIPng**

## 需求

Router A、Router B和Router C相连并通过RIPng来学习网络中的IPv6路由信息。

要求配置IPsec安全框架对Router A、Router B和Router
C之间的RIPng报文进行有效性检查和验证。

## 实验步骤：

1、配置各接口的IPv6地址

2、配置RIPng基本功能

3、配置RIPng IPsec安全框架，以Router A为例

创建名为protrf1的安全提议，报文封装形式采用传输模式，安全协议采用ESP协议。创建一条安全框架profile001，协商方式为manual，配置SPI和密钥。

\#

ipsec transform-set protrf1

encapsulation-mode transport

esp encryption-algorithm 3des-cbc

esp authentication-algorithm md5

\#

ipsec profile profile001 manual

transform-set protrf1

sa spi inbound esp 256

sa string-key inbound esp cipher
\$c\$3\$a6fWltpRpF1euLlyNkwmQKLuYz3/Mw==

sa spi outbound esp 256

sa string-key outbound esp cipher
\$c\$3\$PV33JAUcuMN2e/nIm+nwSgaEue5EOQ==

\#

4、RIPng进程上应用IPsec安全框架，以Router A为例

\#

ripng 1

enable ipsec-profile profile001

\#

## 测试结果：

以上配置完成后，Router A、Router B和Router
C之间的RIPng报文将被加密传输。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
