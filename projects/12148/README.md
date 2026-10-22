# Server2基础功能配置



## 1. Server2设备基础介绍
### 设备登录：
账号：root

密码：123456
### 设备配置：
Server2可通过命令行与页面方式配置。
命令行配置方式基于Linux基础命令与Uci指令为主。

页面配置方式可通过右键设备-“配置”打开页面，初始页面地址：[http://192.168.56.4/](http://192.168.56.4/) 

**若添加多台设备，请通过以下命令修改其他Server2设备配置页面地址**。此时，右键“配置”功能无法指向新地址：

uci set network.lan.ipaddr=192.168.56.xxx

uci commit

reboot

### 设备连线：
Server2默认提供六个接口供设备连接

![interface](./Media/092408.png) 

接口连接后需要通过管理页面：网络-接口去配置相应网卡信息

![networkInterfaces](./Media/092458.png) 



## 2. 基础功能介绍：
### 2.1 状态：
状态中主要展示设备各项基础信息
### 2.2 系统：
系统中主要为系统级别的功能修改，例如时间设置、语言设置、修改密码等。

![system](./Media/093919.png) 

“软件包”可供您安装额外需求的功能软件，但请注意，该设备使用您本身宿主机网络访问外部网络，软件包在线安装仅在您宿主机网络可访问对应镜像网站的情况下可用，网络不可用的情况下可上传安装包使用。

![software](./Media/093856.png) 


“备份与升级”您可将该设备配置导出与恢复

![bak](./Media/093919.png) 
### 2.3 网络：
网络中主要设置网络相关内容
![network](./Media/094152.png) 


## 3. HCL 功能：
### 3.1 终端
终端可在页面进行命令行访问的

![console](./Media/094633.png) 

### 3.2 TFTP
提供TFTP服务

![tftp](./Media/094610.png) 


![tftptest](./Media/094912.png) 

### 3.3 FTP
提供FTP服务
![fto](./Media/095247.png) 

![ftptest](./Media/095109.png) 


### 3.4 DHCP
对于配置静态IP协议的接口可以开启DHCP服务

![dhcp1](./Media/095431.png) 

![dhcp2](./Media/095512.png) 

![dhcp3](./Media/095730.png) 

在“状态”-“概览”中可以看到已分配的DHCP信息

![dhcp4](./Media/095919.png) 

### 3.5 DNS
提供DNS解析配置

MSR36处需配置DNS Server 信息

![dns1](./Media/100105.png) 


![dns2](./Media/100206.png) 

![dns3](./Media/100239.png) 
### 3.6 Radius
提供Radius认证服务

SSH-Server配置见配置文件，SSH-Client登录SSH-Server时通过Radius服务验证用户名密码

Radius用户页面设置用户名密码

![radius1](./Media/100645.png) 

Radius客户页面设置连接的访问客户端

![radius2](./Media/100713.png) 

验证：

![radius3](./Media/101152.png) 


### 3.7 组播
**3.7.1** 组播源

组播源为组播发送者，使用前请预先添加对应接口

“组播组”填写对应的组播组IP

“绑定的IP地址”填写发送组播报文网卡的IP地址

![group1](./Media/105610.png) 

**3.7.2** 组播接收者

使用前请预先添加对应接口

“组播组”填写对应的组播组IP

“接口”请填写接收与绑定组播的的网卡接口

![group2](./Media/110045.png) 


启用后可在/tmp/iperf中查看接收结果

![group3](./Media/110037.png) 





### 3.8 客户端
**3.8.1** 802.1x客户端
802.1x服务端配置见802.1x-Server配置

客户端需提前通过“网络”-“接口”配置接口信息

![8021](./Media/102234.png) 

验证：

启用前

![80212](./Media/102544.png) 

启用后
![80213](./Media/102954.png) 

![80214](./Media/103140.png) 

**3.8.2** PPPoE客户端
PPPoE配置见PPPoE-Server配置

连线后再配置界面中添加对应接口，配置PPPoE协议
![pppoe1](./Media/112925.png) 

![pppoe2](./Media/112935.png) 

验证：

![pppoe3](./Media/112943.png) 


### 3.9 日志服务
提供日志服务器，在设备测指定日志服务即可查看对应日志

![log1](./Media/133958.png) 

![log2](./Media/134047.png) 



## 特殊说明： 
**HCL保存工程只保存Server2设备已有内容的配置文件，若您后续自定义了该设备内容（安装新软件等），请注意备份新增内容，这部分内容不会被HCL工程保存**
