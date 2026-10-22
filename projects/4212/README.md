# 工程名称
V7交换机本地端口镜像


## 需求：
交换机配置端口镜像，将接口g1/0/4接口入方向的流量、接口g1/0/5出方向的流量、接口g1/0/6出入方向的流量都镜像到监控口g1/0/1


## 实验步骤：
1、交换机配置本地端口镜像组1
#
mirroring-group 1 local 
#

2、指定镜像组源端口及镜像数据的方向

#
mirroring-group 1 mirroring-port GigabitEthernet 1/0/4 inbound 

mirroring-group 1 mirroring-port GigabitEthernet 1/0/5 outbound

mirroring-group 1 mirroring-port GigabitEthernet 1/0/6 both

#

3、指定镜像组目的端口

#
mirroring-group 1 monitor-port GigabitEthernet 1/0/1
#

## 测试结果：
1、查看镜像组状态正常

[SW1]dis mirroring-group all 
Mirroring group 1:
    Type: Local
    Status: Active	//active代表正常
    Mirroring port:
        GigabitEthernet1/0/4  Inbound
        GigabitEthernet1/0/5  Outbound
        GigabitEthernet1/0/6  Both
    Monitor port: GigabitEthernet1/0/1

[SW1]


2、监控设备上可以看到指定源端口指定方向的数据(本工程重点说明交换机的镜像配置，所以模拟的监控设备未作任何配置)



## 说明： 
实际不同的产品对镜像组的源端口等都有不同的要求，现网操作以设备及版本对应的配置手册说明为准

