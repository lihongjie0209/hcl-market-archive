# 静态路由快速重路由配置举例

## 需求：

Router A、Router B和Router C通过静态路由实现网络互连。要求当Router
A和Router B之间的链路A出现单通故障时，业务可以快速切换到链路B上。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置静态路由快速重路由

Router A、Router B设备配置类似，以Router A为例：

方法一：配置静态路由快速重路由功能（手工指定备份下一跳）

ip route-static 4.4.4.4 32 gigabitethernet 0/1 13.13.13.2
backup-interface gigabitethernet 0/0 backup-nexthop 12.12.12.2

方法二：配置静态路由快速重路由功能（自动查找备份下一跳）

ip route-static 4.4.4.4 32 gigabitethernet 0/1 13.13.13.2

ip route-static 4.4.4.4 32 gigabitethernet 0/0 12.12.12.1 preference 70

ip route-static fast-reroute auto

## 测试结果：

下面以Router A为例，Router B和Router A类似，不再赘述。

在Router A上查看4.4.4.4/32路由，可以看到备份下一跳信息。

![](./Media//image1.png)


在Router B上查看1.1.1.1/32路由，可以看到备份下一跳信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
