# 工程名称
V7交换机SNMPv1_v2c配置


## 需求：
交换机开启SNMP功能，使网管通过v1/v2c版本都可以使用指定团体名结合指定OID来读取设备信息，交换机配置只读团体名为read1，读写团体名为write1



## 实验步骤：
1、开启SNMP功能
#
 snmp-agent
#

2、配置SNMP版本为v1和v2c
#
 snmp-agent sys-info version v1 v2c 
#

3、配置snmp只读团体名为read1，配置读写团体名为write1
#
 snmp-agent community read read1
 snmp-agent community write write1
#

## 测试结果：
网管侧使用设备配置的团体名可以使用指定OID读取到设备信息(本工程重点说明设备侧SNMP配置，网管设备仅模拟展示，没有任何配置)



## 说明： 
1、网管和交换机可以通信

2、SNMPv1/v2c使用团体名进行验证，所以网管侧使用的团体名需要与设备侧保持一致


