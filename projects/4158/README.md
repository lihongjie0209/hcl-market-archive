# 集中式VXLAN IP网关保护组配置举例

## 需求：

Switch A、Switch B 为与服务器连接的 VTEP 设备，Switch C 和 Switch D
为与广域网连接的集中式 VXLAN IP 网关设备。虚拟机 VM 1 属于 VXLAN
10，虚拟机 VM 4 属于 VXLAN 20。通过 VXLAN IP 网关保护组实现 Switch C 和
Switch D
能够同时对虚拟机的跨网络报文进行三层转发，同时实现网关设备的备份。

##  实验步骤：

1.  在IP 核心网络上配置路由协议；

2.  在 Switch A、Switch B、Switch C 和 Switch D 之间建立 VXLAN
    隧道，并将 VXLAN 隧道与VXLAN 关联，以便将虚拟机发送的二层报文封装为
    IP 报文后在 IP 核心网络上转发；

3.  在 Switch A 和 Switch B
    的下行端口上配置以太网服务实例和相应的匹配规则，用来识别用户网络中的报文所属的
    VXLAN；

4.  在集中式 VXLAN IP 网关 Switch C 和 Switch D 上为每个 VXLAN
    分别创建一个 VSI 虚接口，并为其配置 IP 地址，该地址作为各自 VXLAN
    内虚拟机的网关地址；在 Switch C 和 Switch D上配置路由协议将 VSI
    虚接口、Vlan-interface100 所在网段路由发布到 L3 network，以便 L3
    network 内的节点具有到达虚拟机的路由，本举例以 OSPF 路由协议为例。

5.  将 Switch C 和 Switch D 加入集中式 VXLAN IP
    网关保护组，实现网关设备的备份。

## 测试结果：

以 Switch A 为例，在 VTEP 上查看 Tunnel 接口信息，可以看到 VXLAN 模式的
Tunnel 接口处于up 状态。其中，Tunnel1 和 Tunnel2 为手工创建的 VXLAN
隧道，Tunne0 和 Tunnel3 为 VTEP 与VXLAN IP
网关保护组成员设备之间自动建立的 VXLAN 隧道。：

![](./Media//image1.png)


![](./Media//image2.png)


以 Switch C 为例，在集中式 VXLAN IP 网关上查看 VSI 虚接口信息，可以看到
VSI 虚接口处于up 状态。

![](./Media//image3.png)


 以 Switch A 为例，在 VTEP 上查看 VSI 信息，可以看到 VSI 内创建的
VXLAN、与 VXLAN 关联的 VXLAN 隧道、与 VSI 关联的以太网服务实例等信息。

![](./Media//image4.png)


![](./Media//image5.png)


虚拟机 VM 1、VM 2、VM3、VM4 之间均可以互访，且可以 ping 通 100.1.1.0/24
网段内的地址。

![](./Media//image6.png)


\# 在 Switch C 上查看 FIB
表项信息，可以看到已学习到了虚拟机的转发表项信息。

![](./Media//image7.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
