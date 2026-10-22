# 短静态ARP表项配置举例

## 需求：

网络管理员需要通过某种方法来防止恶意用户对Device
B进行ARP攻击，增加Device B和Device A通信的安全性。如果Device
A的IP地址和MAC地址是固定的，则可以通过在Device
B上配置静态ARP表项的方法，防止恶意用户进行ARP攻击。

##  实验步骤：

1.  创建原始vlan和ip地址

2.  在设备上进行arp静态绑定

## 测试结果：

通过display arp查看短静态arp表项信息

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
