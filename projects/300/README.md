**IKE主模式及预共享秘钥认证配置举例**

# 标签：

**主模式**

**预共享秘钥**

# 需求：

在Device A和Device B之间建立一个IPsec隧道，对Host
A所在的子网（10.1.1.0/24）与Host
B所在的子网（10.1.2.0/24）之间的数据流进行安全保护。

# 实验步骤： 

RTA和RTB,RTC配置接口地址，安全提议，感兴趣流，IKE profile以及静态路由。

# 测试结果：

**1.查看IKE提议**

\[A\]dis ike proposal

Priority Authentication Authentication Encryption Diffie-Hellman
Duration

method algorithm algorithm group (seconds)

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

default **PRE-SHARED-KEY SHA1 DES-CBC Group 1** 86400

\[B\]dis ike proposal

Priority Authentication Authentication Encryption Diffie-Hellman
Duration

method algorithm algorithm group (seconds)

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

default PRE-SHARED-KEY SHA1 DES-CBC Group 1 86400

**2.查看ike sa和ipsec sa状态。**

**\[A\]dis ike sa**

Connection-ID Local Remote Flag DOI

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

1 1.1.1.1 1.1.1.2 RD IPsec

Flags:

RD\--READY RL\--REPLACED FD-FADING RK-REKEY

**\[A\]display ipsec sa**

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Interface: GigabitEthernet0/0

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

IPsec policy: map1

Sequence number: 10

Mode: ISAKMP

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Tunnel id: 0

Encapsulation mode: tunnel

Perfect Forward Secrecy:

Inside VPN:

Extended Sequence Numbers enable: N

Traffic Flow Confidentiality enable: N

Transmitting entity: Initiator

Path MTU: 1440

Tunnel:

local address: 1.1.1.1

remote address: 1.1.1.2

Flow:

sour addr: 2.1.1.1/255.255.255.255 port: 0 protocol: ip

dest addr: 3.1.1.1/255.255.255.255 port: 0 protocol: ip

\[Inbound ESP SAs\]

SPI: 1969048000 (0x755d49c0)

Connection ID: 4294967296

Transform set: ESP-ENCRYPT-AES-CBC-128

SA duration (kilobytes/sec): 1843200/3600

SA remaining duration (kilobytes/sec): 1843199/3366

Max received sequence-number: 0

Anti-replay check enable: N

Anti-replay window size:

UDP encapsulation used for NAT traversal: N

Status: Active

\[Outbound ESP SAs\]

SPI: 3153954311 (0xbbfd8607)

Connection ID: 4294967297

Transform set: ESP-ENCRYPT-AES-CBC-128

SA duration (kilobytes/sec): 1843200/3600

SA remaining duration (kilobytes/sec): 1843199/3366

Max sent sequence-number: 4

UDP encapsulation used for NAT traversal: N

Status: Active

**说明：**

1、本实验用的模拟器为MSR36-20，设置内存为默认。

（如果用的是vsr-88或其他需要自己调整内存的设备，请注明设备所设置的内存是多少。）

2、本实验用的路由器版本为默认。

（默认是B75分支，如果所用的vmdk版本是B59或者其他定制版本，请说明，并告知vmdk放在什么地方可共享，如：本实验所用设备vmdk版本为B59，vmdk文件及更换版本操作方法均放在ftp，路径为：新版本已上传FTP：/01-IP网络产品/03-中低端路由器（AR、MSR、ICG、VG、LA）/99
临时目录/模拟器/模拟器版本/）

3、建议工程模拟器设备名称为体统默认。
