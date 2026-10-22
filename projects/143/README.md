**标签：**

IPSEC

L2TP

NAT 穿越

INODE 拨号

**需求：**

l2tp over ipsec+NAT穿越+inode拨号实验，要求能拨号成功。

拓扑：

![](./Media//image1.png)


**实验步骤：**

注意：

host是拿虚机做的，需要cmd里面手动添加2.1.1.0网段的明细路由，下一跳1.1.1.2
**route add 2.1.1.0 mask 255.255.255.0 1.1.1.2**

 

配置：

NAT设备：

\#

interface GigabitEthernet0/0

port link-mode route

combo enable copper

**ip address 1.1.1.2 255.255.255.0**

**nat server global 1.1.1.3 inside 2.1.1.1**

\#

interface GigabitEthernet0/1

port link-mode route

combo enable copper

**ip address 2.1.1.2 255.255.255.0**

 

server设备：

\#

interface GigabitEthernet1/0/2

port link-mode route

combo enable copper

**ip address 5.5.5.1 255.255.255.0**

\#

**ip route-static 0.0.0.0 0 5.5.5.2**

 

FW兼LNS：

\#

ip pool ly 6.6.6.2 6.6.6.6

ip pool ly gateway 6.6.6.1

\#

interface Virtual-Template1

ppp authentication-mode chap

remote address pool ly

ip address 6.6.6.1 255.255.255.0

\#

interface GigabitEthernet1/0/1

port link-mode route

combo enable copper

ip address 2.1.1.1 255.255.255.0

ipsec apply policy ly

\#

interface GigabitEthernet1/0/2

port link-mode route

combo enable copper

ip address 5.5.5.2 255.255.255.0

\#

security-zone name Untrust

import interface GigabitEthernet1/0/1

import interface Virtual-Template1

\#

ip route-static 1.1.1.0 24 2.1.1.2

\#

local-user ceshi class network

password cipher \$c\$3\$JgffFxueYe0BRMiSIlRP8X+VQtR86A==

service-type ppp

authorization-attribute user-role network-operator

\#

ipsec transform-set ly

esp encryption-algorithm 3des-cbc

esp authentication-algorithm md5

\#

ipsec policy-template ly 1

transform-set ly

ike-profile ly

\#

ipsec policy ly 1 isakmp template ly

\#

l2tp-group 1 mode lns

allow l2tp virtual-template 1

undo tunnel authentication

tunnel name LNS

\#

l2tp enable

\#

ike profile ly //**FW&LNS侧可以主模式也可以野蛮模式**

keychain ly

local-identity fqdn LNS

match remote identity fqdn LAC

\#

ike keychain ly

pre-shared-key hostname LAC key cipher
\$c\$3\$oXhtkkNyih1MfeP2Ddkd0XWnCl/t0A==

\#

security-policy ip

rule 0 name 1

action pass

PC：（inode版本E0582）

![计算机生成了可选文字: iNode 智 能 客 户 端 L2TP IPsec VPN 连 接 用 户
名 ceshi 密 码 、 ， 保 存 用 户 名 、 ， 保 存 密 码 连 接
](./Media//image2.png)


 

![计算机生成了可选文字: 属 性 设 置 基 本 设 置 连 接 设 置 LNS 服 务 器
2 1 1 1 备 用 LNS 服 务 器 2 1 1 1 囝 认 证 时 清 除 ARP 表 项 囗 上 传
客 户 端 版 本 号 \[ 〕 \] 从 智 能 卡 读 取 用 户 名 密 码 \[ 〕 \] 从
证 书 读 取 用 户 名 和 密 码 囗 被 动 下 线 时 自 动 重 连 囗 运 行 后
自 动 认 证 囗 单 点 登 录 连 接 囝 启 用 IPsec 安 全 协 议 验 证 方 法
： 预 共 享 密 钥 身 份 验 证 宇 · · · 证 书 设 置 ． ． ． IPsec 服 务
器 O 使 用 LNS 服 务 器 @ 使 用 其 它 IPsec 服 务 器 IPsec 服 务 器 1 1
1 3 骨 级
](./Media//image3.png)


 

![计算机生成了可选文字: 高 级 属 性 L2TPi\' 殳 、置 IPseci\' 殳 、置
L2TP 协 议 设 置 隧 道 名 称 ： 选 择 认 证 模 式 ． 发 送 HELLO 报 文
时 间 间 隔 ． L2Tp 端 口 ： 囗 使 用 隧 這 验 证 密 码 隧 道 验 证 密
码 ： \[ 〕 \] 启 用 AVP 隐 藏 IKEi 殳 、置 L N S CHAP 60 1701 路 由 设
置
](./Media//image4.png)


 

![计算机生成了可选文字: 高 级 属 性 L2TPi\' 殳 、置 IPseci 殳 、置 IKEi
殳 、置 路 由 设 置 IPsec 安 全 提 议 设 置 封 装 模 式 ． 安 全 联 盟
生 存 周 期 ： 采 用 的 安 全 协 议 ： ESP 协 议 验 证 算 法 ： 协 议 加
密 算 法 ： E S P AH 协 议 验 证 算 法 ： 囗 使 用 PFS 特 性 unnel 36 S
P M D 5 3D E S D 5 PFSÉ 性 ， 卜 ， 〕 ， 囝 使 用 NAT 穿 越
](./Media//image5.png)


 

![计算机生成了可选文字: 高 级 属 性 L2TPi\' 殳 、置 IPseci 殳 、置 IKE
设 置 路 由 设 置 IKE 安 全 提 议 设 置 协 商 模 式 ． 验 证 算 法 ： ID
的 类 型 ． 加 密 算 法 ： IKE 端 口 ： ame DES-CBC 500 ggresslve SHA
Diffie-Hellman 组 标 Groupl ISAKMP-SA 生 存 周 期 ： 864m 本 端 安 全 网
关 名 宇 LAC 对 端 安 全 网 关 设 备 名 宇 LNS 囗 定 时 发 \*KeepAlive
报 文 时 间 间 隔 ： 0 囗 接 收 KeepAlive 报 文 超 时 时 可 0
](./Media//image6.png)


 

 

**测试结果：**

![计算机生成了可选文字: IPsec V 声 N ． 眄 IKE 协 商 ．． 正 在 进 行 \]
KE 协 商
](./Media//image7.png)


 

![计算机生成了可选文字: IPsec VP N 认 证 PPP 协 商 " 正 在 进 行 PPP 协
商
](./Media//image8.png)


 

![计算机生成了可选文字: IPsec VPN 认 证 获 取 虚 拟 网 卡 IP 地 址 ． "
正 在 获 取 虚 拟 网 卡 的 p 地 址
](./Media//image9.png)


 

![计算机生成了可选文字: IPsec VPN 认 证 获 取 虚 拟 网 卡 IP 地 址 ． ．
． 当 前 IP 地 址 是 6 ． 6 ． 6 ． 5
](./Media//image10.png)


 

![计算机生成了可选文字: IPsec VPN 认 证 连 接 成 功 ， 己 上 线
](./Media//image11.png)


 

**可以ping通总部侧的server地址，可以访问内网server资源**

66666666


 

FW上面的日志：

\<FW\>%Aug 13 12:39:25:367 2021 FW IFNET/3/PHY_UPDOWN: -Context=1;
Physical state on the interface Virtual-Access0 changed to up.

%Aug 13 12:39:25:375 2021 FW IFNET/5/LINK_UPDOWN: -Context=1; Line
protocol state on the interface Virtual-Access0 changed to up.

%Aug 13 12:39:29:230 2021 FW IFNET/5/LINK_UPDOWN: -Context=1; Line
protocol state on the interface Virtual-Access0 changed to down.

%Aug 13 12:39:29:238 2021 FW IFNET/5/LINK_UPDOWN: -Context=1; Line
protocol state on the interface Virtual-Access0 changed to up.

 

\<FW\>**dis ike sa**

Connection-ID Remote Flag DOI

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

12 1.1.1.1 RD IPsec

Flags:

RD\--READY RL\--REPLACED FD-FADING RK-REKEY

 

\<FW\>**dis ike sa verbose**

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Connection ID: 12

Outside VPN:

Inside VPN:

Profile: ly

Transmitting entity: Responder

Initiator cookie: 3041fce923c40cfb

Responder cookie: 8dca449bb9812d8c

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Local IP: 2.1.1.1

Local ID type: FQDN

Local ID: LNS

 

Remote IP: 1.1.1.1

Remote ID type: FQDN

Remote ID: LAC

 

Authentication-method: PRE-SHARED-KEY

Authentication-algorithm: SHA1

Encryption-algorithm: DES-CBC

 

Life duration(sec): 86400

Remaining key duration(sec): 86376

Exchange-mode: Aggressive

Diffie-Hellman group: Group 1

NAT traversal: Detected

 

Extend authentication: Disabled

Assigned IP address:

Vendor ID index:0xffffffff

Vendor ID sequence number:0x0

 

\<FW\>**dis ipsec sa**

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Interface: GigabitEthernet1/0/1

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

 

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

IPsec policy: ly

Sequence number: 1

Mode: Template

\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\-\--

Tunnel id: 0

Encapsulation mode: tunnel

Perfect Forward Secrecy:

Inside VPN:

Extended Sequence Numbers enable: N

Traffic Flow Confidentiality enable: N

Path MTU: 1436

Tunnel:

local address: 2.1.1.1

remote address: 1.1.1.1

Flow:

sour addr: 2.1.1.1/255.255.255.255 port: 1701 protocol: udp

dest addr: 1.1.1.1/255.255.255.255 port: 0 protocol: udp

 

\[Inbound ESP SAs\]

SPI: 627628130 (0x2568d862)

Connection ID: 124554051585

Transform set: ESP-ENCRYPT-3DES-CBC ESP-AUTH-MD5

SA duration (kilobytes/sec): 1843200/3600

SA remaining duration (kilobytes/sec): 1843193/3573

Max received sequence-number: 66

Anti-replay check enable: Y

Anti-replay window size: 64

UDP encapsulation used for NAT traversal: Y

Status: Active

 

\[Outbound ESP SAs\]

SPI: 2537326403 (0x973c8743)

Connection ID: 115964116992

Transform set: ESP-ENCRYPT-3DES-CBC ESP-AUTH-MD5

SA duration (kilobytes/sec): 1843200/3600

SA remaining duration (kilobytes/sec): 1843199/3573

Max sent sequence-number: 15

UDP encapsulation used for NAT traversal: Y

Status: Active

\<FW\>**dis l2tp session**

LocalSID RemoteSID LocalTID State

20811 6460 19166 Established

 

\<FW\>**dis l2tp tunnel**

LocalTID RemoteTID State Sessions RemoteAddress RemotePort RemoteName

19166 1 Established 1 1.1.1.1 53305 LNS

 

\<FW\>**dis l2tp tunnel statistics**

Total number of tunnels: 1
