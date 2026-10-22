# 工程名称
v7_ngfw_snmp_trap告警外发


## 需求：
将设备产生的trap告警外发至服务器100。0.0.254


## 实验步骤：
1、配置基本网络互通
2、配置snmp和trap
#
 snmp-agent
 snmp-agent community read hzlabread
 snmp-agent community write hzlabwrite
 snmp-agent sys-info version v2c v3 
 snmp-agent target-host trap address udp-domain 100.0.0.254 params securityname hzlabread v2c
 snmp-agent trap enable arp 
 snmp-agent trap enable port-security 
 snmp-agent trap enable radius 
 snmp-agent trap enable syslog 
#
3、放行安全策略
#
security-policy ip
 rule 11 name local
  action pass
  source-zone local
#


## 测试结果：
![image.png](./Media/image.png)


## 说明： 
trap告警外发时需要放行loal到去往网管设备接口所在安全域的策略

