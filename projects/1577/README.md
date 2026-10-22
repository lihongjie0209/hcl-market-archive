# VRRP负载均衡模式配置举例

## 需求：

Router A、Router B和Router C属于虚拟IP地址为10.1.1.1/24的备份组1；

10.1.1.0/24网段内主机的缺省网关为10.1.1.1/24，利用VRRP备份组保证某台网关设备（Router
A、Router B或Router
C）出现故障时，局域网内的主机仍然可以通过网关访问外部网络；

备份组1工作在负载均衡模式，通过一个备份组实现负载分担，充分利用网关资源；

在Router A、Router B和Router
C上分别配置虚拟转发器通过Track项监视上行接口GigabitEthernet0/0的状态。当上行接口出现故障时，降低Router
A、Router B或Router C上虚拟转发器的权重，以便其它设备接管它的转发任务。

## 实验步骤：

1.  配置各接口的IP地址。

2.  配置VRRP工作在负载均衡模式，以RTA为例。

\#

track 1 interface GigabitEthernet0/0

\#

vrrp mode load-balance

\#

interface GigabitEthernet0/1

ip address 10.1.1.2 255.255.255.0

vrrp vrid 1 virtual-ip 10.1.1.1

vrrp vrid 1 priority 120

vrrp vrid 1 preempt-mode delay 5000

vrrp vrid 1 track 1 weight reduced 250

\#

## 测试结果：

通过display vrrp verbose命令查看配置后的结果。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
