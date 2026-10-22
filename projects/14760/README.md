# 工程名称

Router ID的选取配置举例

## 需求：
RTA和RTB在area0建立邻居、RTB和RTC在area1建立ospf邻居，并且互相学习到loopback接口对应的路由信息，。本实验的主要内容是通过观察Router ID的变化，掌握Router ID的选择方法。

## 实验步骤：

1、	配置RTA、RTB和RTC的接口地址和环回口地址；
2、	配置RTA、RTB和RTC的ospf邻居；
3、	测试Router ID的选取。

## 测试结果：
配置完成后，RTB的Router ID为loopback 0，此时删除RTB的loopback 0地址，观察Router ID没有变化。

![image.png](./Media/image.png)
![image.png](./Media/image.png)

通过命令重启ospf进程，发现Router ID改变了。在重启了进程之后，Router ID才会变化，此时选择物理接口最大的ip地址作为Router ID
![image.png](./Media/image.png)
![image.png](./Media/image.png)
## 说明： 


