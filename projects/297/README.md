# VRRP、Track与NQA联动配置举例（Master监视上行链路）

## 需求：

当Switch A正常工作时，Host A发送给Host B的报文通过Switch
A转发；当通过NQA监测到Switch A上行链路不通时，Host A发送给Host
B的报文通过Switch B转发。Switch A和Switch
B属于虚拟IP地址为10.1.1.10的备份组。

##  实验步骤：

1.  在交换机上配置路由协议，使得各交换机的接口IP地址之间路由可达；

2.  在Switch A上配置NQA测试组、Track项，两者关联一起；

3.  在Switch A和Switch B上配置VRRP。

## 测试结果：

在Switch A和Switch
B上查看备份组1的详细信息，可以看到vrrp关联了track1，状态为positive。在备份组1中Switch
A为Master，Switch B为Backup，Host A发送给Host B的报文通过Switch A转发。

![](./Media//image1.png)


![](./Media//image2.png)


Switch A与Switch C不通时，在Host A上仍然可以ping通Host B。通过display
vrrp命令查看备份组的信息。Switch A与Switch C不通时，显示Switch
A上备份组1的详细信息。其中track变为negative状态， Switch
A的优先级降低为80，成为Backup，Switch B成为Master，Host A发送给Host
B的报文通过Switch B转发。

![](./Media//image3.png)


![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
