# 明确的Dot1q终结配置举例

## 需求：

如下图所示，Host A、Host B和Switch A相连，Host C、Host D和Switch
B相连。Host A和Host C属于VLAN 10，Host B和Host D属于VLAN
20。Device子接口GigabitEthernet0/1.10、GigabitEthernet0/1.20、GigabitEthernet0/2.10、GigabitEthernet0/2.20的IP地址分别为1.0.0.1/8、2.0.0.1/8、3.0.0.1/8和4.0.0.1/8。要求实现：

Host A和Host B之间、Host C和Host
D之间能够互相通信，即同一交换机、不同VLAN之间能够互相通信；

Host A和Host C之间、Host B和Host
D之间能够互相通信，即不同交换机、同一VLAN之间能够互相通信；

Host A和Host D之间、Host B和Host
C之间能够互相通信，即不同交换机、不同VLAN之间能够互相通信。

## 实验步骤：

1.  Host A、Host B、Host C、Host D的配置

将Host A的IP地址指定为1.1.1.1/8，网关地址指定为1.0.0.1/8。

将Host B的IP地址指定为2.2.2.2/8，网关地址指定为2.0.0.1/8。

将Host C的IP地址指定为3.3.3.3/8，网关地址指定为3.0.0.1/8。

将Host D的IP地址指定为4.4.4.4/8，网关地址指定为4.0.0.1/8。

2.  L2 Switch A、L2 Switch B的配置

创建VLAN，并将接口加入VLAN。

3.  Device的配置

#创建以太网子接口GigabitEthernet0/1.10、GigabitEthernet0/1.20、GigabitEthernet0/2.10和GigabitEthernet0/2.20，分别为其配置IP地址，配置GigabitEthernet0/1.10和GigabitEthernet0/2.10用来终结VLAN
10的报文，配置GigabitEthernet0/1.20和GigabitEthernet0/2.20用来终结VLAN
20的报文。

\<Device\> system-view

\[Device\] interface gigabitethernet 1/0/1.10

\[Device-GigabitEthernet1/0/1.10\] ip address 1.0.0.1 255.0.0.0

\[Device-GigabitEthernet1/0/1.10\] vlan-type dot1q vid 10

\[Device-GigabitEthernet1/0/1.10\] quit

\[Device\] interface gigabitethernet 1/0/1.20

\[Device-GigabitEthernet1/0/1.20\] ip address 2.0.0.1 255.0.0.0

\[Device-GigabitEthernet1/0/1.20\] vlan-type dot1q vid 20

\[Device-GigabitEthernet1/0/1.20\] quit

\[Device\] interface gigabitethernet 1/0/2.10

\[Device-GigabitEthernet1/0/2.10\] ip address 3.0.0.1 255.0.0.0

\[Device-GigabitEthernet1/0/2.10\] vlan-type dot1q vid 10

\[Device-GigabitEthernet1/0/2.10\] quit

\[Device\] interface gigabitethernet 1/0/2.20

\[Device-GigabitEthernet1/0/2.20\] ip address 4.0.0.1 255.0.0.0

\[Device-GigabitEthernet1/0/2.20\] vlan-type dot1q vid 20

\[Device-GigabitEthernet1/0/2.20\] quit

## 测试结果：

配置完成后，Host A、Host B、Host C、Host D可以相互ping通。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
