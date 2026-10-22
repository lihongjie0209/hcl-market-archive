# PPPoE Server通过远端DHCP服务器为用户分配IP地址配置举例

## 需求：

要求以太网内的主机可以通过PPPoE接入Router，并连接到外部网络。

-   主机作为PPPoE Client，运行PPPoE客户端拨号软件。

-   Router作为PPPoE
    Server，配置本地PAP认证，DHCP中继向远端DHCP服务器申请IP地址。

## 实验步骤：

1、创建一个PPPoE用户。

2、配置虚拟模板接口的参数，采用PAP认证对端。

3、创建中继地址池，指定匹配该地址池的DHCPv4客户端所在的网段地址，并指定中继地址池对应的DHCP服务器地址。

4、在接口GigabitEthernet0/0上启用PPPoE
Server协议，并将该接口与虚拟模板接口绑定。

## 测试结果：

以太网上主机使用PPPoE协议，配置用户名和密码（此处为user1和123456TESTplat&!），通过设备Router接入到Internet。

PPPoEServer通过DHCPv4协议为终端分配一个IP地址。

![](./Media//image1.png)


显示DHCP服务器的DHCP地址绑定信息。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
