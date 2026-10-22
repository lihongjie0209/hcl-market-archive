# IS-IS快速重路由配置举例（交换机）

## 需求：

Switch A、Switch B和Switch
C属于同一IS-IS路由域，通过IS-IS协议实现网络互连。要求当Switch A和Switch
B之间的链路出现故障时，业务可以快速切换到链路B上。

##  实验步骤：

1.  配置各交换机之间采用IS-IS协议进行互连，确保Switch A、Switch
    B和Switch
    C之间能够在网络层互通，并且各交换机之间能够借助IS-IS协议实现动态路由更新；

2.  在Switch A、Switch B通过LFA（Loop Free
    Alternate）算法选取备份下一跳；

3.  在Switch A、Switch B上L0长ping互访，测试端口Switch A和Switch
    B之间链路确认是否能够快速收敛。

## 测试结果：

\# 在Switch A上查看4.4.4.4/32路由，可以看到备份下一跳信息。

![](./Media//image1.png)


\# 在Switch B带源长ping Switch A的L0地址，测试断开、恢复Link
A时均不未出现丢包（设备STP均已关闭）

![](./Media//image2.png)


![](./Media//image3.png)


![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
