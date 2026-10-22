# IS-IS引入外部路由配置举例

## 需求：

Router A、Router B、Router C和Router
D属于同一自治系统，要求它们之间通过IS-IS协议达到IP网络互连的目的。

1.  Router A和Router B为Level-1路由器，Router D为Level-2路由器，Router
    C作为Level-1-2路由器将两个区域相连。Router A、Router B和Router
    C的区域号为10，Router D的区域号为20。

2.  在Router D的IS-IS进程中引入RIP路由。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置ISIS基本功能

3.  配置RIP协议

4.  ISIS引入RIP路由

## 测试结果：

显示Router C的IS-IS路由信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
