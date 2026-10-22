# 配置MPLS跨域VPN-OptionA方式示例

## 需求：

1.  CE 1和CE 2属于同一个VPN。

2.  CE 1通过AS 100的PE 1接入，CE 2通过AS 200的PE 2接入。

3.  采用OptionA方式实现跨域的MPLS
    L3VPN，即，采用VRF-to-VRF方式管理VPN路由。

4.  同一个AS内部的MPLS骨干网使用OSPF作为IGP。

## 实验步骤：

1.  在MPLS骨干网上配置IGP协议，实现骨干网PE和P的互通

2.  在MPLS骨干网上配置MPLS基本能力和MPLS LDP，建立LDP LSP

3.  在PE设备上配置VPN实例，将CE接入PE

4.  在PE与CE之间建立EBGP对等体，引入VPN路由

5.  PE与本AS的ASBR-PE之间建立MP-IBGP对等体，ASBR-PE之间建立EBGP对等体

## 测试结果：

上述配置完成后，CE之间能学习到对方的接口路由，CE 1和CE 2能够相互ping通。

![](./Media//image1.png)


在PE上查看，VPN路由带两层标签

![](./Media//image2.png)


在ASBR上查看，纯IP转发

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
