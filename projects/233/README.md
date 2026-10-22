# IPv6 over IPv4手动隧道典型配置举例

## 需求：

两个IPv6网络分别通过Router A和Router B与IPv4网络连接，要求在Router
A和Router B之间建立IPv6 over
IPv4隧道，使两个IPv6网络可以互通。由于隧道终点的IPv4地址不能从IPv6报文的目的地址中自动获取，因此，需要配置IPv6
over IPv4手动隧道。

## 实验步骤：

1.  配置IP地址，并且Router A和Router B之间路由可达。

2.  创建模式为IPv6 over IPv4手动隧道的接口Tunnel0。

3.  配置静态路由指向tunnel口。

## 测试结果：

完成上述配置后，在Router A和Router B上分别执行display ipv6
interface命令，可以看出Tunnel0接口处于up状态。

![](./Media//image1.png)


从Router A和Router
B上可以Ping通对端的GigabitEthernet0/1接口的IPv6地址。下面仅以Router
A为例。

![](./Media//image2.png)


报文封装格式：外层为IPv4隧道地址，内层为IPv6地址。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
