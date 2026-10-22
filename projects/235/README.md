# IPv4兼容IPv6自动隧道典型配置举例

## 需求：

两台具有双协议栈的路由器Router A和Router
B通过IPv4网络连接。网络管理员希望建立IPv4兼容IPv6自动隧道，使得这两台设备能够通过IPv6协议互通。

## 实验步骤：

1.  配置IP地址，并且Router A和Router B之间路由可达。

2.  创建模式为IPv4兼容IPv6自动隧道的接口Tunnel0。

## 测试结果：

完成上述配置后，在Router A和Router B上分别执行display ipv6
interface命令，可以看出Tunnel0接口处于up状态。

![](./Media//image1.png)


从Router A和Router B上可以Ping通对端的IPv4兼容IPv6地址。下面仅以Router
A为例。

![](./Media//image2.png)


报文封装格式：外层为IPv4隧道地址，内层为IPv4兼容IPv6地址。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
