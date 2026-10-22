# 分布式VXLAN IP网关配置举例（IPv6网络）

## 需求：

VTEP-A、VTEP-C为分布式VXLAN
IP网关设备，VTEP-B为与广域网连接的边界网关设备，Internet为广域网内的三层设备。虚拟机VM
1属于VXLAN 10，VM 2属于VXLAN 20。通过分布式VXLAN
IP网关实现不同VXLAN网络的三层互联，并通过边界网关实现与广域网的三层互联。

具体需求为：

1.  不同VTEP之间手工建立VXLAN隧道。

2.  手工关联VXLAN和VXLAN隧道。

3.  站点之间的泛洪流量采用头端复制的方式转发。

## 实验步骤：

1.  配置IPv6地址和单播路由协议

2、VTEP之间创建VXLAN隧道，并将隧道与VXLAN关联，接口上关联VSI实例

3、分布式网关上配置vsi-interface，并与VSI关联

4、VM的缺省网关指向vsi-interface地址

## 测试结果：

查看VTEP-A上的Tunnel接口信息，可以看到VXLAN模式的Tunnel接口处于up状态。

![](./Media//image1.png)


查看VTEP-A上的VSI虚接口信息，可以看到VSI虚接口处于up状态。

![](./Media//image2.png)


VTEP-A上的VSI信息，可以看到VSI内创建的VXLAN、与VXLAN关联的VXLAN隧道、与VSI关联的VSI虚接口等信息。

![](./Media//image3.png)


查看VTEP-A上IPv6 neighbors表项信息，可以看到已经建立的邻居信息。

![](./Media//image4.png)


查看VTEP-A上FIB表项信息，可以看到已学习到了虚拟机的转发表项信息。

![](./Media//image5.png)


虚拟机VM 1、VM 2之间可以互访，VM 1、VM 2和Internet可以互访。

![](./Media//image6.png)


![](./Media//image7.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
