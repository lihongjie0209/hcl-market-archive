# 工程名称
Private VLAN  Promiscuous模式配置


## 需求：
S6850_2上的Primary VLAN 5包含上行端口GigabitEthernet1/0/1，并关联两个Secondary VLAN（VLAN 2和VLAN 3），其中，VLAN 2包含端口GigabitEthernet1/0/2，VLAN 3包含端口GigabitEthernet1/0/3。  
从S6850_1看，下接的Device B只有一个VLAN（VLAN 5）。  
PC_3属于VLAN 5，通过Primary VLAN跟VLAN 2的PC_4以及VLAN 3的PC_5实现互访。


## 实验步骤：
6850_2的配置步骤：     
1、配置VLAN 5为Primary VLAN   
2、配置VLAN 2、3为Secondary VLAN   
3、配置上行端口GigabitEthernet1/0/1在VLAN 5中工作在promiscuous模式（不需要配置接口VLAN，配置port private-vlan 5 promiscuous会自动配置端口VLAN）   
4、将下行端口GigabitEthernet1/0/2、GigabitEthernet1/0/3分别添加到VLAN 2、VLAN 3，并配置它们工作在host模式（不需要配置接口VLAN，配置port private-vlan host会自动配置端口VLAN）。  
6850_1的配置步骤：  
配置VLAN 5，并将上行端口GigabitEthernet1/0/1以及下行端口GigabitEthernet1/0/2添加到VLAN 5。


## 测试结果：
查看6850_2 Private VLAN配置情况  
[S6850_2]display private-vlan 5  
 Primary VLAN ID: 5  
 Secondary VLAN ID: 2-3  

 VLAN ID: 5  
 VLAN type: Static  
 Private VLAN type: Primary  
 Route interface: Not configured  
 Description: VLAN 0005  
 Name: VLAN 0005  
 Tagged ports:     
    None  
 Untagged ports:   
    GigabitEthernet1/0/1(U)            GigabitEthernet1/0/2(U)              
    GigabitEthernet1/0/3(U)            

 VLAN ID: 2  
 VLAN type: Static  
 Private VLAN type: Secondary  
 Route interface: Not configured  
 Description: VLAN 0002  
 Name: VLAN 0002  
 Tagged ports:     
    None  
 Untagged ports:   
    GigabitEthernet1/0/1(U)            GigabitEthernet1/0/2(U)              

 VLAN ID: 3  
 VLAN type: Static  
 Private VLAN type: Secondary  
 Route interface: Not configured  
 Description: VLAN 0003  
 Name: VLAN 0003  
 Tagged ports:     
    None  
 Untagged ports:   
    GigabitEthernet1/0/1(U)            GigabitEthernet1/0/3(U)         

PC_3与PC_1、PC_2成功互访记录
<H3C>ping 192.168.1.1  
Ping 192.168.1.1 (192.168.1.1): 56 data bytes, press CTRL_C to break  
56 bytes from 192.168.1.1: icmp_seq=0 ttl=255 time=2.000 ms  
56 bytes from 192.168.1.1: icmp_seq=1 ttl=255 time=1.000 ms  
56 bytes from 192.168.1.1: icmp_seq=2 ttl=255 time=1.000 ms  
56 bytes from 192.168.1.1: icmp_seq=3 ttl=255 time=2.000 ms  
56 bytes from 192.168.1.1: icmp_seq=4 ttl=255 time=2.000 ms  
  
--- Ping statistics for 192.168.1.1 ---  
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.600/2.000/0.490 ms  
<H3C>%Aug  2 16:20:57:055 2022 H3C PING/6/PING_STATISTICS: Ping statistics for 192.168.1.1: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/1.600/2.000/0.490 ms.  
ping 192.168.1.2  
Ping 192.168.1.2 (192.168.1.2): 56 data bytes, press CTRL_C to break  
56 bytes from 192.168.1.2: icmp_seq=0 ttl=255 time=3.000 ms  
56 bytes from 192.168.1.2: icmp_seq=1 ttl=255 time=1.000 ms  
56 bytes from 192.168.1.2: icmp_seq=2 ttl=255 time=2.000 ms  
56 bytes from 192.168.1.2: icmp_seq=3 ttl=255 time=1.000 ms  
56 bytes from 192.168.1.2: icmp_seq=4 ttl=255 time=1.000 ms  
  
--- Ping statistics for 192.168.1.2 ---  
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss
round-trip min/avg/max/std-dev = 1.000/1.600/3.000/0.800 ms  
<H3C>%Aug  2 16:20:58:866 2022 H3C PING/6/PING_STATISTICS: Ping statistics for 192.168.1.2: 5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss, round-trip min/avg/max/std-dev = 1.000/1.600/3.000/0.800 ms.  


## 说明： 
1、本实验用的模拟器为S6850，设置内存为默认。  
2、本实验用的路由器版本为默认。

