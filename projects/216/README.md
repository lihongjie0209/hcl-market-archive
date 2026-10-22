# PPPoE Server通过PPP地址池为用户分配IPv4地址配置举例

## 需求：

要求以太网内的主机可以通过PPPoE接入Router，并连接到外部网络。

-   主机作为PPPoE Client，运行PPPoE客户端拨号软件。

-   Router作为PPPoE
    Server，配置本地CHAP认证，并通过PPP地址池为主机分配IP地址。

## 实验步骤：

1、创建一个PPPoE用户。

2、配置虚拟模板，采用CHAP认证对端，并使用PPP地址池为对端分配IP地址，并配置为对端指定DNS服务器的IP地址。

3、在接口GigabitEthernet0/0上启用PPPoE
Server协议，并将该接口与虚拟模板接口绑定。

4、在系统缺省的ISP域system下，配置域用户使用本地认证方案。

## 测试结果：

以太网上主机使用PPPoE协议，配置用户名和密码（此处为user1和123456TESTplat&!），通过设备Router接入到Internet。

PPPoEClient已经获取地址：

![](./Media//image1.png)


获取的DNS地址为8.8.8.8：

![](./Media//image2.png)


测试可以访问外网：

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
