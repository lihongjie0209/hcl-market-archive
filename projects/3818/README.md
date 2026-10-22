# 工程名称
防火墙做二层结合RBM实现主备部署。


## 需求：
防火墙做RBM，并且要去二层主备模式部署。让上面设备能访问下面设备。


## 实验步骤：
1.配置交换机的vlan 和地址，所有接口都trunk口，允许vlan10 和20放通。

2.配置防火墙的RBM，二层主备可以使用track vlan方式，备机不处理相关vlan的报文。

3.配置安全策略和安全域，注意防火墙接口改为二层后，安全域需要增加vlan配置，并且放通上行trust到下行untrust的策略。

4.测试结果


## 测试结果：
查看ARP表项情况，都是从1/0/1口学到。

dis arp
  Type: S-Static   D-Dynamic   O-Openflow   R-Rule   M-Multiport  I-Invalid

IP address       MAC address    SVLAN/VSI Interface/Link ID        Aging Type

10.1.1.2         1e60-d15a-0402 10        GE1/0/1                  20    D

20.1.1.2         1e60-d15a-0402 20        GE1/0/1                  20    D


## 说明： 

RBM主备二层情况下，备机不处理被track的vlan报文，因此流量不会走到备机，也不存在环路情况，主备切换和ping测试都可以实际测试，但是也不能同步会话，因此切换会出现丢包。
