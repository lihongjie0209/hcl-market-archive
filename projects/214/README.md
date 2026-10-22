# 通过按用户名找VT方式进行MP捆绑配置举例

## 需求：

设备Router A和Router
B的Serial1/0和Serial2/0分别对应连接。要求通过按用户名找VT方式进行MP捆绑。

## 实验步骤：

1、配置对端设备的用户名和密码，并指定用户对应的VT。

2、创建VT，配置相应的IP地址。

3、串口配置验证。

## 测试结果：

在Router A上查看绑定结果

查看MP的相关信息。

![](./Media//image1.png)


查看VA状态。

由于PPP绑定了不同的用户名，故生成两个VA口。

\#

ppp mp user usera bind Virtual-Template 1

ppp mp user userb bind Virtual-Template 1

\#

![](./Media//image2.png)


在Router B上ping对端IP地址8.1.1.1

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
