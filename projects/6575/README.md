# 工程名称：
DHCP动态分配地址典型配置举例

## 需求：
作为DHCP服务器的AC为AP和客户端动态分配IP地址

AC的两个VLAN接口，VLAN接口10和VLAN接口20的地址分别为10.10.10.10/24和20.20.20.20/24

为AP分配10.10.10.0/24网段的IP地址，为Client分配20.20.20.0/24网段的IP地址

## 实验步骤：

(1) 配置端口属于VLAN及对应VLAN接口的IP地址

---创建vlan10和vlan20

[AC] vlan 10

[AC-vlan10] quit

[AC] vlan 20

[AC-vlan20] quit

---将与AP连接的接口加入VLAN10、VLAN20中。

[AC] interface gigabitethernet 1/0/1

[AC-GigabitEthernet1/0/2] port link-type trunk

[AC-GigabitEthernet1/0/2] port trunk permit vlan 10 20

[AC-GigabitEthernet1/0/2] port trunk pvid vlan 10

[AC-GigabitEthernet1/0/2] quit

---配置VLAN10和VLAN20接口的IP地址。

[AC] interface vlan-interface 10

[AC-Vlan-interface10] ip address 10.10.10.10 24

[AC-Vlan-interface10] quit

[AC] interface vlan-interface 20

[AC-Vlan-interface20] ip address 20.20.20.20 24

[AC-Vlan-interface20] quit

(2) 配置无线服务

---配置无线服务模板并把服务模板加入VLAN20中。

[AC] wlan service-template h3c

[AC-wlan-st-service] ssid h3c

[AC-wlan-st-service] vlan 20

[AC-wlan-st-service] service-template enable

[AC-wlan-st-service] quit

---配置AP。

[AC] wlan ap ap1 model WA6320-HCL

[AC-wlan-ap-ap1] serial-id H3C_78-C3-A1-77-02-00

[AC-wlan-ap-ap1] radio 1

[AC-wlan-ap-ap1-radio-1] service-template h3c

[AC-wlan-ap-ap1-radio-1] radio enable

[AC-wlan-ap-ap1-radio-1] quit

[AC-wlan-ap-ap1] quit

(3) 配置DHCP服务

---开启DHCP服务。

[AC] dhcp enable

---配置DHCP地址池vlan10

[AC] dhcp server ip-pool vlan10

[AC-dhcp-pool-vlan10] network 10.10.10.0 mask 255.255.255.0

[AC-dhcp-pool-vlan10] quit

---配置DHCP地址池vlan20

[AC] dhcp server ip-pool vlan20

[AC-dhcp-pool-vlan20] network 20.20.20.0 mask 255.255.255.0

[AC-dhcp-pool-vlan20] quit

## 测试结果：

配置完成后，AP和客户端可以从DHCP服务器AC申请到相应网段的IP地址和网络配置参数。通过display dhcp server ip-in-use命令可以查看DHCP服务器为客户端分配的IP地址。

![1](./Media/企业微信截图_16681509994195.png) 


## 说明： 

无