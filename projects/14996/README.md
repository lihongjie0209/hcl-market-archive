# 工程名称
基于IP子网划分vlan


## 需求：
通过在交换机上配置两个 IP 子网与相应 VLAN 关联，让交换机能够按照设定的 IP 子网为数据分配 VLAN 标签(Tg)，从而使处于相同VLAN 内的 PC 可以互通。用户物理位置移动时，即使更换了交换机连接 PC 的端口，PC 所属的 VLAN 也不会改变。通过本实验，能够学会交换机上基于 IP 子网的 VLAN 配置。

## 实验步骤：
[SWA]vlan 10
[SWA-vlan10]ip-subnet-vlan ip 10.10.10.0 255.255.255.0
[SWA]vlan 20
[SWA-vlan20]ip-subnet-vlan ip 20.20.20.0 255.255.255.0
[SWA]int g 1/0/1
[SWA-GigabitEthernet1/0/1]port link-type hybrid
[SWA-GigabitEthernet1/0/1]port hybrid vlan 10 20 untagged
[SWA-GigabitEthernet1/0/1]port hybrid ip-subnet-vlan vlan 10
[SWA-GigabitEthernet1/0/1]port hybrid ip-subnet-vlan vlan 20
[SWA]int g 1/0/2
[SWA-GigabitEthernet1/0/2]port link-type hybrid
[SWA-GigabitEthernet1/0/2]port hybrid vlan 10 20 untagged
[SWA-GigabitEthernet1/0/2]port hybrid ip-subnet-vlan vlan 10
[SWA-GigabitEthernet1/0/2]port hybrid ip-subnet-vlan vlan 20
[SWA]int g 1/0/24
[SWA-GigabitEthernet1/0/24]port link-type trunk
[SWA-GigabitEthernet1/0/24]port trunk permit vlan 10 20
SwB配置一样的


## 测试结果：
![image.png](./Media/image.png)

## 说明： 

配置后，PCA PCC 之间是互通的，即使把1/0/1的端口换成1/0/5，两者依然可以ping通。说明这种（包括mac、协议）最大的优点是当pc机连接交换机的端口改变时，vlan依然存在。
