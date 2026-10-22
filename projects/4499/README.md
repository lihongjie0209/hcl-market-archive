# 工程名称
防火墙对外访内的流量进行限速。


## 需求：

防火墙做NAT server，并且控制对访问服务器的流量进行限速。

## 实验步骤：
1.配置路由器的地址和路由。

2.开启路由器的ftp服务，创建用户并且copy一份配置文件。本实验的用户名密码为ftp/asdfqwer1234.

3.配置防火墙地址。

4.配置NAT。

5.配置安全策略和安全域，放通untrust到trust，左边为untrust，右边为trust。

6.配置带宽策略，限制8kb。


## 测试结果：
<H3C>ftp 3.3.3.3

Press CTRL+C to abort.

Connected to 3.3.3.3 (3.3.3.3).

220 FTP service ready.

User (3.3.3.3:(none)): ftp

331 Password required for ftp.

Password:

230 User logged in.

Remote system type is UNIX.

Using binary mode to transfer files.

ftp> get test.cfg

test.cfg already exists. Overwrite it? [Y/N]:y

227 Entering Passive Mode (3,3,3,3,134,41)

150 Accepted data connection

.
226 File successfully transferred

2581 bytes received in 54.726 seconds (47 bytes/s)




## 说明： 

注意带宽策略是匹配转换前的流量，因此带宽策略中匹配的地址是global地址。
