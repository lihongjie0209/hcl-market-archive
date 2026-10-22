## VPLS-LDP方式配置举例交换机

标签：

VPLS、LDP

#### 1. 组网需求

•     CE 1、CE 2和CE 3分属于3个站点，同属于VPN 1；

•   站点1、站点2和站点3通过以太网接口的方式接入PE 1、PE 2和PE 3；

•     在各个PE上配置VPLS，使得PE之间采用LDP信令协议建立PW，通过PW连接各个CE。

#### 2. 组网图

图1-4 LDP方式VPLS组网图

![](./Media//image1.png)


‌

#### 3. 配置步骤

#### (1) 配置PE 1，PE2，PE3，配置LSR ID， 开启L2VPN功能，全局使能LDP， 配置各PE设备的互联接口，在此接口上使能LDP。

#### （2）在PE上运行OSPF，用于建立LSP。

#### （3）配置VSI实例采用LDP信令协议，并在PE 1和PE 2、PE 2和PE 3之间建立PW。

#### （4）将各PE上与CE互联接口与VSI实例关联。

#### 4. 验证配置

\# 在PE 1上执行display l2vpn pw
verbose命令，可以看到建立了两条PW，状态为up。![](./Media//image2.png)


#不同PE下终端之间能互相ping通

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850、S5820V2、MSR3620，设置内存为默认。

2、本实验用的交换机、路由器版本为默认版本。
