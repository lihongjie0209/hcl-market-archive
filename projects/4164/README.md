# 静态路由、Track与Echo报文方式的BFD会话联动配置举例（交换）

**标签：**

静态路由

Track

Echo

BFD

**组网需求：**

Switch A、Switch B和Switch
C在交换机上配置静态路由以实现两个网段的互通，并配置路由备份以提高网络的可靠性。

**实验步骤：**

1.  配置各VLAN接口的IP地址。

2.  配置Switch
    A：①配置到达30.1.1.0/24网段的静态路由：下一跳地址为10.2.1.2，优先级为缺省值60，该路由与Track项1关联。②配置到达30.1.1.0/24网段的静态路由：下一跳地址为10.3.1.3，优先级为80。③配置BFD
    Echo报文的源地址为10.10.10.10。④创建和Echo报文方式的BFD会话关联的Track项1，并进入Track视图，检测Switch
    A是否可以与静态路由的下一跳Switch B互通。

3.  配置Switch
    B：①配置到达20.1.1.0/24网段的静态路由：下一跳地址为10.2.1.1，优先级为缺省值60，该路由与Track项1关联。②配置到达20.1.1.0/24网段的静态路由：下一跳地址为10.4.1.3，优先级为80。③配置BFD
    echo报文的源地址为1.1.1.1。④创建和BFD会话关联的Track项1，并进入Track视图，检测Switch
    B是否可以与静态路由的下一跳Switch A互通。

4.  配置Switch
    C：①配置到达30.1.1.0/24网段的静态路由：下一跳地址为10.4.1.2。②配置到达20.1.1.0/24网段的静态路由：下一跳地址为10.3.1.1。

**测试结果：**

1.  显示Switch A上Track项的信息。

![](./Media//image1.png)


2.  显示Switch A的路由表。

![](./Media//image2.png)


以上显示信息表示，Echo报文方式的BFD会话检测的结果为下一跳地址10.2.1.2可达（Track项状态为Positive），主路由生效，Switch
A通过Switch B将报文转发到30.1.1.0/24网段。

3.  在Switch B上删除VLAN接口2的IP地址。

> \<SwitchB\> system-view
>
> \[SwitchB\] interface vlan-interface 2
>
> \[SwitchB-Vlan-interface2\] undo ip address

4.  显示Switch A上Track项的信息

![](./Media//image3.png)


5.  显示Switch A的路由表。

![](./Media//image4.png)


以上显示信息表示，Echo报文方式的BFD会话检测的结果为下一跳地址10.2.1.2不可达（Track项状态为Negative），备份路由生效，Switch
A通过Switch C和Switch B将报文转发到30.1.1.0/24网段。

6.  主路由出现故障后，20.1.1.0/24网段内的主机仍然可以与30.1.1.0/24网段内的主机通信。

![](./Media//image5.png)


7.  Switch B上的显示信息与Switch
    A类似。主路由出现故障后，30.1.1.0/24网段内的主机仍然可以与20.1.1.0/24网段内的主机通信。

![](./Media//image6.png)

