# 工程名称
qos基于vlan带宽分配


## 需求：
根据线路带宽状况，现要求使用流量监管功能，实现对不同业务类型的数据进行如下的带宽分配：
1、在Device连接分支机构A和分支机构B的链路上，要求对上行至Device的各业务数据速率分别限制为：VLAN1001为400Mbps，VLAN1002为200Mbps，VLAN1003为200Mbps。对Device下行方向的业务数据同样根据以上数值进行限速。
2、在Device连接分支机构C的链路上，要求对上行至Device的各业务数据速率分别限制为：VLAN201为400Mbps，VLAN202为200Mbps，VLAN203为200Mbps。对Device下行方向的业务数据同样根据以上数值进行限速。
3、在Device连接公司骨干网的联路上，要求对上行至骨干网的各业务数据限速为：VLAN201为100Mbps，VLAN202为60Mbps，VLAN203为40Mbps。对下行方向数据同样根据以上数值进行限速。


## 实验步骤：
1、配置端口Ten-GigabitEthernet1/0/1和Ten-GigabitEthernet1/0/2为Trunk端口，允许VLAN1001、VLAN1002、VLAN1003、VLAN201、VLAN202、VLAN203通过，取消允许VLAN1通过，并配置1:1 VLAN Mapping。
<Device> system-view
[Device] interface ten-gigabitethernet 1/0/1
[Device-Ten-GigabitEthernet1/0/1] port link-type trunk
[Device-Ten-GigabitEthernet1/0/1] port trunk permit vlan 1001 to 1003 201 to 203
[Device-Ten-GigabitEthernet1/0/1] undo port trunk permit vlan 1
[Device-Ten-GigabitEthernet1/0/1] vlan mapping 1001 translated-vlan 201
[Device-Ten-GigabitEthernet1/0/1] vlan mapping 1002 translated-vlan 202
[Device-Ten-GigabitEthernet1/0/1] vlan mapping 1003 translated-vlan 203
[Device-Ten-GigabitEthernet1/0/1] quit
[Device] interface ten-gigabitethernet 1/0/2
[Device-Ten-GigabitEthernet1/0/2] port link-type trunk
[Device-Ten-GigabitEthernet1/0/2] port trunk permit vlan 1001 to 1003 201 to 203
[Device-Ten-GigabitEthernet1/0/2] undo port trunk permit vlan 1
[Device-Ten-GigabitEthernet1/0/2] vlan mapping 1001 translated-vlan 201
[Device-Ten-GigabitEthernet1/0/2] vlan mapping 1002 translated-vlan 202
[Device-Ten-GigabitEthernet1/0/2] vlan mapping 1003 translated-vlan 203
[Device-Ten-GigabitEthernet1/0/2] quit
# 配置端口Ten-GigabitEthernet1/0/3和Ten-GigabitEthernet1/0/10为Trunk端口，并允许VLAN201、VLAN202、VLAN203通过，取消允许VLAN1通过。
[Device] interface ten-gigabitethernet 1/0/3
[Device-Ten-GigabitEthernet1/0/3] port link-type trunk
[Device-Ten-GigabitEthernet1/0/3] port trunk permit vlan 201 to 203
[Device-Ten-GigabitEthernet1/0/3] undo port trunk permit vlan 1
[Device-Ten-GigabitEthernet1/0/3] quit
[Device] interface ten-gigabitethernet 1/0/10
[Device-Ten-GigabitEthernet1/0/10] port link-type trunk
[Device-Ten-GigabitEthernet1/0/10] port trunk permit vlan 201 to 203
[Device-Ten-GigabitEthernet1/0/10] undo port trunk permit vlan 1
[Device-Ten-GigabitEthernet1/0/10] quit
 
2、流量监管部分的配置
(1)对接收和发送分支机构A、B、C的报文进行流量监管。
# 创建流分类vlan201，匹配规则为匹配customer-vlan-id为201。
[Device] traffic classifier vlan201
[Device-classifier-vlan201] if-match customer-vlan-id 201
[Device-classifier-vlan201] quit
# 创建流分类vlan202，匹配规则为匹配customer-vlan-id为202。
[Device] traffic classifier vlan202
[Device-classifier-vlan202] if-match customer-vlan-id 202
[Device-classifier-vlan202] quit
# 创建流分类vlan203，匹配规则为匹配customer-vlan-id为203。
[Device] traffic classifier vlan203
[Device-classifier-vlan203] if-match customer-vlan-id 203
[Device-classifier-vlan203] quit
# 创建流行为car400，并配置流量监管的动作，承诺速率为400Mbps。
[Device] traffic behavior car400
[Device-behavior-car400] car cir 409600
[Device-behavior-car400] quit
# 创建流行为car200，并配置流量监管的动作，承诺速率为200Mbps。
[Device] traffic behavior car200
[Device-behavior-car200] car cir 204800
[Device-behavior-car200] quit
# 创建QoS策略ABCupdown，并将流分类与流行为进行配对。
[Device] qos policy ABCupdown
[Device-qospolicy-ABCupdown] classifier vlan201 behavior car400
[Device-qospolicy-ABCupdown] classifier vlan202 behavior car200
[Device-qospolicy-ABCupdown] classifier vlan203 behavior car200
[Device-qospolicy-ABCupdown] quit
# 在端口Ten-GigabitEthernet1/0/1、Ten-GigabitEthernet1/0/2和Ten-GigabitEthernet1/0/3的入方向和出方向分别应用QoS策略ABCupdown。
[Device] interface ten-gigabitethernet 1/0/1
[Device-Ten-GigabitEthernet1/0/1] qos apply policy ABCupdown inbound
[Device-Ten-GigabitEthernet1/0/1] qos apply policy ABCupdown outbound
[Device-Ten-GigabitEthernet1/0/1] quit
[Device] interface ten-gigabitethernet 1/0/2
[Device-Ten-GigabitEthernet1/0/2] qos apply policy ABCupdown inbound
[Device-Ten-GigabitEthernet1/0/2] qos apply policy ABCupdown outbound
[Device-Ten-GigabitEthernet1/0/2] quit
[Device] interface ten-gigabitethernet 1/0/3
[Device-Ten-GigabitEthernet1/0/3] qos apply policy ABCupdown inbound
[Device-Ten-GigabitEthernet1/0/3] qos apply policy ABCupdown outbound
[Device-Ten-GigabitEthernet1/0/3] quit
(2)对接收和发送公司骨干网的报文进行流量监管。
# 创建流行为car100，并配置流量监管的动作，承诺速率为100Mbps。
[Device] traffic behavior car100
[Device-behavior-car100] car cir 102400
[Device-behavior-car100] quit
# 创建流行为car60，并配置流量监管的动作，承诺速率为60Mbps。
[Device] traffic behavior car60
[Device-behavior-car60] car cir 61440
[Device-behavior-car60] quit
# 创建流行为car40，并配置流量监管的动作，承诺速率为40Mbps。
[Device] traffic behavior car40
[Device-behavior-car40] car cir 40960
[Device-behavior-car40] quit
# 创建QoS策略ABCupdown，并将流分类与流行为进行配对。
[Device] qos policy BONEupdown
[Device-qospolicy-BONEupdown] classifier vlan201 behavior car100
[Device-qospolicy-BONEupdown] classifier vlan202 behavior car60
[Device-qospolicy-BONEupdown] classifier vlan203 behavior car40
[Device-qospolicy-BONEupdown] quit
# 在端口GigabitEthernet1/0/10的入方向和出方向分别应用QoS策略BONEupdown。
[Device] interface ten-gigabitethernet 1/0/10
[Device-Ten-GigabitEthernet1/0/10] qos apply policy BONEupdown inbound
[Device-Ten-GigabitEthernet1/0/10] qos apply policy BONEupdown outbound
[Device-Ten-GigabitEthernet1/0/10] quit

## 测试结果：
![image.png](./Media/image.png)
![image.png](./Media/image.png)
![image.png](./Media/image.png)
![image.png](./Media/image.png)

## 说明： 
在一个流行为中，流量监管动作不能与重标记优先级（包括本地优先级、丢弃优先级、802.1p优先级、DSCP优先级、IP优先级）的动作同时配置，否则会导致该流行为不能被正常应用。
