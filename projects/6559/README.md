# BGP组网非Add-path场景路由选路配置举例

## 需求：

1.  所有交换机运行BGP协议，XAZ1和XAZ2之间建立IBGP连接，AZC、XAZ和MS设备之间建立EBGP连接。

2.  XAZ1和XAZ2发布相同网段的路由，XAZ1发布的路由携带团体属性，XAZ2发布的路由不携带团体属性。

3.  AZC配置路由策略，仅发布携带团体属性的路由。

4.  观察MS是否通过AZC学习到XAZ发布的路由，从而验证AZC将ECMP路由中的哪条选作为最优路由。

## 实验步骤：

1.  将XAZ1和XAZ2配置为一组IBGP对等体，XAZ、AZC、MS之间建立EBGP连接；

2.  在XAZ1和XAZ2上配置相同前缀的静态路由，通过BGP协议发布给AZC设备，XAZ1设备发布路由时携带团体属性

3.  在AZC上配置路由策略，发布路由给MS时仅发布携带团体属性的路由；

4.  观察MS是否可以学习到路由。

5.  Reset XAZ设备的bgp邻居状态，重新观察实验结果。

## 测试结果：

1、查看BGP邻居状态，可以看到XAZ1和XAZ2为IBGP，XAZ、AZC、MS之间为EBGP连接：

![](./Media//image1.png)


![](./Media//image2.png)


![](./Media//image3.png)


![](./Media//image4.png)


2、AZC设备学习XAZ1和XAZ2发布的相同前缀等价路由

![](./Media//image5.png)


查看路由详细信息，从XAZ1设备学习的路由携带团体属性，从XAZ2设备学习的路由不带团体属性

![](./Media//image6.png)


 3、 查看MS学习到的路由信息，携带团体属性。

可以说明AZC将XAZ1发布的携带团体属性的路由发布给了MS

![](./Media//image7.png)


4、 reset XAZ1的bgp邻居，使其重新发布路由

AZC设备依然能学习等价路由，但MS设备已经学习不到路由。

![](./Media//image8.png)


![](./Media//image9.png)


结论：

AZC收到等价路由发给MS时，优先选择先接收的路由，团体属性不参与BGP路由选路。

## 说明： 

1、本实验用的模拟器为S6850，设置内存为默认。

2、本实验用的交换机版本为默认版本。
