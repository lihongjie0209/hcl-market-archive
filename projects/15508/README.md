# 工程名称
GREOVERIPSEC典配



## 需求：

组网如下：	
FW作为日志源，将安全策略日志以快速日志的方式发送到日志服务器，并且要保证发送日志被加密
![GREOVERIPSEC.png](./Media/GREOVERIPSEC.png)
## 实验步骤：
主要配置如下：
FW1日志源主要配置
路由配置：
ip route-static 0.0.0.0 0 202.0.0.2
 ip route-static 2.2.2.0 24 Tunnel0

快速日志配置：
customlog format packet-filter
 customlog host 2.2.2.1 export packet-filter
 customlog host source LoopBack10


接口配置：
interface LoopBack0
 ip address 11.11.11.11 255.255.255.255
#
interface LoopBack10
 ip address 1.1.1.1 255.255.255.255
#

interface GigabitEthernet1/0/1
 port link-mode route
 combo enable copper
 ip address 202.0.0.1 255.255.255.0
 ipsec apply policy vpn

安全域与安全策略配置
security-zone name Trust
 import interface GigabitEthernet1/0/1
 import interface Tunnel0

security-policy ip（日志记录功能要打开）
 rule 0 name 0
  action pass
  logging enable


GRE主要配置
一定不要配置探测
interface Tunnel0 mode gre
 ip address 10.0.0.1 255.255.255.252
 source LoopBack0
 destination 22.22.22.22
 gre key 123
#



IPSSEC主要配置
acl advanced 3000
 rule 0 permit gre source 11.11.11.11 0 destination 22.22.22.22 0

ipsec transform-set tran1
 esp encryption-algorithm aes-cbc-256
 esp authentication-algorithm sha1
#
ipsec policy vpn 1 isakmp
 transform-set tran1
 security acl 3000
 remote-address 202.0.0.2
 ike-profile profile1
#
 ike identity fqdn vpn1
#
ike profile profile1
 keychain keychain1
 local-identity address 202.0.0.1
 match remote identity address 202.0.0.2 255.255.255.0
 proposal 1
#
ike proposal 1
 encryption-algorithm aes-cbc-256
 dh group2
#
ike keychain keychain1
 pre-shared-key address 202.0.0.2 255.255.255.255 key simple 123


FW2主要配置如下：
路由配置：
ip route-static 0.0.0.0 0 202.0.0.1
 ip route-static 1.1.1.0 24 Tunnel0
接口配置：
interface LoopBack0
 ip address 22.22.22.22 255.255.255.255
#
interface GigabitEthernet1/0/0
 port link-mode route
 combo enable copper
 ip address 2.2.2.2 255.255.255.0
#
interface GigabitEthernet1/0/1
 port link-mode route
 combo enable copper
 ip address 202.0.0.2 255.255.255.0
 ipsec apply policy vpn


安全域与安全策略配置
security-zone name Trust
 import interface GigabitEthernet1/0/0
 import interface GigabitEthernet1/0/1
 import interface Tunnel0

security-policy ip
 rule 0 name 0
  action pass



GRE主要配置
一定不要配置探测
interface Tunnel0 mode gre
 ip address 10.0.0.2 255.255.255.252
 source LoopBack0
 destination 11.11.11.11
 gre key 123
#


IPSSEC主要配置
acl advanced 3000
 rule 0 permit gre source 22.22.22.22 0 destination 11.11.11.11 0

ipsec transform-set tran1
 esp encryption-algorithm aes-cbc-256
 esp authentication-algorithm sha1
#
ipsec policy vpn 1 isakmp
 transform-set tran1
 security acl 3000
 remote-address 202.0.0.1
 ike-profile profile1
#
 ike identity fqdn vpn2
#
ike profile profile1
 keychain keychain1
 local-identity address 202.0.0.2
 match remote identity address 202.0.0.1 255.255.255.0
 proposal 1
#
ike proposal 1
 encryption-algorithm aes-cbc-256
 dh group2
#
ike keychain keychain1
 pre-shared-key address 202.0.0.1 255.255.255.255 key simple 123 


日志服务器配置：
ip route-static 1.1.1.0 24 2.2.2.2
interface GigabitEthernet0/0
 port link-mode route
 combo enable copper
 ip address 2.2.2.1 255.255.255.0





## 测试结果：

配置完成之后测试结果如下：
FW1上以1.1.1.1为源地址ping2.2.2.1，可以看到FW1上IKE SA与IPSEC SA均已建立
[FW1]ping -a 1.1.1.1 2.2.2.1
Ping 2.2.2.1 (2.2.2.1) from 1.1.1.1: 56 data bytes, press CTRL+C to break
56 bytes from 2.2.2.1: icmp_seq=0 ttl=254 time=2.000 ms
56 bytes from 2.2.2.1: icmp_seq=1 ttl=254 time=1.000 ms
56 bytes from 2.2.2.1: icmp_seq=2 ttl=254 time=1.000 ms
56 bytes from 2.2.2.1: icmp_seq=3 ttl=254 time=3.000 ms
56 bytes from 2.2.2.1: icmp_seq=4 ttl=254 time=1.000 ms

--- Ping statistics for 2.2.2.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.600/3.000/0.800 ms
[FW1]
[FW1]
[FW1]%Jul 16 14:20:41:836 2022 FW1 PING/6/PING_STATISTICS: -Context=1; Ping statistics for 2.2.2.1: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/1.600/3.000/0.800 ms.
dis ike sa
    Connection-ID   Remote                Flag         DOI
------------------------------------------------------------------
    1               202.0.0.2/500         RD           IPsec
Flags:
RD--READY RL--REPLACED FD-FADING RK-REKEY
[FW1]dis
[FW1]display ips
[FW1]display ipsec sa
-------------------------------
Interface: GigabitEthernet1/0/1
-------------------------------

  -----------------------------
  IPsec policy: vpn
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
        local  address: 202.0.0.1
        remote address: 202.0.0.2
    Flow:
        sour addr: 11.11.11.11/255.255.255.255  port: 0  protocol: gre
        dest addr: 22.22.22.22/255.255.255.255  port: 0  protocol: gre

    [Inbound ESP SAs]
      SPI: 1902679672 (0x71689678)
      Connection ID: 4294967296
      Transform set: ESP-ENCRYPT-AES-CBC-256 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843195/1989
      Max received sequence-number: 34
      Anti-replay check enable: Y
      Anti-replay window size: 64
      UDP encapsulation used for NAT traversal: N
      Status: Active

    [Outbound ESP SAs]
      SPI: 4170074684 (0xf88e4a3c)
      Connection ID: 4294967297
      Transform set: ESP-ENCRYPT-AES-CBC-256 ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843190/1989
      Max sent sequence-number: 47
      UDP encapsulation used for NAT traversal: N
      Status: Active


在日志服务器上抓包，可以看到FW1产生的syslog日志
![日志服务器抓包.png](./Media/日志服务器抓包.png)
1.	配置快速日志的源目要走tunnel口
2.	快速日志必须以GRE OVER IPSEC的方式加密，因为快速日志如果以IPSEC加密方式发送，将不走安全策略业务点
3.	安全策略中将log enable打开
4.	安全策略日志模块为packet-filter

## 说明： 
本案例使用HCL模拟器，F1060以及MSR

