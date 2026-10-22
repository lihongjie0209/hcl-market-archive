# 工程名称
V7防火墙IPSEC主模式总部对接多分支


## 需求：
1、总部及各分公司出口防火墙均有固定ip，要求分公司和总部之间互访的数据必须经过ipsec加密。

2、ipsec安全提议要求使用隧道模式，安全协议使用esp，加密算法使用aes-cbc-128，认证算法使用sha1

3、ike提议要求认证方法使用预共享密钥，认证算法为md5，加密算法为3des-cbc

4、总部和分公司1的预共享密钥为1qaz2wsx，总部和分公司2的预共享密钥为1qaz3edc

5、总部及分公司之间互访的网段均在vlan10中。

6、总部及各分公司均能通过各自的出口访问互联网。


## 实验步骤：
**1、配置各接口ip及路由，保证各部分私网和公网均可互通**

**2、Ipsec配置**

*** 总部**

配置感兴趣流：
#
acl advanced 3000
 description ipsec_with_branch1
 rule 0 permit ip source 172.16.10.0 0.0.0.255 destination 172.17.10.0 0.0.0.255
#
acl advanced 3005
 description ipsec_with_branch2
 rule 0 permit ip source 172.16.10.0 0.0.0.255 destination 172.18.10.0 0.0.0.255
#

配置ike提议：
#
ike proposal 1
 encryption-algorithm 3des-cbc
 authentication-algorithm md5
#

配置ike预共享密钥：
#
ike keychain branch1
 pre-shared-key address 100.0.34.4 255.255.255.255 key simple 1qaz2wsx
#
ike keychain branch2
 pre-shared-key address 100.0.35.5 255.255.255.255 key simple 1qaz3edc
#

配置ike profile:
#
ike profile branch1
 keychain branch1
 match remote identity address 100.0.34.4 255.255.255.255
 proposal 1 
#
ike profile branch2
 keychain branch2
 match remote identity address 100.0.35.5 255.255.255.255
 proposal 1    
#

配置ipsec安全提议：
#
ipsec transform-set tran1
 esp encryption-algorithm aes-cbc-128 
 esp authentication-algorithm sha1 
#

配置ipsec策略：
#
ipsec policy tobranch 1 isakmp
 transform-set tran1 
 security acl 3000 
 local-address 100.0.23.2
 remote-address 100.0.34.4 
 ike-profile branch1
#
ipsec policy tobranch 5 isakmp
 transform-set tran1 
 security acl 3005 
 local-address 100.0.23.2
 remote-address 100.0.35.5 
 ike-profile branch2
#

公网口应用ipsec策略：
#
interface GigabitEthernet1/0/2
 port link-mode route
 ip address 100.0.23.2 255.255.255.0
 ipsec apply policy tobranch
#


*** 分公司1**

配置感兴趣流：
#
acl advanced 3000
 description ipsec_with_head
 rule 0 permit ip source 172.17.10.0 0.0.0.255 destination 172.16.10.0 0.0.0.255
#

配置ike提议：
#
ike proposal 1
 encryption-algorithm 3des-cbc
 authentication-algorithm md5
#

配置ike预共享密钥：
#
ike keychain head
 pre-shared-key address 100.0.23.2 255.255.255.255 key simple 1qaz2wsx
#

配置ike profile:
#              
ike profile head
 keychain head
 match remote identity address 100.0.23.2 255.255.255.255
 proposal 1 
#

配置ipsec安全提议：
#
ipsec transform-set tran1
 esp encryption-algorithm aes-cbc-128 
 esp authentication-algorithm sha1 
#

配置ipsec策略：
#
ipsec policy tohead 1 isakmp
 transform-set tran1 
 security acl 3000 
 local-address 100.0.34.4
 remote-address 100.0.23.2 
 ike-profile head
#

公网口应用ipsec策略：
#
interface GigabitEthernet1/0/4
 port link-mode route
 ip address 100.0.34.4 255.255.255.0
 ipsec apply policy tohead
#


*** 分公司2**

配置感兴趣流：
#
acl advanced 3000
 description ipsec_with_head
 rule 0 permit ip source 172.18.10.0 0.0.0.255 destination 172.16.10.0 0.0.0.255
#

配置ike提议：
#
ike proposal 1
 encryption-algorithm 3des-cbc
 authentication-algorithm md5
#

配置ike预共享密钥：
#
ike keychain head
 pre-shared-key address 100.0.23.2 255.255.255.255 key simple 1qaz3edc
#

配置ike profile:
#              
ike profile head
 keychain head
 match remote identity address 100.0.23.2 255.255.255.255
 proposal 1 
#

配置ipsec安全提议：
#
ipsec transform-set tran1
 esp encryption-algorithm aes-cbc-128 
 esp authentication-algorithm sha1 
#

配置ipsec策略：
#
ipsec policy tohead 1 isakmp
 transform-set tran1 
 security acl 3000 
 local-address 100.0.35.5
 remote-address 100.0.23.2 
 ike-profile head
#

公网口应用ipsec策略：
#
interface GigabitEthernet1/0/5
 port link-mode route
 ip address 100.0.35.5 255.255.255.0
 ipsec apply policy tohead
#


**3、安全域及安全策略配置，各FW均将公网口加入untrust域，内网口加入trust域**

*** 总部**
#
security-zone name Trust
 import interface GigabitEthernet1/0/1
#
security-zone name Untrust
 import interface GigabitEthernet1/0/2
#
security-policy ip
 rule 1 name ipseclocalin
  action pass
  source-zone untrust
  destination-zone local
  source-ip-host 100.0.34.4 
  source-ip-host 100.0.35.5 
  destination-ip-host 100.0.23.2 
 rule 2 name ispeclocalout
  action pass
  source-zone local
  destination-zone untrust
  source-ip-host 100.0.23.2 
  destination-ip-host 100.0.34.4 
  destination-ip-host 100.0.35.5 
 rule 3 name ipsectobranch1
  action pass
  source-zone trust
  destination-zone untrust
  source-ip-subnet 172.16.10.0 255.255.255.0 
  destination-ip-subnet 172.17.10.0 255.255.255.0 
 rule 4 name ipsectobranch2
  action pass
  source-zone trust
  destination-zone untrust
  source-ip-subnet 172.16.10.0 255.255.255.0 
  destination-ip-subnet 172.18.10.0 255.255.255.0 
 rule 5 name ipsecfromebranch1
  action pass
  source-zone untrust
  destination-zone trust
  source-ip-subnet 172.17.10.0 255.255.255.0 
  destination-ip-subnet 172.16.10.0 255.255.255.0 
 rule 6 name ipsecfrombranch2
  action pass
  source-zone untrust
  destination-zone trust
  source-ip-subnet 172.18.10.0 255.255.255.0 
  destination-ip-subnet 172.16.10.0 255.255.255.0 
#

*** 分公司1**
#
security-zone name Trust
 import interface GigabitEthernet1/0/1
#
security-zone name Untrust
 import interface GigabitEthernet1/0/4
#
security-policy ip
 rule 1 name ipseclocalin
  action pass
  source-zone untrust
  destination-zone local
  source-ip-host 100.0.23.2 
  destination-ip-host 100.0.34.4 
 rule 2 name ipseclocalout
  action pass
  source-zone local
  destination-zone untrust
  source-ip-host 100.0.34.4 
  destination-ip-host 100.0.23.2 
 rule 3 name ipsectohead
  action pass
  source-zone trust
  destination-zone untrust
  source-ip-subnet 172.17.10.0 255.255.255.0 
  destination-ip-subnet 172.16.10.0 255.255.255.0 
 rule 4 name ipsecfromhead
  action pass
  source-zone untrust
  destination-zone trust
  source-ip-subnet 172.16.10.0 255.255.255.0 
  destination-ip-subnet 172.17.10.0 255.255.255.0 
#

*** 分公司2**
#
security-zone name Trust
 import interface GigabitEthernet1/0/1
#
security-zone name Untrust
 import interface GigabitEthernet1/0/5
#
security-policy ip
 rule 1 name ipseclocalin
  action pass
  source-zone untrust
  destination-zone local
  source-ip-host 100.0.23.2 
  destination-ip-host 100.0.35.5 
 rule 2 name ipseclocalout
  action pass
  source-zone local
  destination-zone untrust
  source-ip-host 100.0.35.5 
  destination-ip-host 100.0.23.2 
 rule 3 name ipsectohead
  action pass
  source-zone trust
  destination-zone untrust
  source-ip-subnet 172.18.10.0 255.255.255.0 
  destination-ip-subnet 172.16.10.0 255.255.255.0 
 rule 4 name ipsecfromhead
  action pass
  source-zone untrust
  destination-zone trust
  source-ip-subnet 172.16.10.0 255.255.255.0 
  destination-ip-subnet 172.18.10.0 255.255.255.0 
#

**4、SNAT配置**

*** 总部**
#
nat global-policy
 rule name ipsecnonat
  source-ip subnet 172.16.10.0 24
  destination-ip subnet 172.17.10.0 24
  destination-ip subnet 172.18.10.0 24
  action snat no-nat
 rule name tointernet
  source-zone trust
  destination-zone untrust
  source-ip subnet 172.16.10.0 24
  action snat easy-ip
#

*** 分公司1**
#
nat global-policy
 rule name ipsecnonat
  source-ip subnet 172.17.10.0 24
  destination-ip subnet 172.16.10.0 24
  action snat no-nat
 rule name tointernet
  source-zone trust
  destination-zone untrust
  source-ip subnet 172.17.10.0 24
  action snat easy-ip
#   

*** 分公司2**
#
nat global-policy
 rule name ipsecnonat
  source-ip subnet 172.18.10.0 24
  destination-ip subnet 172.16.10.0 24
  action snat no-nat
 rule name tointernet
  source-zone trust
  destination-zone untrust
  source-ip subnet 172.18.10.0 24
  action snat easy-ip
#     


## 测试结果：
**1、总部/分公司任意一方均可以发起ping触发ipsec隧道建立,第一个包不通是在进行ipsec隧道协商，协商成功后，并且安全策略放行了分支和总部之间的私网流量就可以互通**

*** 总部**

<总部SW1>ping -a 172.16.10.1 172.18.10.1
Ping 172.18.10.1 (172.18.10.1) from 172.16.10.1: 56 data bytes, press CTRL_C to break
Request time out
56 bytes from 172.18.10.1: icmp_seq=1 ttl=253 time=2.000 ms
56 bytes from 172.18.10.1: icmp_seq=2 ttl=253 time=2.000 ms
56 bytes from 172.18.10.1: icmp_seq=3 ttl=253 time=2.000 ms
56 bytes from 172.18.10.1: icmp_seq=4 ttl=253 time=2.000 ms

--- Ping statistics for 172.18.10.1 ---
5 packet(s) transmitted, 4 packet(s) received, 20.0% packet loss
<总部SW1>
<总部SW1>ping -a 172.16.10.1 172.17.10.1
Ping 172.17.10.1 (172.17.10.1) from 172.16.10.1: 56 data bytes, press CTRL_C to break
56 bytes from 172.17.10.1: icmp_seq=0 ttl=253 time=2.000 ms
56 bytes from 172.17.10.1: icmp_seq=1 ttl=253 time=2.000 ms
56 bytes from 172.17.10.1: icmp_seq=2 ttl=253 time=2.000 ms
56 bytes from 172.17.10.1: icmp_seq=3 ttl=253 time=2.000 ms
56 bytes from 172.17.10.1: icmp_seq=4 ttl=253 time=2.000 ms

--- Ping statistics for 172.17.10.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss

*** 分公司1**

<分公司1SW1>ping -a 172.17.10.1 172.16.10.1
Ping 172.16.10.1 (172.16.10.1) from 172.17.10.1: 56 data bytes, press CTRL_C to break
Request time out
56 bytes from 172.16.10.1: icmp_seq=1 ttl=253 time=2.000 ms
56 bytes from 172.16.10.1: icmp_seq=2 ttl=253 time=2.000 ms
56 bytes from 172.16.10.1: icmp_seq=3 ttl=253 time=2.000 ms
56 bytes from 172.16.10.1: icmp_seq=4 ttl=253 time=7.000 ms

--- Ping statistics for 172.16.10.1 ---
5 packet(s) transmitted, 4 packet(s) received, 20.0% packet loss

*** 分公司2**

<分公司2SW1>ping -a 172.18.10.1 172.16.10.1
Ping 172.16.10.1 (172.16.10.1) from 172.18.10.1: 56 data bytes, press CTRL_C to break
56 bytes from 172.16.10.1: icmp_seq=0 ttl=253 time=5.000 ms
56 bytes from 172.16.10.1: icmp_seq=1 ttl=253 time=6.000 ms
56 bytes from 172.16.10.1: icmp_seq=2 ttl=253 time=5.000 ms
56 bytes from 172.16.10.1: icmp_seq=3 ttl=253 time=4.000 ms
56 bytes from 172.16.10.1: icmp_seq=4 ttl=253 time=5.000 ms

--- Ping statistics for 172.16.10.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss

**2、各出口防火墙查看ipsec隧道信息**

*** 总部**
[总部FW1]dis ike sa
    Connection-ID   Remote                Flag         DOI    
------------------------------------------------------------------
    3               100.0.35.5/500        RD           IPsec  
    4               100.0.34.4/500        RD           IPsec  
Flags:
RD--READY RL--REPLACED FD-FADING RK-REKEY
[总部FW1]dis ipsec sa
-------------------------------
Interface: GigabitEthernet1/0/2
-------------------------------

  -----------------------------
  IPsec policy: tobranch
  Sequence number: 1
  Mode: ISAKMP
  -----------------------------
    Tunnel id: 0
    Encapsulation mode: tunnel
    Perfect Forward Secrecy: 
    Inside VPN: 
    Extended Sequence Numbers enable: N
    Traffic Flow Confidentiality enable: N
    Transmitting entity: Responder
    Path MTU: 1428
    Tunnel:
        local  address: 100.0.23.2
        remote address: 100.0.34.4
    Flow:
        sour addr: 172.16.10.0/255.255.255.0  port: 0  protocol: ip
        dest addr: 172.17.10.0/255.255.255.0  port: 0  protocol: ip
               
    [Inbound ESP SAs]
      SPI: 4130445221 (0xf63197a5)
      Connection ID: 12884901889
      Transform set: ESP-ENCRYPT-AES-CBC-128 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3571
      Max received sequence-number: 9
      Anti-replay check enable: Y
      Anti-replay window size: 64
      UDP encapsulation used for NAT traversal: N
      Status: Active

    [Outbound ESP SAs]
      SPI: 3650857009 (0xd99ba831)
      Connection ID: 12884901888
      Transform set: ESP-ENCRYPT-AES-CBC-128 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3571
      Max sent sequence-number: 9
      UDP encapsulation used for NAT traversal: N
      Status: Active

  -----------------------------
  IPsec policy: tobranch
  Sequence number: 5
  Mode: ISAKMP
  -----------------------------
    Tunnel id: 1
    Encapsulation mode: tunnel
    Perfect Forward Secrecy: 
    Inside VPN: 
    Extended Sequence Numbers enable: N
    Traffic Flow Confidentiality enable: N
    Transmitting entity: Initiator
    Path MTU: 1428
    Tunnel:
        local  address: 100.0.23.2
        remote address: 100.0.35.5
    Flow:
        sour addr: 172.16.10.0/255.255.255.0  port: 0  protocol: ip
        dest addr: 172.18.10.0/255.255.255.0  port: 0  protocol: ip

    [Inbound ESP SAs]
      SPI: 540561184 (0x20384f20)
      Connection ID: 12884901891
      Transform set: ESP-ENCRYPT-AES-CBC-128 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3340
      Max received sequence-number: 9
      Anti-replay check enable: Y
      Anti-replay window size: 64
      UDP encapsulation used for NAT traversal: N
      Status: Active

    [Outbound ESP SAs]
      SPI: 636120379 (0x25ea6d3b)
      Connection ID: 12884901890
      Transform set: ESP-ENCRYPT-AES-CBC-128 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3340
      Max sent sequence-number: 9
      UDP encapsulation used for NAT traversal: N
      Status: Active
[总部FW1] 

*** 分公司1**

[分公司1FW1]dis ike sa
    Connection-ID   Remote                Flag         DOI    
------------------------------------------------------------------
    2               100.0.23.2/500        RD           IPsec  
Flags:
RD--READY RL--REPLACED FD-FADING RK-REKEY
[分公司1FW1]dis ipsec sa
-------------------------------
Interface: GigabitEthernet1/0/4
-------------------------------

  -----------------------------
  IPsec policy: tohead
  Sequence number: 1
  Mode: ISAKMP
  -----------------------------
    Tunnel id: 0
    Encapsulation mode: tunnel
    Perfect Forward Secrecy: 
    Inside VPN: 
    Extended Sequence Numbers enable: N
    Traffic Flow Confidentiality enable: N
    Transmitting entity: Initiator
    Path MTU: 1428
    Tunnel:
        local  address: 100.0.34.4
        remote address: 100.0.23.2
    Flow:
        sour addr: 172.17.10.0/255.255.255.0  port: 0  protocol: ip
        dest addr: 172.16.10.0/255.255.255.0  port: 0  protocol: ip
               
    [Inbound ESP SAs]
      SPI: 3650857009 (0xd99ba831)
      Connection ID: 12884901889
      Transform set: ESP-ENCRYPT-AES-CBC-128 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3567
      Max received sequence-number: 9
      Anti-replay check enable: Y
      Anti-replay window size: 64
      UDP encapsulation used for NAT traversal: N
      Status: Active

    [Outbound ESP SAs]
      SPI: 4130445221 (0xf63197a5)
      Connection ID: 12884901888
      Transform set: ESP-ENCRYPT-AES-CBC-128 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3567
      Max sent sequence-number: 9
      UDP encapsulation used for NAT traversal: N
      Status: Active
[分公司1FW1]   


*** 分公司2**

[分公司2FW1]dis ike sa
    Connection-ID   Remote                Flag         DOI    
------------------------------------------------------------------
    2               100.0.23.2/500        RD           IPsec  
Flags:
RD--READY RL--REPLACED FD-FADING RK-REKEY
[分公司2FW1] 
[分公司2FW1]
[分公司2FW1]dis ipsec sa
-------------------------------
Interface: GigabitEthernet1/0/5
-------------------------------

  -----------------------------
  IPsec policy: tohead
  Sequence number: 1
  Mode: ISAKMP
  -----------------------------
    Tunnel id: 0
    Encapsulation mode: tunnel
    Perfect Forward Secrecy: 
    Inside VPN: 
    Extended Sequence Numbers enable: N
    Traffic Flow Confidentiality enable: N
    Transmitting entity: Responder
    Path MTU: 1428
    Tunnel:
        local  address: 100.0.35.5
        remote address: 100.0.23.2
    Flow:
        sour addr: 172.18.10.0/255.255.255.0  port: 0  protocol: ip
        dest addr: 172.16.10.0/255.255.255.0  port: 0  protocol: ip
               
    [Inbound ESP SAs]
      SPI: 636120379 (0x25ea6d3b)
      Connection ID: 12884901889
      Transform set: ESP-ENCRYPT-AES-CBC-128 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3341
      Max received sequence-number: 9
      Anti-replay check enable: Y
      Anti-replay window size: 64
      UDP encapsulation used for NAT traversal: N
      Status: Active

    [Outbound ESP SAs]
      SPI: 540561184 (0x20384f20)
      Connection ID: 12884901888
      Transform set: ESP-ENCRYPT-AES-CBC-128 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3341
      Max sent sequence-number: 9
      UDP encapsulation used for NAT traversal: N
      Status: Active
[分公司2FW1]  

## 说明： 
**1、到防火墙本地处理的报文需要放通流量入接口所在安全域到local域的安全策略
2、防火墙本地发起的报文需要放行local域到出接口所在安全域的安全策略
3、、主模式ipsec任意一方均可发起协商，而ipsec协商报文又是到防火墙本地或者防火墙本地发起的，因此防火墙安全策略需要放行应用ipsec策略的接口所在安全域和local域之间的报文，才能保证ipsec隧道可以正常协商
4、总部和分支之间互访即使是通过ipsec隧道的，也要放行安全策略
5、各出口防火墙需要有指向对端私网网段的路由，出接口为应用ipsec策略的接口，同时也要有到本端私网的路由指向核心交换机
6、防火墙接口发出去的报文，nat的优先级要比ipsec高，也就是报文会优先匹配nat，如果ipsec的感兴趣流不是nat后的地址，那么就不会触发ipsec隧道协商，所以当前版本需要配置nat策略对私网间互访的流量不做SNAT**
