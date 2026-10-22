# EVPN和DRNI三层转发配置举例

## 需求：

Switch A、Switch B、Switch D为与服务器连接的VTEP设备，Switch A和Switch
B分布式聚合为一台虚拟VTEP设备，通过IPL（Intra-Portal
Link，内部控制链路）同步MAC地址和ARP信息。Switch C作为路由反射器在Switch
A、Switch B、Switch D之间反射路由。

虚拟机VM 1和VM 5属于VXLAN 10，VM4属于VXLAN
20，通过分布式EVPN网关实现不同VXLAN之间互通。

##  实验步骤：

1.  在交换机上配置路由协议，使得各交换机的接口IP地址（包括Loopback接口IP地址）之间路由可达。

2.  在Switch A、Switch
    B上开启EVPN支持分布式聚合功能，使两台设备虚拟为一台VTEP设备。

3.  配置Switch C作为路由反射器在Switch A、Switch B、Switch
    D之间反射路由。

4.  在Switch A、Switch B和Switch
    D上配置分布式EVPN网关，使VTEP之间通过BGP
    EVPN路由实现自动发现邻居、自动建立/关联VXLAN隧道、通告MAC/IP的可达性等，以便将虚拟机之间实现三层互通。

5.  在Switch A、Switch B和Switch
    D的下行端口上配置以太网服务实例和相应的匹配规则，用来识别用户网络中的报文所属的VXLAN。

## 测试结果：

查看Switch
A上的EVPN路由信息，可以看到SwitchA发送了网关的MAC/IP路由和IMET路由，并接收到Switch
B和Switch D发送的MAC/IP路由和IMET路由。

![](./Media//image1.png)


![](./Media//image2.png)


查看Switch
A上的Tunnel接口信息，可以看到VXLAN模式的Tunnel接口处于up状态，并且隧道源地址是虚拟VTEP地址。

![](./Media//image3.png)


查看Switch
A上的VSI信息，可以看到设备自动在IPL上创建了AC，并将其与VSI关联。

![](./Media//image4.png)


 虚拟机VM1、VM4和VM5之间可以互访。虚拟机与Switch A或Switch
B相连的链路断开后，VM1、VM4和VM5仍然可以通过另一台设备互访。以VM1为例:

![](./Media//image5.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
