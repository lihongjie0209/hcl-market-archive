# 工程名称
TCP源地址插入


## 需求：
MSR2作为客户端，FW作为LB，MSR作为实服务器并且开启Telnet服务做测试
虚服务地址端口分别为192.168.0.1与2000 SNAT地址为1.1.1.1---1.1.1.2 real server
服务器的地址与端口分别为100.0.0.2和23
![TCP源地址拆入.png](./Media/TCP源地址拆入.png)
需求为：客户端MSR2通过访问VSIP 192.168.0.1的2000 端口来访问100.0.0.2的23端口
但是要溯源。



## 实验步骤：
接口IP地址配置：
interface GigabitEthernet1/0/1
 port link-mode route
 combo enable copper
 ip address 10.0.0.1 255.255.255.0
#
interface GigabitEthernet1/0/2
 port link-mode route
 combo enable copper
 ip address 100.0.0.1 255.255.255.0


接口加入安全域：
security-zone name Trust
 import interface GigabitEthernet1/0/1
#
security-zone name Untrust
 import interface GigabitEthernet1/0/2



配置TCP类型的参数模板,超如option为28的源地址
parameter-profile tcp_option type tcp
 tcp option remove 8
 tcp option insert 28 src-addr
#
配置SNAT地址池
loadbalance snat-pool snat1
 ip range start 1.1.1.1 end 1.1.1.2

配置实服务器
real-server rs1
 ip address 100.0.0.2
 port 23
 server-farm sf1
 probe t1
 success-criteria at-least 1
#

配置虚服务器，虚服务中调用参数模板
virtual-server vs1 type tcp
 port 2000
 virtual ip address 192.168.0.1
 parameter tcp tcp_option client-side
 parameter tcp tcp_option server-side
 default server-farm sf1
 connection-sync enable
 sticky-sync enable
 application-mode enable
 service enable
#
security-policy ip
 rule 0 name 0
  action pass




## 测试结果：
tcp option-user timeout字段 kind是28
然后鼠标点击到tcp option-user timeout字段 总长度是6个字节，取
最后四个字节，比如10.0.0.2对应 0a 00 00 02

![TCP源地址插入1.png](./Media/TCP源地址插入1.png)


## 说明： 
本实验室使用HCL模拟器进行
