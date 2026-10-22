# 工程名称
V7防火墙OSPF基本配置


## 需求：
1、防火墙和路由器之间运行OSPF协议
2、内网172.16.13.0/24网段和192.168.24.0/24网段可以互通


## 实验步骤：
**1、配置接口ip**

**2、配置OSPF，指定环回口地址为router ID，宣告互联地址和内网网段**
#
ospf 1 router-id 1.1.1.1
 area 0.0.0.0
  network 10.0.12.1 0.0.0.0
  network 172.16.13.0 0.0.0.255
#

**3、内网口加入trust安全域，与路由器互联的接口加入untrust安全域**
#
security-zone name Trust
 import interface GigabitEthernet1/0/2
#
security-zone name Untrust
 import interface GigabitEthernet1/0/1
#

**4、配置安全策略规则1放行untrust域和local域之间的OSPF报文，规则2放行trust和untrust之间互访的流量**
#
security-policy ip
 rule 1 name ospf
  action pass
  source-zone local
  source-zone untrust
  destination-zone untrust
  destination-zone local
  service ospf
 rule 2 name permit
  action pass
  source-zone trust
  destination-zone untrust
  source-ip-subnet 172.16.13.0 255.255.255.0 
 rule 3 name permit2
  action pass
  source-zone untrust
  destination-zone trust
  source-ip-subnet 192.168.24.0 255.255.255.0 
#      


## 测试结果：
1、防火墙上可以看到OSPF邻居建立成功，路由表有去往192.168.24.0/24网段的路由。
<FW1>dis ospf peer

         OSPF Process 1 with Router ID 1.1.1.1
               Neighbor Brief Information

 Area: 0.0.0.0        
 Router ID       Address         Pri Dead-Time  State             Interface
 1.1.1.2         10.0.12.2       1   37         Full/DR           GE1/0/1
<FW1>
<FW1>dis ip routing-table 
Destinations : 15       Routes : 15
Destination/Mask   Proto   Pre Cost        NextHop         Interface
0.0.0.0/32         Direct  0   0           127.0.0.1       InLoop0
1.1.1.1/32         Direct  0   0           127.0.0.1       InLoop0
10.0.12.0/24       Direct  0   0           10.0.12.1       GE1/0/1
10.0.12.1/32       Direct  0   0           127.0.0.1       InLoop0
10.0.12.255/32     Direct  0   0           10.0.12.1       GE1/0/1
127.0.0.0/8        Direct  0   0           127.0.0.1       InLoop0
127.0.0.1/32       Direct  0   0           127.0.0.1       InLoop0
127.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
172.16.13.0/24     Direct  0   0           172.16.13.1     GE1/0/2
172.16.13.1/32     Direct  0   0           127.0.0.1       InLoop0
172.16.13.255/32   Direct  0   0           172.16.13.1     GE1/0/2
**192.168.24.0/24    O_INTRA 10  2           10.0.12.2       GE1/0/1**
224.0.0.0/4        Direct  0   0           0.0.0.0         NULL0
224.0.0.0/24       Direct  0   0           0.0.0.0         NULL0
255.255.255.255/32 Direct  0   0           127.0.0.1       InLoop0
<FW1> 
<FW1>

2、PC1和PC2可以互通
<PC1>ping 192.168.24.4
Ping 192.168.24.4 (192.168.24.4): 56 data bytes, press CTRL+C to break
56 bytes from 192.168.24.4: icmp_seq=0 ttl=253 time=3.000 ms
56 bytes from 192.168.24.4: icmp_seq=1 ttl=253 time=2.000 ms
56 bytes from 192.168.24.4: icmp_seq=2 ttl=253 time=2.000 ms
56 bytes from 192.168.24.4: icmp_seq=3 ttl=253 time=2.000 ms
56 bytes from 192.168.24.4: icmp_seq=4 ttl=253 time=2.000 ms

--- Ping statistics for 192.168.24.4 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss

<PC2>ping 172.16.13.3
Ping 172.16.13.3 (172.16.13.3): 56 data bytes, press CTRL+C to break
56 bytes from 172.16.13.3: icmp_seq=0 ttl=253 time=1.000 ms
56 bytes from 172.16.13.3: icmp_seq=1 ttl=253 time=1.000 ms
56 bytes from 172.16.13.3: icmp_seq=2 ttl=253 time=3.000 ms
56 bytes from 172.16.13.3: icmp_seq=3 ttl=253 time=1.000 ms
56 bytes from 172.16.13.3: icmp_seq=4 ttl=253 time=2.000 ms

--- Ping statistics for 172.16.13.3 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss


## 说明： 
**为了保证任意一方都能正常发出和响应OSPF报文，需要双向放行server和local之间的ospf报文**

