# 集中式EVPN网关配置举例

## 需求：

使用Router A、Router B为与服务器连接的VTEP设备；Router
C为与广域网连接的集中式EVPN网关设备；Router
D为RR，负责在路由器之间反射BGP路由。

虚拟机VM 1和VM 3属于VXLAN 10；VM 2和VM 4属于VXLAN
20。相同VXLAN之间可以二层互通，不同VXLAN之间、VXLAN与广域网之间可以通过集中式EVPN网关互通。

## 实验步骤：

1、配置IP地址和单播路由协议

2、配置VXLAN与VSI，创建EVPN实例

3、配置BGP L2VPN EVPN

4、接口关联VSI实例

## 测试结果：

查看Router C上的EVPN路由信息，可以看到Router
C发送了网关的MAC/IP路由和IMET路由，并接收到Router A和Router
B发送的MAC/IP路由和IMET路由。

![](./Media//image1.png)


查看Router
C上的Tunnel接口信息，可以看到VXLAN模式的Tunnel接口处于up状态。

![](./Media//image2.png)


查看Router C上的VSI虚接口信息，可以看到VSI虚接口处于up状态。

![](./Media//image3.png)


查看Router
C上的VSI信息，可以看到VSI内创建的VXLAN、与VXLAN关联的VXLAN隧道、与VSI关联的VSI虚接口等信息。

![](./Media//image4.png)


查看Router C上VSI的EVPN ARP表项信息，可以看到已学习到了虚拟机的ARP信息。

![](./Media//image5.png)


查看Router C上FIB表项信息，可以看到已学习到了虚拟机的转发表项信息。

![](./Media//image6.png)


虚拟机VM 1、VM 2、VM 3、VM 4之间可以互访。

![](./Media//image7.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
