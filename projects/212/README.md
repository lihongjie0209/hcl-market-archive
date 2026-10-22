# 三层动态聚合配置举例

## 需求：

-   Device A与Device
    B通过各自的三层以太网接口GigabitEthernet0/0～GigabitEthernet0/1相互连接。

-   在Device A和Device
    B上分别配置三层动态链路聚合组，并为对应的三层聚合接口配置IP地址和子网掩码。

## 实验步骤：

1、创建三层聚合接口1，配置该接口为动态聚合模式，并为其配置IP地址和子网掩码。

2、将接口GigabitEthernet0/0、GigabitEthernet0/1加入到聚合组1中。

## 测试结果：

查看Device A上所有聚合组的详细信息。

![](./Media//image1.png)


以上信息表明，聚合组1为负载分担类型的三层动态聚合组，包含有两个选中端口。

## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
