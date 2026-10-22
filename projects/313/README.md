**静态路由track与BFD联动配置举例**

**标签：**

**Track**

**BFD**

**需求：**

Router A、Router B、Router C和Router
D连接了20.1.1.0/24和30.1.1.0/24两个网段，在路由器上配置静态路由以实现两个网段的互通，并配置路由备份以提高网络的可靠性。

·下一跳为Router B的静态路由优先级高，作为主路由。该路由可达时，Router
A通过Router B将报文转发到30.1.1.0/24网段。

·下一跳为Router C的静态路作为备份路由。

·在Router
A上通过静态路由、Track与NQA联动，实时判断主路由是否可达。当主路由不可达时，备份路由生效，Router
A通过Router C将报文转发到30.1.1.0/24网段。

同样地，Router D作为30.1.1.0/24网段内主机的缺省网关，在Router
D上存在两条到达20.1.1.0/24网段的静态路由，下一跳分别为Router B和Router
C。这两条静态路由形成备份，其中：

· 下一跳为Router B的静态路由优先级高，作为主路由。该路由可达时，Router
D通过Router B将报文转发到20.1.1.0/24网段。

· 下一跳为Router C的静态路作为备份路由。

·在Router
D上通过静态路由、Track与NQA联动，实时判断主路由是否可达。当主路由不可达时，备份路由生效，Router
D通过Router C将报文转发到20.1.1.0/24网段。

**其中，在Router A和Router
B上配置环回口分别代表20.1.1.1/24和30.1.1.1/24的业务。RouterA上存在环回口1.1.1.1，Roouter
B上存在环回口2.2.2.2，这两个环回口地址是用来建立BFD
Control会话，为跨设备的多跳BFD会话。**

**实验步骤：**

A,B,C,D均配置静态路由打通
，其中在A和D上面配置静态路由联动BFD（control模式）

**测试结果：**

\# 显示Router A上BFD探测结果。

![](./Media//image1.png)


显示Router B上BFD探测结果：

![](./Media//image2.png)


可以看到会话在1.1.1.1和2.2.2.2之间建立，为control模式。

查看A的路由表如下：

![](./Media//image3.png)


![](./Media//image4.png)


路由显示，流量路径为A-B-D。

此时，关闭RouterA的GE0/0接口，

RouterA 上BFD会话没有

![](./Media//image5.png)


RouterD上BFD会话为down：

![](./Media//image6.png)


此时查看RouterA和RouterD上的路由如下：

![](./Media//image7.png)


![](./Media//image8.png)


可以看到RouterA ，RouteB可以互通：

![](./Media//image9.png)


**说明：**

1、本实验用的模拟器为MSR36-20，设置内存为默认。

（如果用的是vsr-88或其他需要自己调整内存的设备，请注明设备所设置的内存是多少。）

2、本实验用的路由器版本为默认。

（默认是B75分支，如果所用的vmdk版本是B59或者其他定制版本，请说明，并告知vmdk放在什么地方可共享，如：本实验所用设备vmdk版本为B59，vmdk文件及更换版本操作方法均放在ftp，路径为：新版本已上传FTP：/01-IP网络产品/03-中低端路由器（AR、MSR、ICG、VG、LA）/99
临时目录/模拟器/模拟器版本/）

3、建议工程模拟器设备名称为体统默认。
