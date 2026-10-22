# OSPFv3发布ASBR聚合路由配置举例

## 需求：

1.  Router A、Router B和Router C位于Area 2内；

2.  Router B上运行两个OSPFv3进程：1和2。Router B通过进程1和Router
    A交换路由信息，通过进程2和Router C交换路由信息；

3.  在Router
    A的接口GigabitEthernet1/0/1上配置地址2:1:1::1/64、2:1:2::1/64、2:1:3::1/64，并在Router
    B上配置OSPFv3进程2引入直连路由和OSPFv3进程1的路由，使得Router
    C能够学习到达2::/64、2:1:1::/64、2:1:2::/64、2:1:3::/64的路由；

4.  为了减小Router C的路由表规模，在Router
    B上配置ASBR聚合路由，只发布聚合后的路由2::/16。

## 实验步骤：

1.  配置各接口的IPv6地址

2.  配置OSPFv3基本功能

3.  配置OSPFv3引入外部路由

4.  配置OSPFv3发布ASBR聚合路由

\[RouterB\] ospfv3 2

\[RouterB-ospfv3-2\] asbr-summary 2:: 16

## 测试结果：

未配置聚合前，Router-C上的IPv6路由：

![](./Media//image2.png)


在Router B上配置OSPFv3进程2发布ASBR聚合路由2::/16。

查看路由聚合后Router C的路由表信息。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
