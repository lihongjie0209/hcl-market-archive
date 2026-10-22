# 工程名称
通过telnet登录AC设备典型配置举例

## 需求：
AC2设备与AC1设备通过IP网络相连且路由可达。管理员可以使用telnet方式登录AC1设备。


## 实验步骤：
1、AC上开启telnet server功能
#
 telnet server enable

2、AC上配置telnet用户名为admin，认证密码为h3c123456789，服务类型为telnet
3、连接AC2设备，配置与AC同网段的ip地址192.168.1.2

## 测试结果：
在AC2命令行内telnet设备AC1的IP地址，显示登录成功。
![企业微信截图_16678889131211.png](./Media/企业微信截图_16678889131211.png)
![222.png](./Media/222.png)
## 说明： 


