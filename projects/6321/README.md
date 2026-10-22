# 工程名称

以太网链路聚合配合典型配置举例

## 需求：5
AC 2与AC 2通过进行链路聚合

## 实验步骤：
1. 配置AC2
# 创建二层聚合接口1，并配置该聚合接口对应的聚合组工作在动态聚合模式下。
<AC2> system-view
[AC2] interface bridge-aggregation 1
[AC2-Bridge-Aggregation1] link-aggregation mode dynamic
[AC2-Bridge-Aggregation1] quit
# 将端口GigabitEthernet1/0/0加入到聚合组1中。
[AC2] interface gigabitethernet 1/0/0
[AC2-GigabitEthernet1/0/0] port link-aggregation group 1
[AC2-GigabitEthernet1/0/0] quit
# 将端口GigabitEthernet1/0/1加入到聚合组1中。
[AC2] interface gigabitethernet 1/0/1
[AC2-GigabitEthernet1/0/1] port link-aggregation group 1
[AC2-GigabitEthernet1/0/1] quit
2. 配置AC5
# 创建二层聚合接口1，并配置该聚合接口对应的聚合组工作在动态聚合模式下。
<AC5> system-view
[AC5] interface bridge-aggregation 1
[AC5-Bridge-Aggregation1] link-aggregation mode dynamic
[AC5-Bridge-Aggregation1] quit
# 将端口GigabitEthernet1/0/0加入到聚合组1中。
[AC5] interface gigabitethernet 1/0/0
[AC5-GigabitEthernet1/0/0] port link-aggregation group 1
[AC5-GigabitEthernet1/0/0] quit
# 将端口GigabitEthernet1/0/1加入到聚合组1中。
[AC5] interface gigabitethernet 1/0/1
[AC5-GigabitEthernet1/0/1] port link-aggregation group 1
[AC5-GigabitEthernet1/0/1] quit

## 测试结果：

[H3C]display link-aggregation verbose
Loadsharing Type: Shar -- Loadsharing, NonS -- Non-Loadsharing
Port Status: S -- Selected, U -- Unselected, I -- Individual
Flags:  A -- LACP_Activity, B -- LACP_Timeout, C -- Aggregation,
        D -- Synchronization, E -- Collecting, F -- Distributing,
        G -- Defaulted, H -- Expired

Aggregate Interface: Bridge-Aggregation1
Aggregation Mode: Dynamic
Loadsharing Type: Shar
System ID: 0x8000, 2614-87a3-0500
Local:
  Port             Status  Priority Oper-Key  Flag
--------------------------------------------------------------------------------
  GE1/0/0          S       32768    1         {ACDEF}
  GE1/0/1          S       32768    1         {ACDEF}
Remote:
  Actor            Partner Priority Oper-Key  SystemID               Flag
--------------------------------------------------------------------------------
  GE1/0/0          1       32768    1         0x8000, 24e9-5289-0200 {ACDEF}
  GE1/0/1          2       32768    1         0x8000, 24e9-5289-0200 {ACDEF}


## 说明： 建议先配置好命令，再连线


