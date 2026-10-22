# 工程名称

防火墙中VRF情况下，各种NAT和策略的配合关系

## 需求：
测试防火墙各种NAT，在VRF情况下和策略的匹配关系。


## 实验步骤：
1.配置地址和路由。

2.配置VPN实例。接口使用。

3.配置nat outbound，acl只写一个目的地址为1.1.1.1，确保ping1.1.1.的时候才走nat outbound。

4.配置 nat server，用30.30.30.30映射30.1.1.1.

5.配置 nat static inbound，用20.20.20.20映射20.1.1.1.并且是入方向转源，是路由器访问PC。

6.配置nat static outbound，用10.10.10.10映射10.1.1.1.

7.配置安全策略。接PC为untrust，接路由器为trust。

nat outbound情况下是先匹配策略后匹配nat，因此策略是写实际地址和实际的入接口VRF。

nat server是先匹配NAT后匹配策略，因此要写转换后的VPN和地址。

nat static outbound和nat server一致。本案例功能上是一致的，没有测试反向情况，不过反向原理和nat outbound一样。

nat static inbound，是入方向转换源，也是先做NAT后匹配策略。因此原理一样。


## 测试结果：

ping通即可，不额外提供。

## 说明： 


重点是NAT会改变vrf，以及NAT和策略的先后关系。