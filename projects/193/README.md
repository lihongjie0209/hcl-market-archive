# OSPF基本功能配置举例

## 需求：

1.  所有的路由器都运行OSPF，并将整个自治系统划分为3个区域。

2.  其中Router A和Router B作为ABR来转发区域之间的路由。

3.  配置完成后，每台路由器都应学到AS内的到所有网段的路由。

## 实验步骤：

1.  配置各接口的IP地址

2.  配置OSPF基本功能

## 测试结果：

查看Router A的OSPF邻居。

![](./Media//image1.png)


查看Router A的OSPF路由信息。

![](./Media//image2.png)


在Router A上使用Ping测试连通性。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
