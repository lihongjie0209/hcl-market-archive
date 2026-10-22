# 工程名称
双链路备份典型配置举例


## 需求：
AP通过Switch与AC 1和AC 2连接，具体要求如下：
·              使用双链路备份对AC进行备份，AC 1工作在主用状态，AC 2工作在备用状态，当AC 1发生故障或主备AC切换时，AP可以通过AC 2进行通信。


## 实验步骤：
1、在SW上配置dhcp server，两个AC的ip通过option43下发给AP。
dhcp server ip-pool 1
 gateway-list 192.168.2.1
 network 192.168.2.0 mask 255.255.255.0
 option 43 hex 800b000002c0a80101c0a80102
2、AC1和AC2配置自动注册，和主AC1的优先级
AC1：
wlan ap-group default-group
 priority 7
 backup-ac ip 192.168.1.2
 vlan 1

## 测试结果：
通过display wlan ap all命令在AC 1查看AP的状态为R/M。

![1](./Media/1.png) 

通过display wlan ap all命令在AC 2查看AP的状态为R/B。

![5.png](./Media/5.png)

模拟AC 1故障，将AC 1的G1/0/1接口关闭，等待一段时间，AP会切换至AC 2上线，在AC 2上通过display wlan ap all命令查看AP的状态为R/M。
![6.png](./Media/6.png)

![1](./Media/3.png) 


## 说明： 


