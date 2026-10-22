# 工程名称

防火墙实现普通带宽限速

## 需求：
过防火墙进行限速，所有流量最大10kb。
路由器1.1.1.1/24模拟用户，2.2.2.1/24的路由器模拟FTP服务器。


## 实验步骤：
1.配置IP。

2.配置路由。

3.配置安全策略和安全域，由于策略不是本次实验重点，因此放置全通。

4.配置带宽策略，全流量10kb。

5.2.2.2.1路由器开启FTP服务，并且复制startup文件为1.cfg。


## 测试结果：
测试配置和不配置两种情况，发现速率相差极大，确认可以进行限制。

ftp> get 1.cfg

227 Entering Passive Mode (2,2,2,1,110,123)

150 Accepted data connection

.
226 File successfully transferred

2237 bytes received in 19.957 seconds (112 bytes/s)

ftp> get 1.cfg

1.cfg already exists. Overwrite it? [Y/N]:y

227 Entering Passive Mode (2,2,2,1,138,166)

150 Accepted data connection

.
226 File successfully transferred

2237 bytes received in 0.001 seconds (2.13 Mbytes/s)




## 说明： 

普通防火墙和路由器。
