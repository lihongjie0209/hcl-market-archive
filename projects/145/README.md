**标签：**

SSLVPN

INODE拨号

组网

![](./Media//image1.png)


**需求**

Host_1通过iNode软件拨号SSL VPN连接到F1090_2，实现对内网PC_3的访问。

**实验步骤：**

1.  为各个设备分配好IP地址。

2.  在F1090_2上配置SSL VPN功能，并放通对应的安全策略。

3.  在Host_1上安装好iNode软件，实现SSL VPN拨号功能。

**测试结果：**

在Host_1上使用iNode拨号，SSL VPN隧道可以正常建立。

![](./Media//image2.png)


通过查看到PC_3网段的路由下一跳指向F1090_2上的SSL VPN AC口地址。

![](./Media//image3.png)


Host_1向PC_3 ping测试正常可达，SSL VPN功能验证正常。

![](./Media//image4.png)


同时在F1090_2可以看到对应的会话信息。

![](./Media//image5.png)


**说明：**

1.  F1090建议设置内存为512M以上。

2.  Host就是所在的物理PC，使用虚拟网卡进行连接。Windows系统自带的防火墙会影响网卡收发报文，务必先关闭Windows
    Defender防火墙。IE代理会拦截Web界面，使用防火墙Web界面务必关闭IE代理。

![](./Media//image6.png)


3，HCL文件中F1090_2由于密码复杂度要求已修改为Admin@h3c!
