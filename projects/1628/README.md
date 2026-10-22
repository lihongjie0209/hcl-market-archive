# 工程名称

防火墙用带宽策略实现父子通道

## 需求：
防火墙做带宽策略，并且利用父子通道模式，单独控制部分设备速率，并且限制其他设备不超过总速率。

防火墙做所有设备网关，外网设备2.2.2.1/24和3.3.3.1/24模拟外网设备，并且3.3.3.1/24限速10kb，其他设备20kb。内网使用4.4.4.1/24做FTP服务器。


## 实验步骤：
1.配置IP和路由。

2.配置安全策略和安全域，本例中外网放入untrust，内网放入trust。策略非重点，因此全通。

3.配置对象组，将3.3.3.1放入。

4.配置带宽策略，子通道10kb，父通道20kb。

5.4.4.4.1开启ftp等相关配置。


## 测试结果：

可以看到两个设备速率相差接近2倍，并且速率都被防火墙成功限制。
ftp> get 1.cfg

1.cfg already exists. Overwrite it? [Y/N]:y

227 Entering Passive Mode (4,4,4,1,233,14)

150 Accepted data connection

.
226 File successfully transferred

2581 bytes received in 32.670 seconds (79 bytes/s)



ftp> get 1.cfg

1.cfg already exists. Overwrite it? [Y/N]:y

227 Entering Passive Mode (4,4,4,1,63,90)

150 Accepted data connection

.
226 File successfully transferred

2581 bytes received in 48.017 seconds (54 bytes/s)



## 说明： 

无
