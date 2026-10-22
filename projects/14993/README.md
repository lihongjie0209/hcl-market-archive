# 工程名称
qos重标记

## 需求：
公司企业网通过 Device 实现互连。网络环境描述如下：
• Host A通过端口 GigabitEthernet1/0/1 接入 Device；
• 数据库服务器、邮件服务器和文件服务器通过端口 GigabitEthernet1/0/2 接入 Device。
通过配置重标记功能，Device 上实现如下需求：
• 优先处理 Host A访问数据库服务器的报文；
• 其次处理 Host A访问邮件服务器的报文；
• 最后处理 Host A访问文件服务器的报文。

## 实验步骤：
# 定义高级 ACL 3000，对目的 IP 地址为 192.168.0.1 的报文进行分类。
<Device> system-view
[Device] acl advanced 3000
[Device-acl-ipv4-adv-3000] rule permit ip destination 192.168.0.1 0
[Device-acl-ipv4-adv-3000] quit
# 定义高级 ACL 3001，对目的 IP 地址为 192.168.0.2 的报文进行分类。
[Device] acl advanced 3001
[Device-acl-ipv4-adv-3001] rule permit ip destination 192.168.0.2 0
[Device-acl-ipv4-adv-3001] quit
# 定义高级 ACL 3002，对目的 IP 地址为 192.168.0.3 的报文进行分类。
[Device] acl advanced 3002
[Device-acl-ipv4-adv-3002] rule permit ip destination 192.168.0.3 0
[Device-acl-ipv4-adv-3002] quit
# 定义类 classifier_dbserver，匹配高级 ACL 3000。
[Device] traffic classifier classifier_dbserver
[Device-classifier-classifier_dbserver] if-match acl 3000
[Device-classifier-classifier_dbserver] quit
# 定义类 classifier_mserver，匹配高级 ACL 3001。
[Device] traffic classifier classifier_mserver
[Device-classifier-classifier_mserver] if-match acl 3001
[Device-classifier-classifier_mserver] quit
# 定义类 classifier_fserver，匹配高级 ACL 3002。
[Device] traffic classifier classifier_fserver
[Device-classifier-classifier_fserver] if-match acl 3002
[Device-classifier-classifier_fserver] quit
# 定义流行为 behavior_dbserver，动作为重标记报文的本地优先级为 4。
[Device] traffic behavior behavior_dbserver
[Device-behavior-behavior_dbserver] remark local-precedence 4
[Device-behavior-behavior_dbserver] quit
# 定义流行为 behavior_mserver，动作为重标记报文的本地优先级为 3。
[Device] traffic behavior behavior_mserver
[Device-behavior-behavior_mserver] remark local-precedence 3
[Device-behavior-behavior_mserver] quit
# 定义流行为 behavior_fserver，动作为重标记报文的本地优先级为 2。
[Device] traffic behavior behavior_fserver
[Device-behavior-behavior_fserver] remark local-precedence 2
[Device-behavior-behavior_fserver] quit
# 定义策略 policy_server，为类指定流行为。
[Device] qos policy policy_server
[Device-qospolicy-policy_server] classifier classifier_dbserver behavior behavior_dbserver
[Device-qospolicy-policy_server] classifier classifier_mserver behavior behavior_mserver
[Device-qospolicy-policy_server] classifier classifier_fserver behavior behavior_fserver
[Device-qospolicy-policy_server] quit
# 将策略 policy_server 应用到端口 GigabitEthernet1/0/1 上。
10-4
[Device] interface gigabitethernet 1/0/1
[Device-GigabitEthernet1/0/1] qos apply policy policy_server inbound
[Device-GigabitEthernet1/0/1] quit


## 测试结果：
[Device]display qos policy interface g0/1
Interface: GigabitEthernet0/1
  Direction: Inbound
  Policy: policy_server
   Classifier: default-class
     Matched : 0 (Packets) 0 (Bytes)
     5-minute statistics:
      Forwarded: 0/0 (pps/bps)
      Dropped  : 0/0 (pps/bps)
     Operator: AND
     Rule(s) :
      If-match any
     Behavior: be
      -none-
   Classifier: classifier_dbserver
     Matched : 10 (Packets) 980 (Bytes)
     5-minute statistics:
      Forwarded: 0/26 (pps/bps)
      Dropped  : 0/0 (pps/bps)
     Operator: AND
     Rule(s) :
      If-match acl 3000
     Behavior: behavior_dbserver
      Marking:
        Remark local-precedence 4
   Classifier: classifier_mserver
     Matched : 10 (Packets) 980 (Bytes)
     5-minute statistics:
      Forwarded: 0/26 (pps/bps)
      Dropped  : 0/0 (pps/bps)
     Operator: AND
     Rule(s) :
      If-match acl 3001
     Behavior: behavior_mserver
      Marking:
        Remark local-precedence 3
   Classifier: classifier_fserver
     Matched : 10 (Packets) 980 (Bytes)
     5-minute statistics:
      Forwarded: 0/26 (pps/bps)
      Dropped  : 0/0 (pps/bps)
     Operator: AND
     Rule(s) :
      If-match acl 3002
     Behavior: behavior_fserver
      Marking:
        Remark local-precedence 2

## 说明： 


