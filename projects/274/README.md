# IPv4 Internet访问IPv6网络内部服务器配置举例

## 需求：

某公司将网络升级到了IPv6，此时Internet仍然是IPv4网络。该公司希望内部的FTP服务器能够继续为IPv4
Internet的用户提供服务。该公司拥有的IPv4地址为10.1.1.1。

为满足上述要求，本例实现方式如下：

·使用IPv6侧服务器配置将IPv6内部服务器的地址及端口映射为IPv4地址及端口，Router收到来自IPv4
Internet的报文后，根据该配置策略将报文IPv4目的地址转换为IPv6地址；

·使用NAT64前缀将报文源IPv4地址转换为IPv6地址。

## 实验步骤：

配置NAT设备

![](./Media//image1.emf)

## 测试结果：

1.  以上配置完成后，IPv4 Host可以通过FTP协议访问IPv6 FTP Server。

![](./Media//image2.png)


2、
通过查看AFT会话，可以看到创建了一个IPv4会话和IPv6会话，分别对应转换前和转换后的报文。

![](./Media//image3.png)


![](./Media//image4.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
