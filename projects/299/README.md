**IPsec_手动配置SPI**

# 标签：

**手工**

# 需求：

RTA和RTB跨越INTERNET建立ipsec隧道，隧道采用手工方式建立。

# 实验步骤：

手工建立的ipsec隧道，不需要用流量触发。应分别设置inbound和outbound两个方向的IPsec
SA参数，且保证每一个方向上的IPsec SA的唯一性：对于出方向IPsec
SA，必须保证三元组（对端IP地址、安全协议、SPI）唯一；对于入方向IPsec
SA，必须保证SPI唯一。本端和对端IPsec
SA的SPI及密钥必须是完全匹配的。即，本端的入方向IPsec
SA的SPI及密钥必须和对端的出方向IPsec
SA的SPI及密钥相同；本端的出方向IPsec
SA的SPI及密钥必须和对端的入方向IPsec SA的SPI及密钥相同

# 测试结果：

![](./Media//image1.png)


![](./Media//image2.png)


**说明：**

1、本实验用的模拟器为MSR36-20，设置内存为默认。

（如果用的是vsr-88或其他需要自己调整内存的设备，请注明设备所设置的内存是多少。）

2、本实验用的路由器版本为默认。

（默认是B75分支，如果所用的vmdk版本是B59或者其他定制版本，请说明，并告知vmdk放在什么地方可共享，如：本实验所用设备vmdk版本为B59，vmdk文件及更换版本操作方法均放在ftp，路径为：新版本已上传FTP：/01-IP网络产品/03-中低端路由器（AR、MSR、ICG、VG、LA）/99
临时目录/模拟器/模拟器版本/）

3、建议工程模拟器设备名称为体统默认。
