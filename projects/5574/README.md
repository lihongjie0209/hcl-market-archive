# 工程名称

IPv6基本组网配置举例



## 需求：
构建IPv6网络，SWA交换机作为DHCPv6服务器，AP向其申请IPv6地址后注册到AC上，终端上线获取IPv6地址。


## 实验步骤：
【组网图】

![1](./Media/图片1.png) 

1. 在L3交换机上配置DHCPv6 server服务，使AP、无线客户端Client和有线客户端Host都能通过DHCPv6 server自动获取IPv6地址。

2. 在L3交换机和AC上配置到达对端网段的静态路由。

3. 在AC上配置无线服务，确保Client可以通过配置的无线服务接入网络，并访问Host。



## 测试结果：
1. 两台AP可以正常从SWA交换机的DHCPv6地址池获取地址，且在AC注册上线：

![2](./Media/图片2.png) 

2. 目前HCL软件的终端暂不支持IPv6地址获取，但终端可以正常在AC上线：

![3](./Media/图片3.png) 



## 说明： 


