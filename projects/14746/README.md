# 工程名称

BGP的MD5认证配置举例

## 需求：

所有交换机均运行BGP协议。要求Switch B和Switch C之间建立IBGP连接，并且建立BGP邻居时需要配置BGP的MD5认证。只有两台设备配置的密钥相同时，才能建立TCP连接，从而避免与非法的BGP路由器建立TCP连接。

## 实验步骤：

1、	配置各接口的IP地址；
2、	建立IBGP邻居，并配置BGP的MD5认证。

## 测试结果：
配置完成后，当两台设备配置的MD5密钥相同时ibgp邻居正常建立。

![image.png](./Media/image.png)

## 说明： 


