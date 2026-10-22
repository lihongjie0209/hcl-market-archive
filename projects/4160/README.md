# VRRP单备份组配置举例

## 需求：

1.  Host A需要访问Internet上的Host B；

2.  当Switch A正常工作时，Host A发送给Host B的报文通过Switch
    A转发；当Switch A出现故障时，Host A发送给Host B的报文通过Switch
    B转发。

## 实验步骤：

1.  配置SWA，配置vlan2，创建备份组1，配置备份组1的虚拟地址为10.1.1.111，在备份组中优先级为110，工作方式为抢占方式，抢占延迟时间为5000厘秒；

2.  配置SWB，配置vlan2，创建备份组1，配置备份组1的虚拟地址为10.1.1.111，在备份组中优先级为100，工作方式为抢占方式，抢占延迟时间为5000厘秒；

3.  配置HostA与HostB的IP，用OSPF打通底层路由；

## 测试结果：

配置完成后，在Host A上可以ping通Host B。通过display vrrp
verbose命令查看配置后的结果：

![](./Media//image1.png)


![](./Media//image2.png)


显示Switch B上备份组1的详细信息

![](./Media//image3.png)


以上显示信息表示在备份组1中Switch A为Master，Switch B为Backup，Host
A发送给Host B的报文通过Switch A转发。

Switch A出现故障后，在Host A上仍然可以ping通Host B。

通过display vrrp verbose命令查看Switch B上备份组的详细信息。Switch
A出现故障后，显示Switch B上备份组1的详细信息。

![](./Media//image4.png)


以上显示信息表示Switch A出现故障后，Switch B成为Master，Host A发送给Host
B的报文通过Switch B转发。

![](./Media//image5.png)


Switch A故障恢复后，显示Switch A上备份组1的详细信息

![](./Media//image6.png)


以上显示信息表示Switch A故障恢复后，Switch A会抢占成为Master，Host
A发送给Host B的报文仍然通过Switch A转发。

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
