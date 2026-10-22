**标签：**

nat server

nat outbound

双向nat

**需求：**

虚拟机PC_3和PC_4同网段，但是需要用nat server
global地址去访问，由于同网段，如果不做源地址转换，回程PC_4会直接通过交换机发给PC_3，因此需要来回流量都过防火墙，普通的nat
hairpin能实现但是有诸多限制，因此使用nat server加NAT
outbound的方式实现二次NAT。

**实验步骤：**

1、配置PC_3、PC_4和F1060_1的接口地址，详细步骤略。

2、防火墙配置NAT server和NAT outbound实现二次NAT。

![](./Media//image1.png)


3、防火墙接口加入安全域并且放通策略，注意二次NAT放通策略原则，目的转换是转换后匹配策略，源转换是转换前就匹配策略，因此策略上是放通1.1.1.2-1.1.1.3的地址对象组。

![](./Media//image2.png)


![](./Media//image3.png)


**测试结果：**

用PC_3ping3.3.3.3的global地址，可以ping通。

![](./Media//image4.png)


**说明：**

1、本实验用的模拟器为F1060内存为默认。

（如果用的是F1090或其他需要自己调整内存的设备，请注明设备所设置的内存是多少。）

2、本实验用的交换机为S5820内存为默认。
