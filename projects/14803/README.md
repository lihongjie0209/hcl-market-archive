# 工程名称

对端设备AS号与本端peer不一致导致BGP建立失败

## 需求：
测试对端设备AS号与本端peer不一致导致BGP状态

## 实验步骤：
1.配置接口ip
2.配置EBGP
3.测试AS号不一致的现象


## 测试结果：
当对端设备AS号与本端peer不一致导致时邻居一直在idle状态
![image.png](./Media/image.png)


![image.png](./Media/image.png)

修改一致后正常：
![image.png](./Media/image.png)

## 说明： 


