# OSPF虚连接配置举例

## 需求：

1.  Area2没有与Area0直接相连。Area1被用作传输区域（Transit
    Area）来连接Area2和Area0。Router B和Router C之间配置一条虚连接。

2.  配置完成后，Router B能够学到Area2中的路由。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置OSPF基本功能

3.  创建虚连接

> \#
>
> ospf 1 router-id 2.2.2.2
>
> area 0.0.0.0
>
> network 2.2.2.2 0.0.0.0
>
> network 10.1.1.0 0.0.0.255
>
> area 0.0.0.1
>
> network 10.2.1.0 0.0.0.255
>
> vlink-peer 3.3.3.3
>
> \#

## 测试结果：

查看vlink状态已经处于full状态。

![](./Media//image2.png)


查看Router B的OSPF路由表，已经学到了Area2的路由10.3.1.0/24。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
