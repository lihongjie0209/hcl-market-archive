# 工程名称
v7_ngfw_isis基础


## 需求：
配置FW和SW建立isis的 level-2 邻居


## 实验步骤：
1、配置接口ip
2、配置isis进程，以FW为例
#
isis 1
 is-level level-2
 network-entity 49.0001.0010.0000.0002.00
#
3、接口使能isis，以FW为例
#
interface GigabitEthernet1/0/1
 port link-mode route
 ip address 10.1.12.2 255.255.255.0
 isis enable 1
#

## 测试结果：
isis邻居建立成功
[FW]display isis peer 
                         Peer information for IS-IS(1)
                         -----------------------------
 System ID: 0010.0000.0001
 Interface: GE1/0/1                 Circuit Id:  0010.0000.0002.01
 State: Up     HoldTime: 26s        Type: L2           PRI: 64

## 说明： 
需要手动修改两台路由器isis进程中的is-level为level-2

