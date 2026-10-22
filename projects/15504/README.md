# 工程名称

多分支IPSEC典型配置

## 需求：

总部分别与分支1以及分支2建立IPSEC，分别使用loopback地址模拟内网地址

## 实验步骤：
MSR1配置：
接口配置；
interface LoopBack0
 ip address 10.0.0.1 255.255.255.255

interface GigabitEthernet0/0
 port link-mode route
 combo enable copper
 ip address 1.1.1.1 255.255.255.0
 ipsec apply policy policy1

路由配置：
公网路由配置：
ip route-static 2.2.2.0 24 1.1.1.2
ip route-static 3.3.3.0 24 1.1.1.2
私网路由配置：
ip route-static 10.0.1.1 32 1.1.1.2
ip route-static 10.0.2.1 32 1.1.1.2


IKE配置：
ike identity fqdn zongbu
ike proposal 1
ike keychain keychain1
 pre-shared-key hostname fenzhi1 key simple h3c
 pre-shared-key hostname fenzhi key simple h3c
ike profile profile1
 keychain keychain1
 exchange-mode aggressive
 match remote identity fqdn fenzhi
 match remote identity fqdn fenzhi1
 proposal 1

ipsec配置
ipsec transform-set tran1
 esp encryption-algorithm des-cbc
 esp authentication-algorithm sha1

配置IPSEC模板
ipsec policy-template templete1 1
 transform-set tran1
 ike-profile profile1
以模板的方式配置IPSEC策略
ipsec policy policy1 1 isakmp template templete1
MSR2配置：
interface GigabitEthernet0/0
 port link-mode route
 combo enable copper
 ip address 1.1.1.2 255.255.255.0
interface GigabitEthernet0/1
 port link-mode route
 combo enable copper
 ip address 2.2.2.2 255.255.255.0
interface GigabitEthernet0/2
 port link-mode route
 combo enable copper
 ip address 3.3.3.2 255.255.255.0

分支1的配置：
接口配置：
interface LoopBack0
 ip address 10.0.1.1 255.255.255.255
interface GigabitEthernet0/1
 port link-mode route
 combo enable copper
 ip address 2.2.2.1 255.255.255.0
 ipsec apply policy policy1

路由配置：
公网路由配置：
ip route-static 1.1.1.0 24 2.2.2.2
私网路由配置：
ip route-static 10.0.0.1 32 2.2.2.2

IKE配置：
ike identity fqdn fenzhi1
ike proposal 1
ike keychain keychain1
 pre-shared-key address 1.1.1.1 255.255.255.255 key simple h3c
ike profile profile1
 keychain keychain1
 exchange-mode aggressive
 match remote identity fqdn zongbu
 proposal 1

感兴趣流配置：
acl advanced 3001
 rule 0 permit ip source 10.0.1.1 0 destination 10.0.0.1 0

IPSEC配置：
ipsec transform-set tran1
 esp encryption-algorithm des-cbc
 esp authentication-algorithm sha1
ipsec policy policy1 1 isakmp
 transform-set tran1
 security acl 3001
 remote-address 1.1.1.1
 ike-profile profile1


分支2的配置：
接口配置：
interface LoopBack0
 ip address 10.0.2.1 255.255.255.255
interface GigabitEthernet0/2
 port link-mode route
 combo enable copper
 ip address 3.3.3.1 255.255.255.0
 ipsec apply policy policy1
路由配置：
公网路由配置：
ip route-static 1.1.1.0 24 3.3.3.2
私网路由配置：
ip route-static 10.0.0.1 32 3.3.3.2

IKE配置：
ike identity fqdn fenzhi
ike proposal 1
ike keychain keychain1
 pre-shared-key address 1.1.1.1 255.255.255.255 key simple h3c
ike profile profile1
 keychain keychain1
 exchange-mode aggressive
 match remote identity fqdn zongbu
 proposal 1

感兴趣流配置：
acl advanced 3001
 rule 0 permit ip source 10.0.2.1 0 destination 10.0.0.1 0

IPSEC配置：
ipsec transform-set tran1
 esp encryption-algorithm des-cbc
 esp authentication-algorithm sha1
ipsec policy policy1 1 isakmp
 transform-set tran1
 security acl 3001
 remote-address 1.1.1.1
 ike-profile profile1



## 测试结果：
配置完成后，在分支1触发总部
<H3C>ping -a 10.0.1.1 10.0.0.1
Ping 10.0.0.1 (10.0.0.1) from 10.0.1.1: 56 data bytes, press CTRL_C to break
Request time out
56 bytes from 10.0.0.1: icmp_seq=1 ttl=255 time=4.000 ms
56 bytes from 10.0.0.1: icmp_seq=2 ttl=255 time=5.000 ms
56 bytes from 10.0.0.1: icmp_seq=3 ttl=255 time=4.000 ms
56 bytes from 10.0.0.1: icmp_seq=4 ttl=255 time=3.000 ms

--- Ping statistics for 10.0.0.1 ---
5 packet(s) transmitted, 4 packet(s) received, 20.0% packet loss
round-trip min/avg/max/std-dev = 3.000/4.000/5.000/0.707 ms
<H3C>%Aug 28 17:56:05:176 2021 H3C PING/6/PING_STATISTICS: Ping statistics for 10.0.0.1: 5                                                                                                                                                   packet(s) transmitted, 4 packet(s) received, 20.0% packet loss, round-trip min/avg/max/st                                                                                                                                                  d-dev = 3.000/4.000/5.000/0.707 ms.

<H3C>
<H3C>dis
<H3C>display ike sa
    Connection-ID   Remote                Flag         DOI
------------------------------------------------------------------
    1               1.1.1.1               RD           IPsec
Flags:
RD--READY RL--REPLACED FD-FADING RK-REKEY
<H3C>dis
<H3C>display ips
<H3C>display ipsec  sa
-------------------------------
Interface: GigabitEthernet0/1
-------------------------------

  -----------------------------
  IPsec policy: policy1
  Sequence number: 1
  Mode: ISAKMP
  -----------------------------
    Tunnel id: 0
    Encapsulation mode: tunnel
    Perfect Forward Secrecy:
    Inside VPN:
    Extended Sequence Numbers enable: N
    Traffic Flow Confidentiality enable: N
    Path MTU: 1444
    Tunnel:
        local  address: 2.2.2.1
        remote address: 1.1.1.1
    Flow:
        sour addr: 10.0.1.1/255.255.255.255  port: 0  protocol: ip
        dest addr: 10.0.0.1/255.255.255.255  port: 0  protocol: ip

    [Inbound ESP SAs]
      SPI: 2686763476 (0xa024c1d4)
      Connection ID: 4294967296
      Transform set: ESP-ENCRYPT-DES-CBC ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3589
      Max received sequence-number: 4
      Anti-replay check enable: Y
      Anti-replay window size: 64
      UDP encapsulation used for NAT traversal: N
      Status: Active

    [Outbound ESP SAs]
      SPI: 215674475 (0x0cdaee6b)
      Connection ID: 4294967297
      Transform set: ESP-ENCRYPT-DES-CBC ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3589
      Max sent sequence-number: 4
      UDP encapsulation used for NAT traversal: N
      Status: Active
在分支2触发总部：

<H3C>ping -a 10.0.2.1 10.0.0.1
Ping 10.0.0.1 (10.0.0.1) from 10.0.2.1: 56 data bytes, press CTRL_C to break
Request time out
56 bytes from 10.0.0.1: icmp_seq=1 ttl=255 time=4.000 ms
56 bytes from 10.0.0.1: icmp_seq=2 ttl=255 time=4.000 ms
56 bytes from 10.0.0.1: icmp_seq=3 ttl=255 time=5.000 ms
56 bytes from 10.0.0.1: icmp_seq=4 ttl=255 time=5.000 ms

--- Ping statistics for 10.0.0.1 ---
5 packet(s) transmitted, 4 packet(s) received, 20.0% packet loss
round-trip min/avg/max/std-dev = 4.000/4.500/5.000/0.500 ms
<H3C>%Aug 28 17:56:57:957 2021 H3C PING/6/PING_STATISTICS: Ping statistics for 10.0.0.1: 5 packet(s) transmitted, 4 packet(s) received, 20.0% packet loss, round-trip min/avg/max/std-dev = 4.000/4.500/5.000/0.500 ms.

<H3C>dis
<H3C>display ike sa
    Connection-ID   Remote                Flag         DOI
------------------------------------------------------------------
    1               1.1.1.1               RD           IPsec
Flags:
RD--READY RL--REPLACED FD-FADING RK-REKEY
<H3C>dis
<H3C>display ips
<H3C>display ipsec  sa
-------------------------------
Interface: GigabitEthernet0/2
-------------------------------

  -----------------------------
  IPsec policy: policy1
  Sequence number: 1
  Mode: ISAKMP
  -----------------------------
    Tunnel id: 0
    Encapsulation mode: tunnel
    Perfect Forward Secrecy:
    Inside VPN:
    Extended Sequence Numbers enable: N
    Traffic Flow Confidentiality enable: N
    Path MTU: 1444
    Tunnel:
        local  address: 3.3.3.1
        remote address: 1.1.1.1
    Flow:
        sour addr: 10.0.2.1/255.255.255.255  port: 0  protocol: ip
        dest addr: 10.0.0.1/255.255.255.255  port: 0  protocol: ip

    [Inbound ESP SAs]
      SPI: 763064909 (0x2d7b724d)
      Connection ID: 4294967296
      Transform set: ESP-ENCRYPT-DES-CBC ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3590
      Max received sequence-number: 4
      Anti-replay check enable: Y
      Anti-replay window size: 64
      UDP encapsulation used for NAT traversal: N
      Status: Active

    [Outbound ESP SAs]
      SPI: 2881341132 (0xabbdc6cc)
      Connection ID: 4294967297
      Transform set: ESP-ENCRYPT-DES-CBC ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3590
      Max sent sequence-number: 4
      UDP encapsulation used for NAT traversal: N
      Status: Active


关键点：
总部必须使用模板，触发的时候必须从分支到总部触发，总部会根据发送的感兴趣流镜像
<H3C>display  ipsec  sa
-------------------------------
Interface: GigabitEthernet0/0
-------------------------------

  -----------------------------
  IPsec policy: policy1
  Sequence number: 1
  Mode: Template
  -----------------------------
    Tunnel id: 0
    Encapsulation mode: tunnel
    Perfect Forward Secrecy:
    Inside VPN:
    Extended Sequence Numbers enable: N
    Traffic Flow Confidentiality enable: N
    Path MTU: 1444
    Tunnel:
        local  address: 1.1.1.1
        remote address: 2.2.2.1
    Flow:
        sour addr: 10.0.0.1/255.255.255.255  port: 0  protocol: ip
        dest addr: 10.0.1.1/255.255.255.255  port: 0  protocol: ip







如果IPSEC已经建立，如果内网不通，按照如下思路排查：
1.	针对内网IP源目写一条ACL，首先debug ip packet、 debug ip info、debug security-policy、debug aspf packet，看一下是否有策略阻断或者状态异常
2.	如果策略正常放通，那就查看内层会话，看一下会话是否正常，回程报文的目的地址是否是内网地址，如果是公网地址，说明命中了NAT，那就需要检测接口的NAT相关配置
display session  table ipv4 destination-ip  10.0.0.1 protocol icmp  verbose


接口的配置NAT outbound，带名字的ACL要优先匹配，字符靠前的优先匹配
其次是带数字的ACL匹配，最后是不带ACL的匹配，一条流量会遍历接口下的所有NAT配置，看能否做NAT

3.	如果进行前两步操作内网依然不通，那就在分支上将感兴趣流只保留一条
内网服务器互访的时候，总部与分支分别查看ipsec统计以及内存会话
查看ipsec统计的命令如下：
（1）首先通过display ipsec sa确认ipsec sa的tunnel id
[H3C]display  ipsec  sa
-------------------------------
Interface: GigabitEthernet0/2
-------------------------------

  -----------------------------
  IPsec policy: policy1
  Sequence number: 1
  Mode: ISAKMP
  -----------------------------
    Tunnel id: 0
    Encapsulation mode: tunnel

（2）然后通过tunnel-id查看ipsec收发包统计
[H3C]display  ipsec statistics tunnel-id 0
  IPsec packet statistics:
    Received/sent packets: 19/19
    Received/sent bytes: 1672/1672
    Dropped packets (received/sent): 0/0

    Dropped packets statistics
      No available SA: 0
      Wrong SA: 0
      Invalid length: 0
      Authentication failure: 0
      Encapsulation failure: 0
      Decapsulation failure: 0
      Replayed packets: 0
      ACL check failure: 0
      MTU check failure: 0
      Loopback limit exceeded: 0
      Crypto speed limit exceeded: 0

（3）.查看内层会话的命令如下：
display session  table ipv4 destination-ip  10.0.0.1 protocol icmp  verbose

如果会话发出10个，但是IPSEC统计发出6个，那就可能存在ipsec的分片问题
就需要开启以下命令：
首先将ipsec允许分片的命令打开
在接口GigabitEthernet1/0/2上设置IPsec封装后外层IP头的DF位。

[Sysname] interface gigabitethernet 1/0/2

[Sysname-GigabitEthernet1/0/2] ipsec df-bit clear

第二，开启ipsec支持加密后的报文分片
[Sysname] ipsec fragmentation after-encryption







## 说明： 

本案例使用HCL模拟器，MSR以及F1060
