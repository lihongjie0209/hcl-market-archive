# BGP联盟配置

## 需求：

AS
200中有多台BGP路由器，为了减少IBGP的连接数，现将他们划分为3个子自治系统：AS
65001、AS 65002和AS 65003。其中AS 65001内的三台路由器建立IBGP全连接。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置BGP联盟

## 测试结果：

查看Router B的BGP路由表。Router C的BGP路由表与此类似。

![](./Media//image1.png)


![](./Media//image2.png)


查看Router D的BGP路由表。

![](./Media//image3.png)


通过以上显示信息可以看出：

1.  Router F只需要和Router A建立EBGP连接，而不需要和Router B、Router
    C建立连接，同样可以通过联盟将路由信息传递给Router B和Router C。

2.  Router B和Router
    D在同一个联盟里，但是属于不同的子自治系统，它们都是通过Router
    A来获取外部路由信息，生成的BGP路由表项也是一致的，等效于在同一个自治系统内，但是又不需要物理上全连接。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
