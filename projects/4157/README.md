# 集中式VXLAN IP网关配置举例

**标签：**

VXLAN

集中式网关

**组网需求：**

Switch A、Switch C为与服务器连接的VTEP设备，Switch
B为与广域网连接的集中式VXLAN IP网关设备，Switch
E为广域网内的三层交换机。虚拟机VM 1、VM 2同属于VXLAN
10，通过VXLAN实现不同站点间的二层互联，并通过VXLAN
IP网关与广域网三层互联。

具体需求为：

（1）不同VTEP之间手工建立VXLAN隧道。

（2）手工关联VXLAN和VXLAN隧道。

（3）通过源MAC地址动态学习远端MAC地址表项。

（4）站点之间的泛洪流量采用头端复制的方式转发。

**实验步骤：**

1.  根据组网图，完成各个VLAN与VLAN接口的创建。

2.  配置IP地址和单播路由协议。

3.  配置SWA、SWC使能L2VPN，创建VSI实例与VXLAN，创建各自之间的隧道与VXLAN相关联。

4.  SWB使能L2VPN，创建VSI实例与VXLAN，创建各自之间的隧道与VXLAN相关联。

**测试结果：**

（1）验证VXLAN IP网关设备Switch B

\# 查看Switch
B上的Tunnel接口信息，可以看到VXLAN模式的Tunnel接口处于up状态**。**

![](./Media//image1.png)


（2）查看Switch B上的VSI虚接口信息，可以看到VSI虚接口处于up状态。

![](./Media//image2.png)


（3）查看Switch
B上的VSI信息，可以看到VSI内创建的VXLAN、与VXLAN关联的VXLAN隧道、与VSI关联的VSI虚接口等信息。

![](./Media//image3.png)


4.  查看Switch B上VSI的ARP表项信息，可以看到已学习到了虚拟机的ARP信息。

![](./Media//image4.png)


5.  查看Switch B上FIB表项信息，可以看到已学习到了虚拟机的转发表项信息。

![](./Media//image5.png)


6.  验证主机和广域网互访

> 虚拟机VM 1、VM 2之间可以互访，VM 1、VM 2和Switch
> E上接口Vlan-interface20的地址20.1.1.5之间可以互访。

![](./Media//image6.png)

