# OSPF发布聚合路由配置举例

## 需求：

1.  Router A和Router B位于AS200内，AS200内使用OSPF作为IGP协议。

2.  Router C、Router D和Router
    E位于AS100内，AS100内使用OSPF作为IGP协议。

3.  Router B和Router
    C之间建立EBGP连接，配置BGP引入OSPF和直连路由，配置OSPF进程引入BGP路由。

4.  为了减小Router A的路由表规模，在Router
    B上配置路由聚合，只发布聚合后的路由10.0.0.0/8。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置OSPF基本功能

3.  对OSPF路由进行聚合

## 测试结果：

聚合前含有4条10网段的表项。

![](./Media//image2.png)


在Router B上配置聚合：

\#

ospf 1

asbr-summary 10.0.0.0 255.0.0.0

\#

查看Router A的路由表信息。

![](./Media//image3.png)


可以看出，路由10.1.1.0/24、10.2.1.0/24、10.3.1.0/24、10.4.1.0/24已经聚合为一条路由10.0.0.0/8。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
