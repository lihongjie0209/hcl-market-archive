# IPv6 IS-IS基本组网配置举例

## 需求：

Switch A、Switch B、Switch C和Switch
D属于同一自治系统，所有交换机已使能了IPv6能力，要求它们之间通过IPv6
IS-IS协议达到IPv6网络互连的目的。

##  实验步骤：

1.  配置Switch A和Switch B为Level-1交换机，Switch
    D为Level-2交换机，Switch C为Level-1-2交换机；

2.  Switch A、Switch B和Switch C的区域号为10，Switch D的区域号为20

## 测试结果：

\# 查看Switch A的IPv6 IS-IS路由表。

![](./Media//image1.png)


\# 查看Switch B的IPv6 IS-IS路由表。

![](./Media//image2.png)


\# 查看Switch C的IPv6 IS-IS路由表。

![](./Media//image3.png)


\# 查看Switch D的IPv6 IS-IS路由表。

![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
