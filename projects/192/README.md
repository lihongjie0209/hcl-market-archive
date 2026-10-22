# OSPF引入自治系统外部路由配置举例

## 需求：

1.  所有的路由器都运行OSPF，并将整个自治系统划分为3个区域。

2.  其中Router A和Router B作为ABR来转发区域之间的路由。

3.  在Router
    C上配置为ASBR引入外部路由（静态路由），且路由信息可正确的在AS内传播。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置OSPF基本功能

3.  配置引入自治系统外部路由

> \#
>
> ip route-static 3.1.2.0 24 NULL0
>
> \#
>
> ospf 1
>
> import-route static
>
> area 0.0.0.1
>
> network 10.2.1.0 0.0.0.255
>
> network 10.4.1.0 0.0.0.255
>
> \#

## 测试结果：

查看Router D的ABR/ASBR信息。

![](./Media//image1.png)


查看Router D的OSPF路由信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
