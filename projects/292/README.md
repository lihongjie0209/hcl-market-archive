# IRF典型配置举例

## 需求：

配置Device A、Device B组成IRF设备。配置BFD MAD进行分裂检测。

##  实验步骤：

1.  配置IRF系统编号

2.  配置IRF物理端口

3.  配置IRF系统优先级

## 测试结果：

查看irf系统，可以看到系统已经正常建立

![](./Media//image1.png)


查看mad状态为normal，mad功能生效

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
