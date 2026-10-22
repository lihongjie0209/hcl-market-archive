## 需求：

1.  Switch B作为DHCP客户端，从DHCP服务器Switch
    A获取静态绑定的IP地址、域名服务器、网关地址等信息。

2.   Switch B上VLAN接口2的MAC地址为：6896-5b7f-0202。

## 实验步骤：

1)  配置接口的IP地址

2)  配置DHCP服务

```{=html}
<!-- -->
```
A.  \# 创建DHCP地址池0。

B.  \# 配置采用静态绑定方式为Switch B分配IP地址。

C.  \# 配置域名服务器、网关地址。

D.  \# 开启DHCP服务。

E.  \# 配置VLAN接口2工作在DHCP服务器模式。

## 测试结果：

配置完成后，Switch B可以从DHCP服务器Switch
A申请到IP地址10.1.1.6，并获取相关网络配置参数。通过**display dhcp server
ip-in-use**命令可以查看DHCP服务器为客户端分配的IP地址。

![](./Media//image1.png)


DHCP 客户端可看到被分配的IP地址。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
