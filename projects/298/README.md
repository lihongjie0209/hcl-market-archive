# VRRP、Track与控制报文方式的BFD会话联动配置举例（Backup监视Master）

## 需求：

当Switch A正常工作时，Host A发送给Host B的报文通过Switch
A转发；Master出现故障时，Backup若只依赖于VRRP通告报文的超时时间来判断是否应该抢占，切换时间一般在3秒～4秒之间，无法达到秒级以下的切换速度；如果Backup通过控制报文方式的BFD会话检测Master的运行状态，则能够在毫秒级的时间内发现Master的故障，立即抢占成为Master，加快切换速度。

##  实验步骤：

1.  在交换机上配置路由协议，使得各交换机的接口IP地址之间路由可达；

2.  在Switch B上配置控制报文方式的BFD会话、Track项，两者关联一起；

3.  在Switch A和Switch B上配置VRRP。

## 测试结果：

在Switch A和Switch
B上查看备份组1的详细信息，可以看到vrrp关联了track1，状态为positive，track关联的为BFD
echo。Switch A为Master路由器，Switch B为Backup路由器。

![](./Media//image1.png)


![](./Media//image2.png)


![](./Media//image3.png)


打开Switch
B的VRRP状态调试信息开关和Echo报文方式的BFD会话事件通知调试信息开关。

\<SwitchB\> terminal debugging

\<SwitchB\> terminal monitor

\<SwitchB\> debugging vrrp fsm

\<SwitchB\> debugging bfd ntfy

Switch A出现故障时，Switch
B上输出如下调试信息，可以看出控制报文方式的BFD会话探测到Switch
A出现故障后，立即由Track通知VRRP模块将Switch
B的状态切换为Master，不再等待VRRP通告报文的超时时间，从而保证Backup路由器能够快速切换为Master。

![](./Media//image4.png)


![](./Media//image5.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
