# HDLC基本组网配置举例

**标签：**

**HDLC**

**Pos**

## 需求

路由器Router A和Router B通过POS接口相连，要求运行HDLC协议。

## 实验步骤：

进入PoS接口，修改链路协议为HDLC，并配置相应的IP地址。

Router A、Router B的配置：

配置Router A

\<RouterA\> system-view

\[RouterA\] interface pos 1/0/2

\[RouterA-Pos2/2/0\] clock master

\[RouterA-Pos2/2/0\] link-protocol hdlc

\[RouterA-Pos2/2/0\] ip address 12.1.1.1 30

\[RouterA-Pos2/2/0\] quit

配置Router B

\<RouterB\> system-view

\[RouterB\] interface pos 1/0/2

\[RouterB-Pos2/2/0\] link-protocol hdlc

\[RouterB-Pos2/2/0\] ip address 12.1.1.2 30

## 测试结果：

配置完成后Router A和Router B可以互相ping通。以Router A的显示为例。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为DIY-Device，设置内存为默认。

2、本实验用的路由器版本为默认。
