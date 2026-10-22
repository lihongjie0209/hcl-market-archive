# 工程名称

ComwareV7 FW IPSEC反向路由注入典型配置

## 需求：

组网如下：
中心与分支建立IPSEC，中心使用模板的方式，并开启反向路由注入功能，使得中心
生成到分支10.1.0.1的静态路由，下一跳是中心应用IPSEC接口的下一跳，本案例即1.1.1.2

中心与分支的公网地址分别为1.1.1.1与1.1.1.2，中心与分支的私网地址分别为10.0.0.1与10.1.0.1
![IPSEC反向路由注入.png](./Media/IPSEC反向路由注入.png)

## 实验步骤：
配置步骤
中心：
安全域及安全策略的配置
security-zone name Trust
 import interface GigabitEthernet1/0/1

security-policy ip
 rule 0 name 0
  action pass



接口配置
interface LoopBack0
 ip address 10.0.0.1 255.255.255.255

interface GigabitEthernet1/0/1
 port link-mode route
 combo enable copper
 ip address 1.1.1.1 255.255.255.0
 ipsec apply policy map1


IKE与IPSEC的配置（关键是要在ipsec策略模板视图下开启反向路由注入功能）

ipsec transform-set tran1
 esp encryption-algorithm des-cbc
 esp authentication-algorithm sha1
#
ipsec policy-template temp1 1
 transform-set tran1
 ike-profile profile1
 reverse-route dynamic
 reverse-route preference 100
 reverse-route tag 1000
#
ipsec policy map1 10 isakmp template temp1
#
ike profile profile1
 keychain key1
 match remote identity address 1.1.1.2 255.255.255.0
#
ike proposal 1
#
ike keychain key1
 pre-shared-key address 1.1.1.2 255.255.255.255 key simple 123456




分支：

安全域及安全策略的配置
security-zone name Trust
 import interface GigabitEthernet1/0/1

security-policy ip
 rule 0 name 0
  action pass

接口配置
interface LoopBack0
 ip address 10.1.0.1 255.255.255.255

interface GigabitEthernet1/0/1
 port link-mode route
 combo enable copper
 ip address 1.1.1.2 255.255.255.0
 ipsec apply policy map1

私网路由配置
ip route-static 10.0.0.0 24 1.1.1.1

IKE与IPSEC配置


acl advanced 3000
 rule 0 permit ip source 10.1.0.0 0.0.0.255 destination 10.0.0.0 0.0.0.255

ipsec transform-set tran1
 esp encryption-algorithm des-cbc
 esp authentication-algorithm sha1
#
ipsec policy map1 10 isakmp
 transform-set tran1
 security acl 3000
 remote-address 1.1.1.1
 ike-profile profile1
#
ike profile profile1
 keychain key1
 match remote identity address 1.1.1.1 255.255.255.0
#
ike proposal 1
#
ike keychain key1
 pre-shared-key address 1.1.1.1 255.255.255.255 key simple 123456



## 测试结果：
使用分支带源ping中心触发一下，可以看到中心已经建立IKE SA与IPSEC SA以及生成一条10.1.0.0的静态路由，优先级100


[zhongxin]display ike sa
    Connection-ID   Remote                Flag         DOI
------------------------------------------------------------------
    2               1.1.1.2               RD           IPsec
Flags:
RD--READY RL--REPLACED FD-FADING RK-REKEY
[zhongxin]dis
[zhongxin]display  ips
[zhongxin]display  ipsec sa
-------------------------------
Interface: GigabitEthernet1/0/1
-------------------------------

  -----------------------------
  IPsec policy: map1
  Sequence number: 10
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
        remote address: 1.1.1.2
    Flow:
        sour addr: 10.0.0.0/255.255.255.0  port: 0  protocol: ip
        dest addr: 10.1.0.0/255.255.255.0  port: 0  protocol: ip

    [Inbound ESP SAs]
      SPI: 217522932 (0x0cf722f4)
      Connection ID: 12884901889
      Transform set: ESP-ENCRYPT-DES-CBC ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3504
      Max received sequence-number: 4
      Anti-replay check enable: Y
      Anti-replay window size: 64
      UDP encapsulation used for NAT traversal: N
      Status: Active

    [Outbound ESP SAs]
      SPI: 1251243487 (0x4a9475df)
      Connection ID: 12884901888
      Transform set: ESP-ENCRYPT-DES-CBC ESP-AUTH-SHA1
      SA duration (kilobytes/sec): 1843200/3600
      SA remaining duration (kilobytes/sec): 1843199/3504
      Max sent sequence-number: 4
      UDP encapsulation used for NAT traversal: N
      Status: Active
[zhongxin]
[zhongxin]
[zhongxin]dis
[zhongxin]display  ip rou
[zhongxin]display  ip routing-table

Destinations : 14       Routes : 14

Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.0/24         Direct  0   0           1.1.1.1         GE1/0/1
1.1.1.0/32         Direct  0   0           1.1.1.1         GE1/0/1
1.1.1.1/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.255/32       Direct  0   0           1.1.1.1         GE1/0/1
10.0.0.1/32        Direct  0   0           127.0.0.1       InLoop0
10.1.0.0/24        Static  100 0           1.1.1.2         GE1/0/1
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.0/32       Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0


配置关键点：
1.	中心上必须使用模板
2.	中心的IPSEC策略中需要开启反向路由注入功能
3.	分支需要写到中心私网地址的路由



## 说明： 


本案例使用HCL模拟器F1060