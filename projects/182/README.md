# PPPoE Server通过本地DHCP服务器为用户分配IP地址配置举例

## 需求：

要求以太网内的主机可以通过PPPoE接入Router，并连接到外部网络。

-   主机作为PPPoE Client，运行PPPoE客户端拨号软件。

-   Router作为PPPoE
    Server，配置本地PAP认证，并通过DHCPv4协议为终端分配IP地址。

## 实验步骤：

1、创建一个PPPoE用户。

2、配置虚拟模板接口的参数，采用PAP认证对端，使用DHCP地址池pool1为用户分配IP地址及DNS服务器地址。

3、在接口GigabitEthernet0/0上启用PPPoE
Server协议，并将该接口与虚拟模板接口绑定。

## 测试结果：

以太网上主机使用PPPoE协议，配置用户名和密码（此处为user1和123456TESTplat&!），通过设备Router接入到Internet。

PPPoEServer通过DHCPv4协议为终端分配一个IP地址。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
