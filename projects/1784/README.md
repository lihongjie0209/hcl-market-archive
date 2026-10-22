# DHCPv6 Snooping典型配置举例

## 需求：

Switch2通过以太网端口GE1/0/1连接到合法DHCPv6服务器，通过以太网端口GE1/0/3连接到非法服务器，通过GE1/0/2连接到DHCPv6客户端。要求：

-   与合法DHCPv6服务器相连的端口可以转发DHCPv6服务器的响应报文，而其他端口不转发DHCPv6服务器的响应报文。

-   记录DHCPv6客户端IPv6地址及MAC地址的绑定关系。

##  实验步骤：

1.  在Switch 1 上开启DHCPv6
    Snooping功能，配置GE1/0/1端口为信任端口，在GE1/0/2上开启安全表项功能；

2.  在Switch
    2配置DHCPv6服务器， 配置VLAN接口2的IPv6地址。取消设备发布RA消息的抑制。配置被管理地址的配置标志位为1，即主机通过DHCPv6服务器获取IPv6地址。配置其他信息配置标志位为1，即主机通过DHCPv6服务器获取除IPv6地址以外的其他信息

3.  在Client上配置根据DHCPv6自动获取地址。

## 测试结果：

 查看DHCPv6服务器给Client分配的地址信息：

![](./Media//image1.png)


查看生成的DHCPv6 Snooping表项：

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
