# 工程名称

防火墙静态路由模式结合RBM实现双主（不推荐现网使用）

## 需求：

防火墙做RBM，并且只和静态路由配置实现双主。
组网IP如图，所有设备通过静态路由互访。

## 实验步骤：
1.配置交换机的IP和路由，由于静态路由无法被RBM控制，因此要配置等价路由来实现双主。
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

## 说明： 
1.双主模式不能会话同步，因此没做其他测试，如果感兴趣可以做切换测试。

