# 工程名称
Vlan-interface实现VLAN间路由


## 需求：
设备上配置vlan-interface接口，实现VLAN间通信。
注：真机需要添加二层接口卡或者使用原生二层接口。

## 实验步骤：
组网：

![1](./Media/图片1.png) 


配置：
1. AC上的配置vlan 100和200，分别在int-vlan接口添加IP地址；
2. AC接PC1和PC2的接口分别配置为access vlan 100和200；
3. PC1和PC2分别使用vlan 100和200的IP地址，网关都在AC上；



## 测试结果：
PC1和PC2可以跨三层互相访问。

![2](./Media/图片2.png) 


## 说明： 
注：真机需要添加二层接口卡或者使用原生二层接口。

