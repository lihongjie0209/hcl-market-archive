# IPv4 over IPv6手动隧道典型配置举例

## 需求：

两个IPv4网络分别通过Router A和Router B与IPv6网络连接。通过在Router
A和Router B之间建立IPv4 over
IPv6手动隧道，实现两个IPv4网络穿越IPv6网络互联。

## 实验步骤：

1.  配置IP地址，并且Router A和Router B之间路由可达。

2.  创建模式为IPv6隧道的接口Tunnel0。

3.  配置相关路由指向Tunnel口。

## 测试结果：

完成上述配置后，在Router A和Router B上分别执行display interface
tunnel命令，可以看出Tunnel接口处于up状态。

![](./Media//image1.png)


从Router A和Router
B上可以Ping通对端的GigabitEthernet0/1接口的IPv4地址。下面仅以Router
A为例。

![](./Media//image2.png)


报文封装格式：

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
