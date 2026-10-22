# 工程名称

防火墙静态路由模式结合RBM实现主备（不推荐现网使用）

## 需求：
防火墙做RBM，并且只和静态路由配置实现主备。

组网IP如图，所有设备通过静态路由互访。


## 实验步骤：

1.配置交换机的IP和路由，由于静态路由无法被RBM控制，因此要配置浮动路由来实现主备。

2.配置防火墙RBM，静态模式需要用track interface。

3.配置安全策略和安全域，放通trust-untrust，上行为trust，下行为untrust。

4.配置防火墙IP和路由。

5.测试结果

## 测试结果：
上行ping下行正常

ping -a 10.1.1.1 20.1.1.1

Ping 20.1.1.1 (20.1.1.1) from 10.1.1.1: 56 data bytes, press CTRL_C to bak

56 bytes from 20.1.1.1: icmp_seq=0 ttl=254 time=12.000 ms

56 bytes from 20.1.1.1: icmp_seq=1 ttl=254 time=2.000 ms

56 bytes from 20.1.1.1: icmp_seq=2 ttl=254 time=1.000 ms

56 bytes from 20.1.1.1: icmp_seq=3 ttl=254 time=1.000 ms

56 bytes from 20.1.1.1: icmp_seq=4 ttl=254 time=1.000 ms


并且关掉主墙接口，上下行接口联动down，下行原因为RBMdown。说明主备切换正常。

Brief information on interfaces in route mode:

Link: ADM - administratively down; Stby - standby

Protocol: (s) - spoofing

Interface            Link Protocol Primary IP      Description   
       
GE1/0/0              DOWN DOWN     --


GE1/0/1              DOWN DOWN     192.168.0.1

GE1/0/2              ADM  DOWN     2.2.2.2

GE1/0/3              UP   UP       1.1.1.1

GE1/0/4              DOWN DOWN     3.3.3.2

GE1/0/5              DOWN DOWN     --


RBM_P[H3C-GigabitEthernet1/0/2]dis int g 1/0/4

GigabitEthernet1/0/4

Current state: RBM-track Shutdown

Line protocol state: DOWN

Description: GigabitEthernet1/0/4 Interface



## 说明： 


RBM模拟器无法会话同步，只做ping测试，切换用接口联动情况来证明。
