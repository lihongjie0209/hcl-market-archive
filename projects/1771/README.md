# SNMP剔除某一OID节点配置举例

## 需求：

网络中不允许日志服务器通过snmp访问SW1 hh3cSysCurCFGFileIndex节点。

##  实验步骤：

1.  使能SNMP功能

2.  过滤相应mib节点

## 测试结果：

MIB-VIEW中已经成功过滤hh3cSysCurCFGFileIndex节点。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
