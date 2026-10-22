# DHCP中继支持Option 82配置举例

## 需求：

-   在DHCP中继Router A上开启Option 82功能；

-   对包含Option 82的请求报文的处理策略为replace；

-   Circuit ID填充内容为company001，Remote ID填充内容为device001；

-   Router A将添加Option 82的DHCP请求报文转发给DHCP服务器Router
    B，使得DHCP客户端可以获取到IP地址。

## 实验步骤：

1、配置DHCP Server

2、配置DHCP Relay

## 测试结果：

配置完成后，PC可以获取地址。在DHCP Relay和DHCP
Server之间抓包可以看到dhcp报文携带了option82字段。

![](./Media//image1.png)


![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
