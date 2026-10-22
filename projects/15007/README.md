# 工程名称
v7_ngfw_快速日志_安全策略日志


## 需求：
以快速日志的格式将安全策略日志发送给日志服务器100.0.0.254


## 实验步骤：
1、配置基本互通
2、配置安全策略规则记录日志
#
security-policy ip
 rule 10 name toInternet
  action pass
  logging enable
  source-zone trust
  destination-zone untrust
#
3、配置安全策略日志输出为快速日志，并配置快速日志外发
#
 customlog format packet-filter 
 customlog host 100.0.0.254 export packet-filter
#

## 测试结果：
![image.png](./Media/image.png)


## 说明： 
安全策略日志对应的是packet-filter模块

