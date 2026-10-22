# 工程名称

ComwareV7 FW跨VPN实例的IPSEC典型配置

## 需求：

组网如图：
FW1与FW2建立IPSEC，内网口g1/0/0属于VPN test1，外网口g1/0/1属于VPN test。
![跨VPN实例IPSEC.png](./Media/跨VPN实例IPSEC.png)

## 实验步骤：

MSR的主要配置：
interface GigabitEthernet0/0
 port link-mode route
 combo enable copper
 ip address 10.1.1.2 255.255.255.0

ip route-static 0.0.0.0 0 10.1.1.1


FW1主要配置：
ip vpn-instance test
ip vpn-instance test1

interface GigabitEthernet1/0/0
 port link-mode route
 combo enable copper
 ip binding vpn-instance test1
 ip address 10.1.1.1 255.255.255.0

interface GigabitEthernet1/0/1
 port link-mode route
 combo enable copper
 ip binding vpn-instance test
 ip address 202.38.160.1 255.255.255.0
 ipsec apply policy policy1

security-zone name Trust
 import interface GigabitEthernet1/0/0
 import interface GigabitEthernet1/0/1

security-policy ip
 rule 0 name 0
  action pass
  vrf test
 rule 1 name 1
  action pass
  vrf test1

ip route-static vpn-instance test1 10.1.2.0 24 vpn-instance test 202.38.160.2

acl advanced 3001
 rule 15 permit ip vpn-instance test1 source 10.1.1.0 0.0.0.255 destination 10.1.2.0 0.0.0.255


ipsec transform-set tran1
 esp encryption-algorithm des-cbc
 esp authentication-algorithm sha1

ipsec policy policy1 1 isakmp
 transform-set tran1
 security acl 3001
 remote-address 202.38.160.2
 ike-profile profile1

ike profile profile1
 keychain kechain
 local-identity address 202.38.160.1
 match remote identity address 202.38.160.2 255.255.255.255 vpn-instance test
 proposal 1
 inside-vpn vpn-instance test1

ike proposal 1

ike keychain kechain vpn-instance test
 pre-shared-key address 202.38.160.2 255.255.255.255 key simple 123456




FW2主要配置：
interface LoopBack0
 ip address 10.1.2.2 255.255.255.255

interface GigabitEthernet1/0/1
 port link-mode route
 combo enable copper
 ip address 202.38.160.2 255.255.255.0
 ipsec apply policy policy1

ip route-static 10.1.1.0 24 202.38.160.1

acl advanced 3001
 rule 0 permit ip source 10.1.2.0 0.0.0.255 destination 10.1.1.0 0.0.0.255

ipsec transform-set tran1
 esp encryption-algorithm des-cbc
 esp authentication-algorithm sha1

ipsec policy policy1 1 isakmp
 transform-set tran1
 security acl 3001
 remote-address 202.38.160.1
 ike-profile profile1

ike profile profile1
 keychain keychain1
 local-identity address 202.38.160.2
 match remote identity address 202.38.160.1 255.255.255.255
 proposal 1

ike proposal 1

ike keychain keychain1
 pre-shared-key address 202.38.160.1 255.255.255.255 key simple 123456

security-zone name Trust
 import interface GigabitEthernet1/0/1


security-policy ip
 rule 0 name 0
  action pass




## 测试结果：

配置完成后，MSR1可以ping通FW2的loopback地址10.1.2.2
[H3C]ping 10.1.2.2
Ping 10.1.2.2 (10.1.2.2): 56 data bytes, press CTRL+C to break
Request time out
56 bytes from 10.1.2.2: icmp_seq=1 ttl=254 time=1.000 ms
56 bytes from 10.1.2.2: icmp_seq=2 ttl=254 time=1.000 ms
56 bytes from 10.1.2.2: icmp_seq=3 ttl=254 time=0.000 ms
56 bytes from 10.1.2.2: icmp_seq=4 ttl=254 time=1.000 ms



FW1上可以看到IKE SA与IPSEC SA

<H3C>dis ike sa verbose
   -----------------------------------------------
   Connection ID: 1
   Outside VPN: test
   Inside VPN: test1
   Profile: profile1
   Transmitting entity: Initiator
   Initiator cookie: 80164735071382aa
   Responder cookie: bb3c629bb0cdb70a
   -----------------------------------------------
   Local IP: 202.38.160.1
   Local ID type: IPV4_ADDR
   Local ID: 202.38.160.1

   Remote IP: 202.38.160.2
   Remote ID type: IPV4_ADDR
   Remote ID: 202.38.160.2

   Authentication-method: PRE-SHARED-KEY
   Authentication-algorithm: SHA1
   Encryption-algorithm: DES-CBC

   Life duration(sec): 86400
   Remaining key duration(sec): 86341
   Exchange-mode: Main
   Diffie-Hellman group: Group 1
   NAT traversal: Not detected

   Extend authentication: Disabled
   Assigned IP address:
   Vendor ID index:0xffffffff
   Vendor ID sequence number:0x0
<H3C>   dis
<H3C>display ips
<H3C>display ipsec sa
-------------------------------
Interface: GigabitEthernet1/0/1
-------------------------------

  -----------------------------
  IPsec policy: policy1
  Sequence number: 1
  Mode: ISAKMP
  -----------------------------
    Tunnel id: 0
    Encapsulation mode: tunnel
    Perfect Forward Secrecy:
    Inside VPN: test1
    Extended Sequence Numbers enable: N
    Traffic Flow Confidentiality enable: N
    Path MTU: 1444
    Tunnel:
        local  address: 202.38.160.1
        remote address: 202.38.160.2
    Flow:
        sour addr: 10.1.1.0/255.255.255.0  port: 0  protocol: ip
        dest addr: 10.1.2.0/255.255.255.0  port: 0  protocol: ip

    [Inbound ESP SAs]
      SPI: 3264279281 (0xc290f2f1)
      Connection ID: 4294967296
      Transform set: ESP-ENCRYPT-DES-CBC ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3538
      Max received sequence-number: 4
      Anti-replay check enable: Y
      Anti-replay window size: 64
      UDP encapsulation used for NAT traversal: N
      Status: Active

    [Outbound ESP SAs]
      SPI: 45649012 (0x02b88c74)
      Connection ID: 4294967297
      Transform set: ESP-ENCRYPT-DES-CBC ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3538
      Max sent sequence-number: 4
      UDP encapsulation used for NAT traversal: N
      Status: Active




配置关键点：
FW1配置关键点：
配置注意关键点：
1.安全策略中加VRF
2.要有路由
3.ike keychain要带VPN实例（公网侧VPNtest）
ike keychain kechain vpn-instance test
4.ike profile中要带VPN实例（remote为公网侧test，inside为内网侧test1）
ike profile profile1
 match remote identity address 202.38.160.2 255.255.255.255 vpn-instance test
 inside-vpn vpn-instance test1


## 说明： 


本案例使用HCL模拟器，F1060以及MSR