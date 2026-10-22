# 工程名称

1:1 VLAN映射配置举例 

## 需求：

网络中从SWB过来的的业务流需要在SWB上进行转化为特定某一vlan送给SWA

## 实验步骤：

1、 创建原始vlan和转换后的vlan 
2、 终端ip地址配置 

## 测试结果：
通过display vlan mapping查看SWB上的VLAN映射配置信息 
 
![通过display vlan mapping查看SWB上的VLAN映射配置信息](./Media/1.png) 

PC1和PC2互访正常 
 ![PC1和PC2互访正常](./Media/2.png) 



## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。 
2、本实验用的交换机版本为默认版本。 
