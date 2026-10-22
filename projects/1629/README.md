# 工程名称

防火墙配置每IP限速10kb

## 需求：
过防火墙后每个设备都只能有10kb的速度下载内网ftp文件。

防火墙做限速，内网用路由器2.2.2.1/24模拟FTP服务器，外网3.3.3.1/24和4.4.4.1/24模拟外网设备。防火墙做网关。


## 实验步骤：
1.配置IP和路由

2.配置安全策略和安全域，外网放入untrust，内网放入trust。重点非策略，因此直接放了全通。

3.配置带宽策略限速。




## 测试结果：

两台设备同时去获取文件，可以看到速率一致，都被限速成功。

ftp> get 1.cfg

227 Entering Passive Mode (2,2,2,1,196,57)

150 Accepted data connection

.
226 File successfully transferred

2581 bytes received in 32.744 seconds (79 bytes/s)


ftp> get 1.cfg

227 Entering Passive Mode (2,2,2,1,50,56)

150 Accepted data connection

.
226 File successfully transferred

2581 bytes received in 32.741 seconds (79 bytes/s)



## 说明： 

无
