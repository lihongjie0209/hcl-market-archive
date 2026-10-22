# 工程名称

AC 端口隔离配置举例

## 需求：
AP 3、AP 4、AP 5分别与AC的端口GigabitEthernet1/0/1、GigabitEthernet1/0/2、GigabitEthernet1/0/3相连，AC设备通过GigabitEthernet1/0/0端口与交换机相连。现需要实现AP 3、AP 4和AP 5彼此之间二层报文不能互通，但可以和交换机通信。


## 实验步骤：
# 将端口GigabitEthernet1/0/1、GigabitEthernet1/0/2、GigabitEthernet1/0/3加入隔离组。
<AC> system-view
[AC] interface gigabitethernet 1/0/1
[AC-GigabitEthernet1/0/1] port-isolate enable
[AC-GigabitEthernet1/0/1] quit
[AC] interface gigabitethernet 1/0/2
[AC-GigabitEthernet1/0/2] port-isolate enable
[AC-GigabitEthernet1/0/2] quit
[AC] interface gigabitethernet 1/0/3
[AC-GigabitEthernet1/0/3] port-isolate enable
[AC-GigabitEthernet1/0/3] quit


## 测试结果：
[AC]display port-isolate group
 Port isolation group information:
 Group ID: 1
 Group members:
    GigabitEthernet1/0/1          GigabitEthernet1/0/2
    GigabitEthernet1/0/3
 Community VLAN ID: None
以上信息显示AC上的端口GigabitEthernet1/0/1、GigabitEthernet1/0/2、GigabitEthernet1/0/3已经加入隔离组，从而实现二层隔离，AP 3、AP 4和AP 5彼此之间不能ping通。



## 说明： 


