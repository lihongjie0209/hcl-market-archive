# 工程名称
通过https登录ACweb界面手工注册AP上线典型配置举例


## 需求：
Host和设备通过IP网络相连且路由可达。管理员可以通过Host使用HTTPS方式登录设备，以便通过Web页面来配置AP注册上线。


## 实验步骤：
1、AC上开启https功能
2、AC上配置web用户名为admin，认证密码为h3c123456789，服务类型为https
3、连接本地host主机，配置与AC同网段的ip地址192.168.1.11
4、起控制vlan并放通
![1](./Media/1.png) 
![2](./Media/2.png) 
![3](./Media/3.png) 
5、AC上配置DHCP 地址池
![4](./Media/4.png) 
![5](./Media/5.png) 
![6](./Media/6.png) 
6、配置无线服务模板
![7](./Media/7.png) 
7、配置AP
![8](./Media/8.png) 




## 测试结果：
web上监控设备显示AP上线
![9](./Media/9.png) 

同时AC上也有AP上线记录
![10](./Media/10.png) 


## 说明： 


