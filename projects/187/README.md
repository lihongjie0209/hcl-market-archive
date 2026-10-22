# IPv4 Hub-Spoke类型ADVPN典型配置举例

## 需求：

1.  在IPv4
    Hub-Spoke的组网方式下，数据通过Hub-Spoke隧道进行转发。主、备VAM
    Server负责管理、维护各个节点的信息；AAA服务器（模拟器采用本地认证）负责对VAM
    Client进行认证和计费管理；两个Hub互为备份，负责数据的转发和路由信息的交换。

2.  Spoke与Hub之间建立永久的ADVPN隧道。

根据数据转发方式的不同，ADVPN组网结构分为如下两种：

Full-Mesh（全互联）网络：Spoke和Spoke之间可以建立隧道直接通信。

Hub-Spoke网络：Spoke之间不能建立隧道直接通信，只能通过Hub转发数据。

在Full-Mesh网络中，Spoke向VAM
Server注册后获得Spoke所属ADVPN域所在Hub组中Hub的信息，并与Hub建立永久的ADVPN隧道。当两个Spoke之间有数据报文交互时，Spoke从VAM
Server获取对端Spoke的公网地址，并在Spoke之间直接建立隧道。Spoke之间的隧道是动态的，当在一段时间（Spoke-Spoke隧道空闲超时时间）内没有数据报文交互时，则删除该隧道。

在Hub-Spoke网络中，Spoke向VAM
Server注册后获得Spoke所属ADVPN域所在Hub组中Hub的信息，并与Hub建立永久的ADVPN隧道。两个Spoke之间有数据报文交互时，该报文通过Hub转发，不会在Spoke之间建立隧道。Hub既作为路由信息交换的中心，又作为数据转发的中心。

在OSPF中，有网络类型的存在，而Tunnel接口默认是点对点的。因为Hub跟Spoke是点对N的关系，那么则有Broadcast与P2MP选择，Broadcast是需要选举DR，BDR的，所以在这种情况下
Spoke不能充当DR，否则的话很有可能许多DR，Hub端会把Spoke都当成DR（可能Spoke端的Router
ID大），这样的话路由传递就会有问题。所以需要把Spoke的DR选举优先级改为0。

## 实验步骤：

1.  配置各个接口的IP地址

2.  配置动态路由，使其公网互通

3.  配置主、备VAM Server

4.  配置VAM Client

## 测试结果：

显示注册到主VAM Server的所有VAM Client的IPv4私网地址映射信息。

![](./Media//image1.png)


显示注册到备VAM Server的所有VAM Client的IPv4私网地址映射信息。

![](./Media//image2.png)


以上显示信息表示Hub1、Hub2、Spoke1和Spoke2均已将地址映射信息注册到VAM
Server。

显示Hub1上的IPv4 ADVPN隧道信息。

![](./Media//image3.png)


以上显示信息表示Hub1与Hub2、Spoke1、Spoke2建立了永久隧道。Hub2上的显示信息与Hub1类似。

显示Spoke1上的IPv4 ADVPN隧道信息。

![](./Media//image4.png)


以上显示信息表示Spoke1与Hub1、Hub2建立了Hub-Spoke永久隧道。Spoke2上的显示信息与Spoke1类似。

在Spoke1上ping Spoke2的私网地址192.168.0.4。

![](./Media//image5.png)


两端私网地址tracert，发现Spoke之间的报文需要经过Hub转发。

![](./Media//image6.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
