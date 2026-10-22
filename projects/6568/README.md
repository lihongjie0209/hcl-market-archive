# 工程名称



## 需求：
在AC上配置VLAN-group。现要求：Client分别接入不同VLAN组，VLAN组可以为Client随机分配组内的VLAN，使用动态vlan-group方式


## 实验步骤：
1.配置AC的接口

2.配置交换机接口

3.配置vlan-group，在vlan-group里添加vlan-list，分别创建对应vlan和对应dhcp地址池

4.创建无线服务模板，配置给客户端分配的VLAN为动态模式，使能无线服务模板

5.将无线服务模板绑定到ap射频，并指定对应的vlan-group，开启射频


## 测试结果：
不同的终端连接无线可以被分到不同的vlan里获取对应的ip地址
![测试结果](./Media/企业微信截图_16681462521819.png) 



## 说明： 


