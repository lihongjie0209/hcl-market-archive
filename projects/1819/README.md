# 工程名称

防火墙旁路模式实现SSL双向代理

## 需求：

旁路部署防火墙，并且实现SSL双向代理，交换机作为所有设备网关，进行报文转发。

防火墙1做负载均衡，地址为1.1.1.1/24，vsip为7.7.7.7，snat地址池为6.6.6.6

内网FW4和FW5做HTTPS服务器，提供web界面。地址4.4.4.1/24 和5.5.5.1/24

PC做访问客户端。

## 实验步骤：
1.配置地址和路由。

2.配置FW4和FW5的https服务、安全策略和安全域。策略放置全通，模拟服务器即可。

3.FW1配置实服务器。实服务组和虚服务器。

4.配置持续性、源地址池和健康性检测。

5.使用证书，创建PKI域并导入，创建SSL服务器策略和SSL客户端策略。证书可以参考受诫礼漏洞导出。

6.PC配置明细路由。


## 测试结果：

测试可以打开并且display loadbalance connections，可以看到负载情况。

![web界面](./Media/7777.jpg) 

[H3C]display  loadbalance  connections

Slot 1:

Client side:                    State   Server Side:                    State

Any          <--> Any           N/A     6.6.6.6/1034 <--> 4.4.4.1/443   TIMEWT

Any          <--> Any           N/A     6.6.6.6/1035 <--> 5.5.5.1/443   TIMEWT

Any          <--> Any           N/A     6.6.6.6/1033 <--> 5.5.5.1/443   TIMEWT

Any          <--> Any           N/A     6.6.6.6/1032 <--> 4.4.4.1/443 

## 说明： 

FW1新建了一个web用户，http/asdfqwer1234
