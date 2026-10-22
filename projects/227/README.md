# HDLC链路捆绑基本组网配置举例

## 需求：

为了增加Router A和Router
B之间的链路带宽，并提高连接可靠性，在设备之间建立HDLC捆绑逻辑链路。

## 实验步骤：

1、创建HDLC捆绑接口1，并配置IP地址。

2、将Serial1/0、Serial2/0加入到HDLC捆绑1。

## 测试结果：

配置完成后，Router A和Router B的HDLC捆绑接口能够互相Ping通。

![](./Media//image1.png)


在Router A或Router B上执行display bundle
hdlc-bundle命令，可以看到HDLC捆绑接口1的捆绑信息。以Router A的显示为例。

![](./Media//image2.png)


上述信息表明，Serial1/0和Serial2/0都处于选中状态，可以进行流量的负载分担；HDLC捆绑的带宽为128
kbps，是两个Serial接口的带宽之和；当其中一个Serial接口出现故障时，流量可以通过另一个Serial接口发送，提高了链路的连接可靠性。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
