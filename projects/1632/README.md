# BGP MD5认证

**标签：**

**BGP**

## 需求

通过为BGP对等体配置BGP的MD5认证，可以在以下两方面提高BGP的安全性：

·为BGP建立TCP连接时进行MD5认证，只有两台路由器配置的密钥相同时，才能建立TCP连接，

从而避免与非法的BGP路由器建立TCP连接。

·传递BGP报文时，对封装BGP报文的TCP报文段进行MD5运算，从而保证BGP报文不会被篡改。

## 实验步骤：

1、配置各接口的IP地址

2、配置BGP与MD5验证

\#

bgp 100

peer 10.1.1.2 as-number 100

peer 10.1.1.2 password cipher \$c\$3\$k8L93BE5fcCg3IG9Z5cZ4SHI/PCvuA==

\#

address-family ipv4 unicast

network 1.1.1.1 255.255.255.255

peer 10.1.1.2 enable

\#

## 测试结果：

抓包看，BGP建邻居的TCP报文会携带MD5选项，只有认证过才能建立邻居。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
