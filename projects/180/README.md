# 通过将物理接口直接绑定到VT接口方式进行MP捆绑配置举例

## 需求：

设备Router A和Router
B的Serial1/0和Serial2/0分别对应连接。要求通过将物理接口直接绑定到VT接口方式进行MP捆绑。

## 实验步骤：

1、创建虚拟模板接口，配置相应的IP地址。

2、将串口与虚拟模版关联。

## 测试结果：

在Router A上查看绑定结果

查看MP的相关信息。

![](./Media//image1.png)


查看VA状态。

![](./Media//image2.png)


在Router B上ping对端IP地址8.1.1.1

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
