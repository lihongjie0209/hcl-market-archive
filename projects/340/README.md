# 静态路由、Track与NQA联动配置举例

## 需求：

Switch A、Switch B、Switch C和Switch
D连接了20.1.1.0/24和30.1.1.0/24两个网段，在交换机上配置静态路由以实现两个网段的互通，并配置路由备份。

Switch A上存在两条到达30.1.1.0/24网段的静态路由，下一跳分别为Switch
B和Switch C。这两条静态路由形成备份，其中：

•下一跳为Switch B的静态路由优先级高，作为主路由。该路由可达时，Switch
A通过Switch B将报文转发到30.1.1.0/24网段。

•下一跳为Switch C的静态路作为备份路由。

•在Switch
A上通过静态路由、Track与NQA联动，实时判断主路由是否可达。当主路由不可达时，备份路由生效，Switch
A通过Switch C将报文转发到30.1.1.0/24网段。

##  实验步骤：

1.  在交换机上配置路由协议，使得各交换机的接口IP地址之间路由可达；

2.  配置静态路由并与track关联。

## 测试结果：

在Switch
A查看如下信息可知NQA测试的结果为主路由可达（Track项状态为Positive），Switch
A通过Switch B将报文转发到30.1.1.0/24网段。

![](./Media//image1.png)


![](./Media//image2.png)


在Switch B上删除VLAN接口2的IP地址，查看Switch
A上Track项的信息、路由信息发现NQA测试的结果为主路由不可达（Track项状态为Negative），则备份路由生效，Switch
A通过Switch C将报文转发到30.1.1.0/24网段。

![](./Media//image3.png)


![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
