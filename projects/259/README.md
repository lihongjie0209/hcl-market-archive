# 配置MPLS跨域VPN-OptionC方式示例

## 需求：

1.  Site 1和Site 2属于同一个VPN，Site 1通过AS 100的PE 1接入，Site
    2通过AS 600的PE 2接入；

2.  同一自治系统内的PE设备之间运行IS-IS作为IGP；

3.  PE 1与ASBR-PE 1间通过IBGP交换标签IPv4路由；

4.  PE 2与ASBR-PE 2间通过IBGP交换标签IPv4路由；

5.  PE 1与PE 2建立MP-EBGP对等体交换VPNv4路由；

6.  ASBR-PE 1和ASBR-PE 2上分别配置路由策略，对从对方接收的路由压入标签；

7.  ASBR-PE 1与ASBR-PE 2间通过EBGP交换标签IPv4路由。

## 实验步骤：

1.  在MPLS骨干网上配置IGP协议，实现骨干网PE和P的互通

2.  在MPLS骨干网上配置MPLS基本能力和MPLS LDP，建立LDP LSP

3.  在PE设备上配置VPN实例，将CE接入PE

4.  在PE与CE之间建立EBGP对等体，引入VPN路由

5.  在PE之间建立多跳MP-EBGP对等体

6.  PE 与ASBR-PE
    之间通过IBGP交换标签IPv4路由，ASBR-PE之间通过EBGP交换标签IPv4路由。

## 测试结果：

配置完成后，在CE 1和CE 2上执行display ip
routing-table命令可以查看到到达对方的路由，且CE 1和CE 2互相可以ping通。

![](./Media//image1.png)


在PE上查看，对端PE的环回口地址都是带标签的。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
