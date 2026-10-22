# IS-IS验证配置举例

## 需求：

Router A、Router B、Router C和Router
D属于同一路由域，要求它们之间通过IS-IS协议达到IP网络互连的目的。

其中，Router A、Router B和Router C属于同一个区域，区域号为10，Router
D属于另外一个区域，区域号为20。

在区域10内配置区域验证，防止不可信任的路由信息加入到区域10的LSDB中；在Router
C和Router
D上配置路由域验证，防止将不可信的路由信息注入当前路由域；分别在Router
A、Router B、Router C和Router D上配置邻居关系验证。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置ISIS基本功能

3.  配置ISIS验证

> 参考示例：
>
> 接口验证配置：
>
> \[RouterA\] interface gigabitethernet 0/0
>
> \[RouterA-GigabitEthernet1/0/1\] isis authentication-mode md5 plain
> eRg
>
> 区域验证配置：
>
> \[RouterA\] isis 1
>
> \[RouterA-isis-1\] area-authentication-mode md5 plain 10Sec
>
> 路由域验证配置：
>
> \[RouterC\] isis 1
>
> \[RouterC-isis-1\] domain-authentication-mode md5 plain 1020Sec

## 测试结果：

显示Router C的IS-IS lsdb详细信息。

![](./Media//image2.png)


可见采用了MD5的验证方式。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
