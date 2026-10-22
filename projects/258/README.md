# 配置MPLS跨域VPN-OptionB方式示例

## 需求：

1.  Site 1和Site 2属于同一个VPN，Site 1的CE 1通过AS 100的PE 1接入，Site
    2的CE 2通过AS 600的PE 2接入；

2.  同一自治系统内的PE设备之间运行IS-IS作为IGP；

3.  PE 1与ASBR-PE 1间通过MP-IBGP交换VPNv4路由；

4.  PE 2与ASBR-PE 2间通过MP-IBGP交换VPNv4路由；

5.  ASBR-PE 1与ASBR-PE 2间通过MP-EBGP交换VPNv4路由；

6.  ASBR上不对接收的VPNv4路由进行Route Target过滤。

## 实验步骤：

1.  在MPLS骨干网上配置IGP协议，实现骨干网PE和P的互通

2.  在MPLS骨干网上配置MPLS基本能力和MPLS LDP，建立LDP LSP

3.  在PE设备上配置VPN实例，将CE接入PE

4.  在PE与CE之间建立EBGP对等体，引入VPN路由

5.  PE与本AS的ASBR-PE之间建立MP-IBGP对等体，ASBR-PE之间建立MP-EBGP对等体

## 测试结果：

配置完成后，CE1与CE2可以互访。

![](./Media//image1.png)


在PE1上可以看到VPN路由带两层标签，内层标签为24256，由3.3.3.9即ASBR-PE1分配。

![](./Media//image2.png)


在ASBR-PE1上查看，收到的路由的BGP标签为24256。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
