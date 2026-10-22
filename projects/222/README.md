# PPPoE Client按需拨号模式配置举例

## 需求：

Router A和Router B之间通过各自的GigabitEthernet0/0接口相连，其中Router
A作为PPPoE Server，Router B作为PPPoE
Client工作在按需模式，空闲时间间隔为150秒。

## 实验步骤：

1、配置Router A作为PPPoE Server

2、配置Router B作为PPPoE Client

## 测试结果：

配置完成后，Router B就可以与远端的PPPoE Server建立PPPoE会话。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
