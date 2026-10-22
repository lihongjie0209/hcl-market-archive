# IS-IS与BFD联动配置举例

## 需求：

1.  当Router A、Router B和Router C上运行IS-IS，网络层相互可达。

2.  当Router A和Router B通过L2
    Switch通信的链路出现故障时BFD能够快速感知通告IS-IS协议，并且切换到Router
    C进行通信。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置ISIS基本功能

3.  配置ISIS与BFD联动

> 参考示例：
>
> \[RouterA\] bfd session init-mode active
>
> \[RouterA\] interface gigabitethernet 0/0
>
> \[RouterA-GigabitEthernet0/0\] isis bfd enable
>
> \[RouterA-GigabitEthernet0/0\] bfd min-receive-interval 500
>
> \[RouterA-GigabitEthernet0/0\] bfd min-transmit-interval 500
>
> \[RouterA-GigabitEthernet0/0\] bfd detect-multiplier 7

## 测试结果：

下面以Router A为例，Router B和Router A类似，不再赘述。

显示Router A的BFD信息

![](./Media//image2.png)


在Router A上查看120.1.1.1/32的路由信息，可以看出Router A和Router
B是通过L2 Switch进行通信的。

![](./Media//image3.png)


当Router A和Router B通过L2 Switch通信的链路出现故障时：

在Router A上查看120.1.1.1/32的路由信息，可以看出Router A和Router
B已经切换到Router C进行通信。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
