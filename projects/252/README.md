# VPLS的Hub-spoke组网配置举例

## 需求：

为了便于对各个站点的流量进行集中管理，VPLS采用Hub-spoke组网方式，采用的信令协议为LDP。

## 实验步骤：

1.  在MPLS骨干网上配置IGP协议，实现骨干网PE和P的互通

2.  在MPLS骨干网上配置MPLS基本能力和MPLS LDP，建立LDP LSP

3.  创建虚拟交换实例，并配置远端PE，

4.  内网接口与虚拟交换实例关联。

5.  Hub-CE开启本地ARP代理。

## 测试结果：

完成上述配置后，在各个PE上执行display l2vpn pw
verbose命令，可以看到建立了PW连接，且状态为up。

以Hub-PE为例。

![](./Media//image1.png)


在Hub-CE上开启debug ip packet，当Spoke CE互访时，流量会进过Hub-CE。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为B59版本，需要HCL登录后切换版本。

![](./Media//image3.png)

