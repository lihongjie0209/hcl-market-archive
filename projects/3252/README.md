# IS-IS与BFD联动配置举例

## 需求：

Switch A、Switch B和Switch C上运行IS-IS，网络层相互可达。当Switch
A和Switch B通过L2
Switch通信的链路出现故障时BFD能够快速感知通告IS-IS协议，并且切换到Switch
C进行通信。

##  实验步骤：

1.  配置各交换机之间采用IS-IS协议进行互连，确保Switch A、Switch
    B和Switch
    C之间能够在网络层互通，并且各交换机之间能够借助IS-IS协议实现动态路由更新；

2.  在Switch A、Switch B上配置BFD检测；

3.  查看Switch A上到Switch B上L0地址的路由信息，测试L2
    Switch故障时Switch A到Switch B之间链路是否能够快速切换到Switch
    C进行通信。

## 测试结果：

面以Switch A为例，Switch B和Switch A类似，不再赘述。

\# 显示Switch A的BFD信息。

![](./Media//image1.png)


\# 在Switch A上查看120.1.1.1/32的路由信息，可以看出Switch A和Switch
B是通过L2 Switch进行通信的（设备STP均已关闭）

![](./Media//image2.png)


当Switch A和Switch B通过L2 Switch通信的链路出现故障时：

\# 在Switch A上查看120.1.1.1/32的路由信息，可以看出Switch A和Switch
B已经切换到Switch C进行通信。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
