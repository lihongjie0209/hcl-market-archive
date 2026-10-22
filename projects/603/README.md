# DRNI基本功能配置举例

## 需求：

用户对于业务的可靠性要求很高，如果Device C和接入设备（Device A和Device
B）之间配置链路聚合只能保证链路级的可靠性，接入设备发生故障时则会导致业务中断。这时可以采用DRNI技术，正常工作时链路进行负载分担且任何一台设备故障对业务均没有影响，保证业务的高可靠性。

##  实验步骤：

1.  配置DRNI系统参数

2.  配置Keepalive报文源目ip

3.  配置drni保留接口

4.  配置IPP口

5.  配置DR口

## 测试结果：

查看查看Device A上分布式聚合的Keepalive报文信息，表明Device A和Device
B设备间无故障

![](./Media//image1.png)


查看Device A上IPP口和DR口的摘要信息和详细信息，表明Device A和Device
B成功组成分布式聚合系统

![](./Media//image2.png)


查看Device C上聚合组4的详细信息，可以看出Device
C的端口均处于选中状态，此时Device
C将DeviceA和DeviceB认为是一台设备，从而实现了跨设备的聚合

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
