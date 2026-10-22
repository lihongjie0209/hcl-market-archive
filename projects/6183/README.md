# 工程名称

AC vlan 典型配置举例

## 需求：

给AC配置vlan2和vlan3，并且接口G1/0/0需要trunk permitvlan2和vlan3

## 实验步骤：
配置vlan2
[H3C] vlan 2
配置vlan3
[H3C]vlan 3
配置接口trunk且permitvlan2和vlan3
[H3C]int g1/0/0
[H3C-GigabitEthernet1/0/0]port link-type trunk
[H3C-GigabitEthernet1/0/0]port trunk permit vlan 2 3


## 测试结果：

[H3C]dis vlan
 Total VLANs: 3
 The VLANs include:
 1(default), 2-3

[H3C]display port trunk
Interface             PVID    VLAN Passing
 GE1/0/0               1      1-3

## 说明： 


