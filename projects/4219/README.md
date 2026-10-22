# 工程名称
V7交换机Trap告警外发


## 需求：
交换机配置完SNMP后，开启trap功能，并将trap告警日志发送至网管服务器192.168.1.2


## 实验步骤：
1、交换机完成SNMP基础配置

#
 snmp-agent
 snmp-agent community read read1
 snmp-agent community write write1
 snmp-agent sys-info version v1 v2c
#

2、开启trap告警功能

#
 snmp-agent trap enable
#


3、配置trap告警日志外发至192.168.1.2，并且认证参数为设备配置的读团体名read1，并使用snmpv2c版本

#
 snmp-agent target-host trap address udp-domain 192.168.1.2 params securityname read1
#


## 测试结果：
1、交换机侧可以看到哪些模块使能了trap

[SW1]dis snmp-agent trap-list
   arp notification is enabled.
   configuration notification is enabled.
   mac-address notification is enabled.
   radius notification is enabled.
   standard notification is enabled.
   stp notification is enabled.
   syslog notification is enabled.
   system notification is enabled.

   Enabled notifications: 8; Disabled notifications: 0
[SW1]

2、网管侧配置设备的SNMP版本为v2c后，可以收到交换机发送的trap告警信息



## 说明：
1、本工程重点说明交换机trap告警外发配置，网管设备仅用作展示，未作任何配置

2、交换机和网管侧必须可以互通 


