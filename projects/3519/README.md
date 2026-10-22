# 工程名称
防火墙做RBM，配合VRRP实现双主运行。


## 需求：
防火墙做RBM，结合VRRP情况下双主运行， 接线和地址规划如图。


## 实验步骤：
1.配置交换机的地址和路由，路由目前是2.2.2.4访问4.4.4.4走fw主，3.3.3.4访问5.5.5.4走fw备。接口都是trunk口放通相关vlan。


2.配置防火墙RBM。

3.配置接口IP。

4.配置VRRP。

5.配置安全策略和安全域，将上行放入trust，下行放入untrust，放通trust-untrust，并且有VRRP，需要放通vrrp报文。


## 测试结果：
直接查看ARP情况，确认2.2.2.1是从FW1互联接口学到，3.3.3.1是从FW2的互联接口学到。下行交换机类似。
<H3C>dis arp

  Type: S-Static   D-Dynamic   O-Openflow   R-Rule   M-Multiport  I-Invalid

IP address       MAC address    SVLAN/VSI Interface/Link ID        Aging Type

2.2.2.1          0000-5e00-0114 20        GE1/0/2                  18    D

2.2.2.2          8846-2bcf-0107 20        GE1/0/2                  15    D

3.3.3.2          8846-2bcf-0107 30        GE1/0/2                  15    D

2.2.2.3          8846-2f6a-0207 20        GE1/0/3                  18    D

3.3.3.1          0000-5e00-011e 30        GE1/0/3                  19    D

3.3.3.3          8846-2f6a-0207 30        GE1/0/3                  18    D



## 说明： 
1.可以做ping测试，但是RBM模拟器问题不能同步会话，因此不建议跨框测试。


