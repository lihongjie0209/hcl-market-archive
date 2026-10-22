# 工程名称
qos拥塞避免


## 需求：
Device通过端口FGE1/0/49与网关相连，来自Internet的业务有语音、视频、数据经由网关和Device到达用户。其中：
语音业务通过VLAN 6发送，携带的802.1p优先级分别为6；
其中视频业务通过VLAN 4发送，携带的802.1p优先级分别为4；
其中数据业务通过VLAN 2发送，携带的802.1p优先级分别为2；
由于Device入端口FGE1/0/49的速率大于出端口XGE1/0/1和XGE1/0/2的速率，在这两个出端口处可能会发生拥塞。为了减轻网络拥塞造成的影响，保证用户对于高优先级、低延迟业务的服务要求，配置需求如下：
当网络发生拥塞时，三种业务（语音业务：视频业务：数据业务）之间按照调度比重1：2：2的权重进行调度。
当发生严重拥塞时，要求采用随机丢弃的策略，防止出现TCP全局同步现象。


## 实验步骤：
配置Device上允许不同业务对应的VLAN报文通过
# 创建三种业务所需的VLAN。
<Device> system-view
[Device] vlan 2
[Device-vlan2] quit
[Device] vlan 4
[Device-vlan4] quit
[Device] vlan 6
[Device-vlan6] quit
# 配置各端口加入对应的VLAN。
[Device] interface fortygige 1/0/49
[Device-FortyGigE1/0/49 ] port link-type trunk
[Device-FortyGigE1/0/49] port trunk permit vlan 2 4 6
[Device-FortyGigE1/0/49] quit
[Device] interface ten-gigabitethernet 1/0/1
[Device-Ten-GigabitEthernet1/0/1] port link-type trunk
[Device-Ten-GigabitEthernet1/0/1] port trunk permit vlan 2 4 6
[Device-Ten-GigabitEthernet1/0/1] quit
[Device] interface ten-gigabitethernet 1/0/2
[Device-Ten-GigabitEthernet1/0/2] port link-type trunk
[Device-Ten-GigabitEthernet1/0/2] port trunk permit vlan 2 4 6
[Device-Ten-GigabitEthernet1/0/2] quit
配置业务流量的入端口上配置信任报文的802.1p优先级
[Device] interface fortygige 1/0/49
[Device-FortyGigE1/0/49] qos trust dot1p
[Device-FortyGigE1/0/49] quit
配置WRR队列
# 查看802.1p优先级到本地优先级映射表，确定各个业务对应的本地优先级
![image.png](./Media/image.png)
# 在业务流量的出端口Ten-GigabitEthernet1/0/1上使能WRR队列。
[Device] interface ten-gigabitethernet 1/0/1
[Device-Ten-GigabitEthernet1/0/1] qos wrr weight
# 配置WRR队列，实现数据、视频和语音三个队列之间的调度权重比为2：2：1。
[Device-Ten-GigabitEthernet1/0/1] qos wrr 1 group 1 weight 2
[Device-Ten-GigabitEthernet1/0/1] qos wrr 4 group 1 weight 2
[Device-Ten-GigabitEthernet1/0/1] qos wrr 6 group 1 weight 1
[Device-Ten-GigabitEthernet1/0/1] quit
# 在业务流量的出端口Ten-GigabitEthernet1/0/2上使能WRR队列。
[Device] interface ten-gigabitethernet 1/0/2
[Device-Ten-GigabitEthernet1/0/2] qos wrr weight
# 配置WRR队列，实现数据、视频和语音三个队列之间的调度权重比为2：2：1。
[Device-Ten-GigabitEthernet1/0/2] qos wrr 1 group 1 weight 2
[Device-Ten-GigabitEthernet1/0/2] qos wrr 4 group 1 weight 2
[Device-Ten-GigabitEthernet1/0/2] qos wrr 6 group 1 weight 1
[Device-Ten-GigabitEthernet1/0/2] quit
配置拥塞避免
# 创建WRED表。
[Device] qos wred queue table droppolicy
[Device-wred-table-droppolicy] queue 6 drop-level 1 low-limit 1000 high-limit 1500 discard-probability 3
[Device-wred-table-droppolicy] queue 6 drop-level 2 low-limit 500 high-limit 1000 discard-probability 30
[Device-wred-table-droppolicy] queue 4 drop-level 1 low-limit 1000 high-limit 1500 discard-probability 2
[Device-wred-table-droppolicy] queue 4 drop-level 2 low-limit 500 high-limit 1000 discard-probability 20
[Device-wred-table-droppolicy] queue 1 drop-level 1 low-limit 1000 high-limit 1500 discard-probability 1
[Device-wred-table-droppolicy] queue 1 drop-level 2 low-limit 500 high-limit 1000 discard-probability 10
[Device-wred-table-droppolicy] quit
# 在业务流量的出端口Ten-GigabitEthernet1/0/1和 Ten-GigabitEthernet1/0/2上应用WRED表。
[Device] interface ten-gigabitethernet 1/0/1
[Device-Ten-GigabitEthernet1/0/1] qos wred apply droppolicy
[Device-Ten-GigabitEthernet1/0/1] quit
[Device] interface ten-gigabitethernet 1/0/2
[Device-Ten-GigabitEthernet1/0/2] qos wred apply droppolicy
[Device-Ten-GigabitEthernet1/0/2] quit
 
## 测试结果：
![image.png](./Media/image.png)


## 说明： 
• 队列上限和下限：当队列平均长度小于下限时，不丢弃报文。当队列平均长度在上限和下限 之间时，设备随机丢弃报文，队列越长，丢弃概率越高。当队列平均长度超过上限时，丢弃 所有到来的报文。 • 丢弃优先级：在进行报文丢弃时参考的参数，0 对应绿色报文、1 对应黄色报文、2 对应红色 报文，红色报文将被优先丢弃。

