# VRRP负载均衡模式配置举例（交换机）

## 需求：

1.  Switch A、Switch B和Switch C属于备份组1；

2.  备份组1工作在负载均衡模式，通过一个备份组实现负载分担，充分利用网关资源；

3.  在Switch A、Switch B和Switch
    C上分别配置虚拟转发器通过Track项监视上行接口（VLAN接口3）的状态。当上行接口出现故障时，降低Switch
    A、Switch B或Switch
    C上虚拟转发器的权重，以便其它设备接管它的转发任务。

## 实验步骤：

1.  配置Switch A，配置VLAN
    2，配置VRRP工作在负载均衡模式，创建备份组1，并配置备份组1的虚拟IP地址为10.1.1.1，配置Switch
    A在备份组1中的优先级为120，，配置Switch
    A工作在抢占方式，配置抢占延迟时间为5000厘秒，创建和VLAN接口3物理状态关联的Track项1，配置虚拟转发器监视Track项1。

2.  配置Switch B，配置VLAN
    2，配置VRRP工作在负载均衡模式，创建备份组1，并配置备份组1的虚拟IP地址为10.1.1.1，配置Switch
    A在备份组1中的优先级为110，，配置Switch
    A工作在抢占方式，配置抢占延迟时间为5000厘秒，创建和VLAN接口3物理状态关联的Track项1，配置虚拟转发器监视Track项1。

3.  配置SWC，配置VLAN
    2，配置VRRP工作在负载均衡模式，创建备份组1，并配置备份组1的虚拟IP地址为10.1.1.1，优先级默认为110，，配置Switch
    A工作在抢占方式，配置抢占延迟时间为5000厘秒，创建和VLAN接口3物理状态关联的Track项1，配置虚拟转发器监视Track项1。

## 测试结果：

配置完成后，在Host A上可以ping通外网。通过display vrrp
verbose命令查看配置后的结果。

显示Switch A上备份组1的详细信息

![](./Media//image1.png)


显示Switch B上备份组1的详细信息

![](./Media//image2.png)


显示Switch C上备份组1的详细信息

![](./Media//image3.png)


以上显示信息表示在备份组1中Switch A为Master，Switch B和Switch C
为Backup。Switch A、Switch B和Switch
C上各自存在一个AVF，并存在作为备份的两个LVF。

当Switch A的上行接口（VLAN接口3）出现故障后，通过display vrrp
verbose命令查看Switch A上备份组的详细信息

![](./Media//image4.png)


通过**display vrrp verbose**命令查看Switch C上备份组的详细信息

![](./Media//image5.png)


以上显示信息表示Switch A的上行接口出现故障后，Switch
A上虚拟转发器的权重降低为5，低于失效下限。Switch
A上所有虚拟转发器的状态均变为Initialize，不能再用于转发。Switch
C成为虚拟MAC地址000f-e2ff-0011对应虚拟转发器的AVF，接管Switch
A的转发任务。

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
