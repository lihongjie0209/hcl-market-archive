# 静态路由与BFD联动（非直连）配置举例

## 需求：

1.  在Router A上配置静态路由可以到达120.1.1.0/24网段，在Router
    B上配置静态路由可以到达121.1.1.0/24网段，并使能BFD检测功能。

2.  在Router C和Router
    D上配置静态路由可以到达120.1.1.0/24网段和121.1.1.0/24网段。

3.  Router A存在到Router
    B的接口Loopback1（2.2.2.9/32）的路由，出接口为GigabitEthernet0/0；Router
    B存在到Router
    A的接口Loopback1（1.1.1.9/32）的路由，出接口为GigabitEthernet0/0；Router
    D存在到1.1.1.9/32的路由，出接口为GigabitEthernet0/0，存在到2.2.2.9/32的路由，出接口为GigabitEthernet0/1。

4.  当Router A和Router B通过Router
    D通信的链路出现故障时，BFD能够快速感知，并且切换到Router C进行通信。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置静态路由和BFD

Router A、Router B设备配置类似，以Router A为例：

\#

bfd multi-hop min-transmit-interval 500

bfd multi-hop min-receive-interval 500

bfd multi-hop detect-multiplier 9

\#

interface LoopBack1

ip address 1.1.1.9 255.255.255.255

\#

interface GigabitEthernet0/0

port link-mode route

combo enable copper

ip address 12.1.1.1 255.255.255.0

\#

interface GigabitEthernet0/1

port link-mode route

combo enable copper

ip address 10.1.1.1 255.255.255.0

\#

ip route-static 2.2.2.9 32 12.1.1.2

ip route-static 120.1.1.0 24 2.2.2.9 bfd control-packet bfd-source
1.1.1.9

ip route-static 120.1.1.0 24 GigabitEthernet0/1 10.1.1.2 preference 65

\#

## 测试结果：

下面以Router A为例，Router B和Router A类似，不再赘述。

查看BFD会话，可以看到BFD会话已经创建。

![](./Media//image1.png)


查看静态路由，可以看到Router A经过Router D到达Router B。

![](./Media//image2.png)


当Router A和Router B通过Router D通信的链路出现故障时：

查看静态路由，可以看到Router A经过Router C到达Router B。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
