# 工程名称
v7_ngfw_bgp基础


## 需求：
配置FW与SW建立IGBP邻居，与RT建立EBGP邻居


## 实验步骤：
1、配置接口地址
2、配置BGP，以FW为例
#
bgp 65000
 peer 10.1.12.1 as-number 65000
 peer 10.1.23.3 as-number 65001
 #
 address-family ipv4 unicast
  peer 10.1.12.1 enable
  peer 10.1.23.3 enable
#

3、放行安全策略
#
security-policy ip
 rule 5 name bgp
  action pass
  service bgp
#


## 测试结果：
查看BGP邻居建立完成
![image.png](./Media/image.png)


## 说明： 
防火墙需要安全策略放行BGP协议报文

