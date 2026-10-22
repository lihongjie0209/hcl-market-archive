**标签：**

IPSEC

FQDN


**需求：**

MSR36_20_2作为分支与F1090_3的总部建立IPsec隧道，使得内部主机PC_1与PC_4能够正常通信。

**实验步骤：**

1.  为内部主机PC_1与PC_4分配好IP地址，网关分别设置到MSR36_20_2和F1090_3。

2.  MSR36_20_2与F1090_3建立中心分支方式的IPsec隧道，使用FQDN方式进行身份认证。

3.  中间链路相关路由打通，并且F1090_3上放通安全策略。

**测试结果：**

查看MSR36_20_2 ike sa和ipsec sa信息，可以看到已正常建立

![](./Media//image2.png)


![](./Media//image3.png)


查看F1090_3 ike sa和ipsec sa信息，可以看到已正常建立

![](./Media//image4.png)


![](./Media//image5.png)


PC_1去ping PC_4正常

![](./Media//image6.png)


**说明：**

1.  F1090建议设置内存为512M以上。
