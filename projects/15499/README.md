# 工程名称
通过禁止弱信号接入防止弱信号终端接入AP射频 

## 需求：
在AP的Radio 1视图下绑定服务模板1，并配置禁止弱信号接入且设置RSSI阈值为25，防止弱信号终端接入。 

## 实验步骤：
1、AC上分别配置服务模板1和2。 
# 
wlan service-template 1 
 ssid mike 
 vlan 200 
 service-template enable 
# 
  
2、在AC上的ap1视图下，分别给ap1的radio 1绑定服务模板1， 
# 
wlan ap ap2 model WA6320-HCL 
 serial-id H3C_AC-C6-76-44-02-00 
 vlan 1 
 radio 1 
  radio enable 
  option client reject enable rssi 25 
  service-template 1 
 radio 2 
  option client reject enable rssi 25 
 gigabitethernet 1 
# 


## 测试结果：
1. 将终端放置在AP信号覆盖的靠近边缘区域，在AP的Radio 1下配置禁止弱信号接入，RSSI阈值设定为25，此时终端无法接入； 
2. 去掉AP的Radio 1下配置的进行弱信号接入命令，此时终端再次连接能正常接入： 
![weaksignalreject](./Media/weaksignalresult.png) 


## 说明： 
无特殊说明

