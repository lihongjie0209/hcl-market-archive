# 分布式EVPN网关配置举例

## 需求：

Router A、Router B为分布式EVPN网关设备；Router
C为与广域网连接的边界网关设备；Router
D为RR，负责在路由器之间反射BGP路由。

虚拟机VM 1和VM 3属于VXLAN 10；VM 2和VM 4属于VXLAN
20。相同VXLAN之间可以二层互通；不同VXLAN之间通过分布式EVPN网关实现三层互通；VXLAN与广域网之间通过边界网关实现三层互通。

## 实验步骤：

1、配置IP地址和单播路由协议

2、创建VXLAN与VSI，VSI下配置EVPN实例

3、配置BGP L2VPN EVPN

4、接口关联VSI

## 测试结果：

查看Router
A上的Tunnel接口信息，可以看到VXLAN模式的Tunnel接口处于up状态。

![](./Media//image1.png)


查看Router
A上的VSI虚接口信息，可以看到VSI虚接口处于up状态。（以VSI虚接口1为例）

![](./Media//image2.png)


查看Router
A上的VSI信息，可以看到VSI内创建的VXLAN、与VXLAN关联的VXLAN隧道、与VSI关联的三层接口等信息。

![](./Media//image3.png)


查看Router A上VSI的ARP表项信息，可以看到已学习到了本地虚拟机的ARP信息。

![](./Media//image4.png)


查看Router A上VSI的EVPN
ARP表项信息，可以看到已学习到了本地虚拟机的ARP信息。

![](./Media//image5.png)


虚拟机VM 1、VM 2、VM 3之间可以互访。

![](./Media//image6.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
