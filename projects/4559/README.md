# 工程名称

通过静态路由方式实现跨VPN互通 

## 需求：
#Switch A下联PC，位于VPN 1，Switch A、Switch B直连，SwitchA出口是VPN 2，现在需要配置静态路由实现VPN 1下的PC与Switch B上的 loopback 199地址199.1.1.1互通。 


## 实验步骤：

  
(1)     配置IP地址和单播路由协议 
# 在PC1配置IP地址192.168.1.2，指定网关地址为SW1上的int vlan 100的IP：192.168.1.1。
  
 
￼  配置Switch A 
# 创建VPN 1 

ip vpn-instance 1 

 route-distinguisher 100:1 

 vpn-target 100:1 import-extcommunity 

 vpn-target 100:1 export-extcommunity 

#配置VPN 2。 
  
ip vpn-instance 2 

 route-distinguisher 200:1 

 vpn-target 200:1 import-extcommunity 

 vpn-target 200:1 export-extcommunity 

 # 
 address-family ipv4 

  route-replicate from vpn-instance 1 protocol direct advertise 

 # 配置VPN 1和VPN2分别绑定IP地址： 

interface Vlan-interface100 

 ip binding vpn-instance 1 

 ip address 192.168.1.1 255.255.255.0 

# 
  
interface Vlan-interface200 

 ip binding vpn-instance 2 

 ip address 200.1.1.1 255.255.255.0 

  
# 配置在VPN1中访问199.1.1.1的静态路由，下一跳是VPN2的下一跳地址： 
  
ip route-static vpn-instance 1 199.1.1.1 32 vpn-instance 2 200.1.1.2 

  
# 配置在VPN2中访问192.168.1.2的静态路由，下一跳是VPN1的下一跳地址：
 
ip route-static vpn-instance 2 192.168.1.2 32 vpn-instance 1 192.168.1.2 

  
(3)     配置Switch B 
# 配置互联地址及loopback 199测试IP： 
  
interface LoopBack199 

 ip address 199.1.1.1 255.255.255.255 

# 
interface Vlan-interface200 

 ip address 200.1.1.2 255.255.255.0 

  
# 配置互联口允许VLAN 200通过： 
interface FortyGigE1/0/53 

 port link-mode bridge 

 port link-type trunk 

 port trunk permit vlan 1 200 

#配置到SWA下192.168.1.0/24网段的静态路由： 

ip route-static 192.168.1.0 24 200.1.1.1 

  
## 测试结果：

# 查看Switch A上VPN 1里面存在VPN 2的199.1.1.1的静态路由。 
￼ 
# 查看Switch A上VPN 2上存在到VPN 1 里面192.168.1.2的静态路由： 
￼ 
  
验证PC：192.168.1.2地址与SWB上的loop199地址199.1.1.1之间可以互访。 
  
￼ 
￼ 
￼ 
  
￼ 

## 说明： 
1、本实验用的模拟器为S6850，设置内存为默认。 
2、本实验用的交换机版本为默认版本。 

