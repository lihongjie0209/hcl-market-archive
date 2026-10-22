# 工程名称

V7 NGFW配置安全策略实现仅允许某个ip访问运营商网络(白名单效果)

## 需求：
仅允许内网172.16.5.4的PC访问运营商网络，内网其他地址都禁止


## 实验步骤：
**1、配置接口IP及路由保证内外网各自可以互通**

**2、防火墙配置安全域，将内网口加入trust域，公网口加入untrust域**
#
security-zone name Trust
 import interface GigabitEthernet1/0/2
#
security-zone name Untrust
 import interface GigabitEthernet1/0/1
#

**3、防火墙配置nat global-policy，对所有内网访问运营商网络的数据做SNAT**
#
nat global-policy
 rule name tointernet
  source-zone trust
  destination-zone untrust
  action snat easy-ip
#

**4、防火墙配置安全策略，第一条rule禁止172.16.5.4访问运营商网络，第二条rule放行其他地址**
#
security-policy ip
 rule 1 name permit172.16.5.4
  action pass
  source-zone trust
  destination-zone untrust
  source-ip-host 172.16.5.4 
 rule 5 name denytointernet
  source-zone trust
  destination-zone untrust
  source-ip-subnet 172.16.5.0 255.255.255.0 
#


## 测试结果：
1、PC1 172.16.5.4可以ping通运营商地址100.0.12.1
[PC1]ping 100.0.12.1
Ping 100.0.12.1 (100.0.12.1): 56 data bytes, press CTRL+C to break
56 bytes from 100.0.12.1: icmp_seq=0 ttl=253 time=1.000 ms
56 bytes from 100.0.12.1: icmp_seq=1 ttl=253 time=1.000 ms
56 bytes from 100.0.12.1: icmp_seq=2 ttl=253 time=1.000 ms
56 bytes from 100.0.12.1: icmp_seq=3 ttl=253 time=2.000 ms
56 bytes from 100.0.12.1: icmp_seq=4 ttl=253 time=1.000 ms

--- Ping statistics for 100.0.12.1 ---
5 packet(s) transmitted, 5 packet(s) received, 0.0% packet loss

2、PC2 172.16.5.5不可以ping通运营商地址100.0.12.1
[PC2]ping 100.0.12.1
Ping 100.0.12.1 (100.0.12.1): 56 data bytes, press CTRL+C to break
Request time out
Request time out
Request time out
Request time out
Request time out

--- Ping statistics for 100.0.12.1 ---
5 packet(s) transmitted, 0 packet(s) received, 100.0% packet loss

## 说明： 
**1、防火墙安全策略规则是按照从上往下的显示顺序匹配的，与rule id无关
2、内网访问运营商的流量是从g1/0/2进来，g1/0/1出去，g1/0/2属于trust域，g1/0/1属于untrust域，所以控制这部分流量是做trust倒untrust的规则
3、源地址转换在安全策略匹配之后，所以安全策略规则里面的源ip地址需要写转换前的ip地址
4、安全策略规则默认动作是拒绝，也就是不配置action pass就代表拒绝**

