# MPLS L2VPN BGP PW配置举例

## 需求：

用户网络有若干个站点，希望通过在骨干网上建立BGP
PW，实现站点1与站点2互联，站点1和站点2通过以太网接口的方式接入PE 1和PE
2。

## 实验步骤：

1.  在MPLS骨干网上配置IGP协议，实现骨干网PE和P的互通

2.  在MPLS骨干网上配置MPLS基本能力和MPLS LDP，建立LDP LSP

3.  在PE 1和PE 2之间建立IBGP连接，并配置在二者之间通过BGP发布L2VPN信息。

4.  创建交叉连接组，在交叉连接组内创建交叉连接，将内网接口与此交叉连接关联，并在交叉连接内创建BGP
    PW，以便将AC和PW关联。

## 测试结果：

在PE 1上查看PW信息，可以看到建立了一条BGP PW。

![](./Media//image1.png)


在PE 2上也可以看到BGP PW的信息。

![](./Media//image2.png)


CE 1与CE 2之间能够ping通。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
