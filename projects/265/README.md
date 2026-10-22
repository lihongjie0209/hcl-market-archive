# VXLAN头端复制配置举例

## 需求：

Router A、Router B、Router C为与服务器连接的VTEP设备。虚拟机VM 1、VM
2和VM 3同属于VXLAN
10。通过VXLAN实现不同站点间的二层互联，确保虚拟机在站点之间进行迁移时用户的访问流量不会中断。

具体需求为：

1.  不同VTEP之间手工建立VXLAN隧道。

2.  手工关联VXLAN和VXLAN隧道。

3.  通过源MAC地址动态学习远端MAC地址表项。

4.  站点之间的泛洪流量采用头端复制的方式转发。

## 实验步骤：

1、配置IP地址和单播路由协议

2、VTEP之间创建VXLAN隧道，并将隧道与VXLAN关联，然后接口上关联VSI实例

## 测试结果：

查看Router
A上的Tunnel接口信息，可以看到VXLAN模式的Tunnel接口处于up状态。

![](./Media//image1.png)


查看Router
A上的VSI信息，可以看到VSI内创建的VXLAN、与VXLAN关联的VXLAN隧道、与VSI关联的三层接口等信息。

![](./Media//image2.png)


查看Router A上VSI的MAC地址表项信息，可以看到已学习到的MAC地址信息。

![](./Media//image3.png)


虚拟机VM 1、VM 2、VM 3之间可以互访。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
