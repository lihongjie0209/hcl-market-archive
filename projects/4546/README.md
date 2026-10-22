# 工程名称

防火墙在VRF隔离的情况下，配置带宽限速，限制外网访问内网FTP服务器。

## 需求：

防火墙做VRF隔离，实现不同区域使用相同地址，并且配置带宽限速，限制外网访问内网FTP服务器的速率。限速为8kb，

## 实验步骤：

1.配置路由器的地址和路由。

2.开启ftp服务，并且保存配置，copy一份startup.cfg文件，MSR3命名为1.txt，MSR5命名为2.txt

3.防火墙创建VRF，1和2.

4.防火墙接口绑定VRF，并且配置地址和路由。

5.配置带宽策略，只限制untrust到trust。

6.配置安全策略和安全域，左边都为untrust，右边为trust，放通untrust-trust，并且只放通FTP服务。注意安全策略关心VRF，因不同VRF需要配置不同的策略。

## 测试结果：

测试VPN1访问VPN2。测试限速正常。

<H3C>ftp 2.2.2.1

Press CTRL+C to abort.

Connected to 2.2.2.1 (2.2.2.1).

220 FTP service ready.

User (2.2.2.1:(none)): ftp

331 Password required for ftp.

Password:

230 User logged in.

Remote system type is UNIX.

Using binary mode to transfer files.

ftp> get 1.txt

227 Entering Passive Mode (2,2,2,1,48,74)

150 Accepted data connection

.

226 File successfully transferred

2552 bytes received in 9.038 seconds (282 bytes/s)





测试公网VRF，限速正常。
<H3C>ftp 2.2.2.1

Press CTRL+C to abort.

Connected to 2.2.2.1 (2.2.2.1).

220 FTP service ready.

User (2.2.2.1:(none)): ftp

331 Password required for ftp.

Password:

230 User logged in.

Remote system type is UNIX.

Using binary mode to transfer files.

ftp> get 2.txt

227 Entering Passive Mode (2,2,2,1,53,126)

150 Accepted data connection

.

226 File successfully transferred

2581 bytes received in 32.479 seconds (79 bytes/s)


## 说明： 
1.由于VRF是路由隔离的，因此即使设备是直连，但是VRF不一样，也需要写路由。

2.带宽策略不关心VRF，因此配置后其实所有VRF都会被限速，如果需要不同VRF进行单独控制，那么只能将接口放入不同安全域，或者VRF下配置不同地址，策略明细到地址。



