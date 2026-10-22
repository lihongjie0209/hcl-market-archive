## BGP自动发现LDP信令方式VPLS配置举例交换机

标签：

VPLS、BGP

#### 1. 组网需求

•     CE 1、CE 2和CE 3分属于3个站点，同属于VPN 1；

•   站点1、站点2和站点3通过以太网接口的方式接入PE 1、PE 2和PE 3；

•     在各个PE上配置VPLS，使得PE之间采用BGP协议自动发现邻居、采用LDP信令协议建立PW，通过PW连接各个CE。

#### 2. 组网图

图2-1 BGP自动发现LDP信令方式VPLS组网图

![](./Media//image1.png)


‌

#### 3. 配置步骤

#### (1) 配置IGP协议、公网隧道。

#### （2）配置PE设备、P设备MPLS基本能力，在PE 1和PE 2、PE 1和PE 3之间建立IBGP连接，并配置通过BGP发布VPLS PE信息。PE设备开启L2VPN功能。

#### （3）配置VSI实例采用BGP协议自动发现邻居，并采用LDP信令协议在各PE之间建立PW。

#### （4）将各PE上与CE互联接口与VSI实例关联。

#### 4. 验证配置

\# 在PE 1上执行display l2vpn pw
verbose命令，可以看到建立了两条PW，状态为up。![](./Media//image2.png)


#不同PE下终端之间能互相ping通

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850、S5820V2、MSR3620，设置内存为默认。

2、本实验用的交换机、路由器版本为默认版本。
