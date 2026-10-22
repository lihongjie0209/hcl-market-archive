# MPLS 跨域VPN-OptionA方式示例

## 需求：

1.  CE 1和CE 2属于同一个VPN。

2.  CE 1通过AS 100的PE 1接入，CE 2通过AS 200的PE 2接入。

3.  采用OptionA方式实现跨域的MPLS
    L3VPN，即，采用VRF-to-VRF方式管理VPN路由。

4.  同一个AS内部的MPLS骨干网使用OSPF作为IGP。

## 实验步骤：

1.  在MPLS骨干网上配置IGP协议，实现骨干网内互通

2.  在MPLS骨干网上配置MPLS基本能力和MPLS LDP，建立LDP LSP

3.  在PE设备上配置VPN实例，将CE接入PE

4.  在PE与CE之间建立EBGP对等体，引入VPN路由

5.   PE与本AS的ASBR-PE之间建立MP-IBGP对等体，ASBR-PE之间建立EBGP对等体

## 测试结果：

1、ASBR-PE与本AS的PE之间应能建立OSPF邻居

![](./Media//image1.png)


![](./Media//image2.png)


2、同一AS的PE和ASBR-PE之间应该建立起LDP邻居，LDP会话状态为"Operational"

![](./Media//image3.png)


![](./Media//image4.png)


 3、 PE与本AS的ASBR-PE之间建立MP-IBGP对等体

![](./Media//image5.png)


![](./Media//image6.png)


4、ASBR-PE之间建立EBGP对等体

![](./Media//image7.png)


![](./Media//image8.png)


5、 PE与CE之间建立EBGP对等体

![](./Media//image9.png)


![](./Media//image10.png)


6.  CE之间能学习到对方的接口路由，CE 1和CE 2能够相互ping通

![](./Media//image11.png)


![](./Media//image12.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
